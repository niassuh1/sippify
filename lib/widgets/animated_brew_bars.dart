import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glassbean/constants.dart';
import 'package:glassbean/services/coffee_provider.dart';

class AnimatedBrewBars extends ConsumerWidget {
  const AnimatedBrewBars({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: ref.read(coffeeProvider).getFullBrew().asMap().entries.map((e) {
        double ratio = e.value / ref.read(coffeeProvider).fullWaterWeight;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: MediaQuery.of(context).size.width * ratio - 15,
          curve: Curves.ease,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
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
      }).toList(),
    );
  }
}
