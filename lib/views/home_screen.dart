import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glassbean/constants.dart';
import 'package:glassbean/services/coffee_maker_provider.dart';
import 'package:glassbean/widgets/description_panel.dart';
import 'package:glassbean/widgets/dope_panel.dart';
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
            child: Center(
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
          SliverAppBar(
            foregroundColor: Colors.black38,
            forceElevated: true,
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.tune),
                splashRadius: 20,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_vert_rounded),
                splashRadius: 20,
              ),
            ],
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              titlePadding: EdgeInsets.only(bottom: 7, left: defaultPadding),
              title: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(.75),
                  borderRadius: BorderRadius.circular(7),
                ),
                alignment: Alignment.center,
                child: Text(
                  'F',
                  style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Dope panel for weight
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: DopePanel(
                      headline: 'Weight',
                      child: Column(
                        children: [
                          Text(
                            '${ref.watch(coffeeProvider).weight} g',
                            style: TextStyle(fontSize: 18),
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
                  ),
                  SizedBox(height: 42),

                  // Dope panel for sweetness
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: DopePanel(
                      headline: 'Sweetness',
                      child: SfSlider(
                        value: getSweetness(ref),
                        min: 1,
                        max: 3,
                        onChanged: (value) {
                          switch (value.toInt()) {
                            case 1:
                              ref
                                  .read(coffeeProvider.notifier)
                                  .setSweetness(Sweetness.Acidy);
                              break;
                            case 2:
                              ref
                                  .read(coffeeProvider.notifier)
                                  .setSweetness(Sweetness.Regular);
                              break;
                            case 3:
                              ref
                                  .read(coffeeProvider.notifier)
                                  .setSweetness(Sweetness.Sweet);
                              break;
                          }
                        },
                        showTicks: true,
                        interval: 1,
                        enableTooltip: true,
                        showLabels: true,
                        tooltipTextFormatterCallback:
                            (dynamic value, String text) {
                          return getStrengthLabel(value.toInt());
                        },
                        labelFormatterCallback: (dynamic value, String text) {
                          return getSweetnessLabel(value.toInt());
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 42),

                  // Dope panel for strength
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: DopePanel(
                      headline: 'Strength',
                      child: Column(
                        children: [
                          SfSlider(
                            value: getStrength(ref),
                            onChanged: (e) {
                              switch (e.toInt()) {
                                case 1:
                                  ref
                                      .read(coffeeProvider.notifier)
                                      .setStrength(Strength.Weak);
                                  break;
                                case 2:
                                  ref
                                      .read(coffeeProvider.notifier)
                                      .setStrength(Strength.Regular);
                                  Strength.Regular;
                                  break;
                                case 3:
                                  ref
                                      .read(coffeeProvider.notifier)
                                      .setStrength(Strength.Strong);
                                  Strength.Strong;
                                  break;
                              }
                            },
                            showTicks: true,
                            min: 1,
                            stepSize: 1,
                            interval: 1,
                            max: 3,
                            enableTooltip: true,
                            showLabels: true,
                            tooltipTextFormatterCallback:
                                (dynamic value, String text) {
                              return getStrengthLabel(value.toInt());
                            },
                            labelFormatterCallback:
                                (dynamic value, String text) {
                              return getStrengthLabel(value.toInt());
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 42,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DescriptionPanel(
                            title: 'Total',
                            description:
                                '${ref.read(coffeeProvider).fullWaterWeight.toInt().toString()} ml',
                          ),
                          VerticalDivider(
                            color: Colors.black26,
                            thickness: 1,
                          ),
                          DescriptionPanel(
                            title: 'Sweetness',
                            description: ref.read(coffeeProvider).sweetnessText,
                          ),
                          VerticalDivider(
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
                  ),
                  SizedBox(
                    height: 42,
                  ),
                  // Displays the brewing process
                  // TODO: Optimize this shit code
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: ref
                          .read(coffeeProvider)
                          .getFullBrew()
                          .asMap()
                          .entries
                          .map((e) {
                        double ratio =
                            e.value / ref.read(coffeeProvider).fullWaterWeight;

                        return Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              child: AnimatedContainer(
                                alignment: Alignment.center,
                                duration: Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                                height: 20,
                                width:
                                    MediaQuery.of(context).size.width * ratio -
                                        25,
                                decoration: BoxDecoration(
                                  color: colorFade[e.key],
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              e.value.toStringAsFixed(1),
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                          ],
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

  String getSweetnessLabel(int v) {
    switch (v) {
      case 1:
        return 'Acidy';
      case 2:
        return 'Regular';
      case 3:
        return 'Sweet';
      default:
        return '';
    }
  }

  String getStrengthLabel(int v) {
    switch (v) {
      case 1:
        return 'Weak';
      case 2:
        return 'Regular';
      case 3:
        return 'Strong';
      default:
        return '';
    }
  }

  int getSweetness(WidgetRef ref) {
    switch (ref.watch(coffeeProvider).sweetness) {
      case Sweetness.Acidy:
        return 1;
      case Sweetness.Regular:
        return 2;
      case Sweetness.Sweet:
        return 3;
      default:
        return 2;
    }
  }

  int getStrength(WidgetRef ref) {
    switch (ref.watch(coffeeProvider).strength) {
      case Strength.Weak:
        return 1;
      case Strength.Regular:
        return 2;
      case Strength.Strong:
        return 3;
      default:
        return 2;
    }
  }
}
