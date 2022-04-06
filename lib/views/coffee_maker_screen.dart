import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glassbean/constants.dart';
import 'package:glassbean/services/count_down_provider.dart';
import 'package:glassbean/widgets/custom_icon_button.dart';

class CoffeeMakerScreen extends ConsumerWidget {
  CoffeeMakerScreen({Key? key}) : super(key: key);

  late CountDownController _countDownController = CountDownController();

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
                    controller: _countDownController,
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    duration: 45,
                    fillColor: Theme.of(context).primaryColor,
                    ringColor: Colors.black.withOpacity(.1),
                    autoStart: false,
                    strokeWidth: 3,
                    isReverse: true,
                    textStyle: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(
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
                              _countDownController.resume();
                              ref.read(coffeeMakerProvider.notifier).resume();
                            } else {
                              _countDownController.start();
                              ref.read(coffeeMakerProvider.notifier).start();
                            }
                          } else {
                            _countDownController.pause();
                            ref.read(coffeeMakerProvider.notifier).pause();
                          }
                        },
                      ),
                      SizedBox(
                        width: 32,
                      ),
                      CustomIconButton(
                          icon: Icons.restart_alt_rounded,
                          onPressed: () {
                            _countDownController.restart();
                            ref.read(coffeeMakerProvider.notifier).restart();
                            _countDownController.pause();
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
