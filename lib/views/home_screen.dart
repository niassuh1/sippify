import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glassbean/constants.dart';
import 'package:glassbean/services/coffee_maker_provider.dart';
import 'package:glassbean/widgets/custom_sliver_appbar.dart';
import 'package:glassbean/widgets/description_panel.dart';
import 'package:glassbean/widgets/dope_panel.dart';
import 'package:glassbean/widgets/option_tabs.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../models/coffee.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 60,
        color: Theme.of(context).primaryColor,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            splashColor: Colors.white.withOpacity(.1),
            highlightColor: Colors.white.withOpacity(.2),
            child: const Center(
              child: Text(
                'Start Making',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(slivers: [
          const CustomSliverAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 24,
                  left: defaultPadding,
                  right: defaultPadding,
                  bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Dope panel for weight
                  DopePanel(
                    headline: 'Weight',
                    child: Column(
                      children: [
                        Text(
                          '${ref.watch(coffeeProvider).weight} g',
                          style: const TextStyle(fontSize: 18),
                        ),
                        SfSlider(
                          value: ref.watch(coffeeProvider.notifier).weight,
                          onChanged: (e) {
                            ref.read(coffeeProvider.notifier).setWeight(e);
                          },
                          showTicks: true,
                          min: 10,
                          stepSize: 1,
                          interval: 10,
                          max: 50,
                          enableTooltip: true,
                          showLabels: true,
                          labelPlacement: LabelPlacement.betweenTicks,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 42),

                  // Dope panel for sweetness
                  DopePanel(
                      headline: 'Sweetness',
                      child: OptionTabs(
                        value: getSweetness(ref),
                        onTab: (e) {
                          print(e);
                          ref
                              .read(coffeeProvider.notifier)
                              .setSweetness(sweetnessChange(e.toInt()));
                        },
                        tabs: [Text('Acidy'), Text('Regular'), Text('Sweet')],
                      )),

                  const SizedBox(height: 42),

                  // Dope panel for strength
                  DopePanel(
                    headline: 'Strength',
                    child: Column(
                      children: [
                        OptionTabs(
                          onTab: (e) {
                            ref
                                .read(coffeeProvider.notifier)
                                .setStrength(strengthChange(e.toInt()));
                          },
                          value: getStrength(ref),
                          tabs: [
                            Text('Weak'),
                            Text('Regular'),
                            Text('Strong'),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 42,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DescriptionPanel(
                          title: 'Total',
                          description:
                              '${ref.read(coffeeProvider).fullWaterWeight.toInt().toString()} ml',
                        ),
                        const VerticalDivider(
                          color: Colors.black26,
                          thickness: 1,
                        ),
                        DescriptionPanel(
                          title: 'Sweetness',
                          description: ref.read(coffeeProvider).sweetnessText,
                        ),
                        const VerticalDivider(
                          color: Colors.black26,
                          thickness: 1,
                        ),
                        DescriptionPanel(
                          title: 'Strength',
                          description: ref.read(coffeeProvider).strengthText,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 42,
                  ),
                  // Displays the brewing process
                  // TODO: Optimize this shit code
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: ref
                          .read(coffeeProvider)
                          .getFullBrew()
                          .asMap()
                          .entries
                          .map((e) {
                        double ratio =
                            e.value / ref.read(coffeeProvider).fullWaterWeight;

                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          width: MediaQuery.of(context).size.width * ratio - 15,
                          curve: Curves.ease,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                child: Container(
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: colorFade[e.key],
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                  children: [
                                    TextSpan(
                                      text: e.value.toStringAsFixed(1),
                                    ),
                                    const TextSpan(
                                      text: '\nml',
                                      style: TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }).toList())
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }

  int getSweetness(WidgetRef ref) {
    switch (ref.watch(coffeeProvider).sweetness) {
      case Sweetness.Acidy:
        return 0;
      case Sweetness.Regular:
        return 1;
      case Sweetness.Sweet:
        return 2;
      default:
        return 1;
    }
  }

  int getStrength(WidgetRef ref) {
    switch (ref.watch(coffeeProvider).strength) {
      case Strength.Weak:
        return 0;
      case Strength.Regular:
        return 1;
      case Strength.Strong:
        return 2;
      default:
        return 1;
    }
  }

  Sweetness sweetnessChange(int e) {
    switch (e) {
      case 0:
        return Sweetness.Acidy;
      case 1:
        return Sweetness.Regular;
      case 2:
        return Sweetness.Sweet;
      default:
        return Sweetness.Regular;
    }
  }

  Strength strengthChange(int e) {
    switch (e) {
      case 0:
        return Strength.Weak;
      case 1:
        return Strength.Regular;
      case 2:
        return Strength.Strong;
      default:
        return Strength.Regular;
    }
  }
}
