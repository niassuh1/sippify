import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glassbean/constants.dart';
import 'package:glassbean/services/coffee_provider.dart';
import 'package:glassbean/services/count_down_provider.dart';
import 'package:glassbean/widgets/brew_bars.dart';
import 'package:glassbean/widgets/custom_icon_button.dart';
import 'package:glassbean/widgets/description_panel.dart';
import 'package:glassbean/widgets/dope_panel.dart';

class CoffeeMakerScreen extends ConsumerWidget {
  CoffeeMakerScreen({Key? key}) : super(key: key);

  void initialize(WidgetRef ref) {
    ref.read(counterProvider).restart();
    ref.read(coffeeMakerProvider.notifier).restart();
    ref.read(counterProvider).pause();
    ref.read(iterationProvider.state).state = 0;
    ref.read(brewAmountProvider.state).state = 0;
  }

  void resume(WidgetRef ref) {
    ref.read(counterProvider).resume();
    ref.read(coffeeMakerProvider.notifier).resume();
  }

  void start(WidgetRef ref) {
    ref.read(counterProvider).start();
    ref.read(coffeeMakerProvider.notifier).start();
  }

  void pause(WidgetRef ref) {
    ref.read(counterProvider).pause();
    ref.read(coffeeMakerProvider.notifier).pause();
  }

  void restart(WidgetRef ref) {
    ref.read(counterProvider).restart();
    ref.read(coffeeMakerProvider.notifier).restart();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            forceElevated: true,
            foregroundColor: Theme.of(context).primaryColor,
            title: const Text(
              'Coffee Maker',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: 24),
              child: Column(
                children: [
                  CircularCountDownTimer(
                    controller: ref.watch(counterProvider),
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    duration: 45,
                    initialDuration: 0,
                    fillColor: Theme.of(context).primaryColor,
                    ringColor: Colors.black.withOpacity(.1),
                    autoStart: false,
                    strokeWidth: 3,
                    isReverse: true,
                    textFormat: CountdownTextFormat.MM_SS,
                    textStyle: const TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w300,
                    ),
                    onComplete: () {
                      if (ref.watch(iterationProvider) <
                          ref.watch(coffeeProvider).brewAmounts.length - 1) {
                        // Increment array iteration value and start if it did not iterate through the whole array
                        ref.read(iterationProvider.state).state++;
                        start(ref);
                      } else {
                        restart(ref);
                        pause(ref);
                        ref.read(iterationProvider.state).state = 0;
                        ref.read(brewAmountProvider.state).state = 0;
                      }
                    },
                    onStart: () {
                      ref.read(brewAmountProvider.state).state += ref
                          .watch(coffeeProvider)
                          .brewAmounts[ref.read(iterationProvider)];
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconButton(
                        icon: ref.watch(coffeeMakerProvider).timerPaused
                            ? Icons.play_arrow
                            : Icons.pause,
                        onPressed: () {
                          if (ref.watch(coffeeMakerProvider).timerPaused) {
                            // If time already started then resume, otherwise start
                            if (ref.read(coffeeMakerProvider).timerStarted) {
                              resume(ref);
                            } else {
                              start(ref);
                            }
                          } else {
                            pause(ref);
                          }
                        },
                      ),
                      const SizedBox(
                        width: 32,
                      ),
                      CustomIconButton(
                          icon: Icons.restart_alt_rounded,
                          onPressed: () {
                            // Restart everything
                            initialize(ref);
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    '${ref.watch(brewAmountProvider).toStringAsFixed(1)} ml',
                    style: const TextStyle(
                        fontSize: 48, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const BrewBars(),
                  const SizedBox(
                    height: 24,
                  ),
                  DopePanel(
                    headline: 'Description',
                    headlineSize: HeadlineSize.Small,
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DescriptionPanel(
                            panelStyle: DescriptionPanelStyle.Style2,
                            title: 'Weight',
                            description: '${ref.watch(coffeeProvider).weight}g',
                          ),
                          const VerticalDivider(
                            color: Colors.black12,
                            thickness: 1,
                          ),
                          DescriptionPanel(
                            panelStyle: DescriptionPanelStyle.Style2,
                            title: 'Sweetness',
                            description:
                                ref.watch(coffeeProvider).sweetnessText,
                          ),
                          const VerticalDivider(
                            color: Colors.black12,
                            thickness: 1,
                          ),
                          DescriptionPanel(
                            panelStyle: DescriptionPanelStyle.Style2,
                            title: 'Strength',
                            description: ref.watch(coffeeProvider).strengthText,
                          ),
                          const VerticalDivider(
                            color: Colors.black12,
                            thickness: 1,
                          ),
                          DescriptionPanel(
                            panelStyle: DescriptionPanelStyle.Style2,
                            title: 'Total',
                            description:
                                '${ref.watch(coffeeProvider).fullWaterWeight}ml',
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
