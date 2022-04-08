import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:glassbean/constants.dart';
import 'package:glassbean/services/coffee_provider.dart';
import 'package:glassbean/services/count_down_provider.dart';

class BrewBars extends ConsumerWidget {
  const BrewBars({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(.08),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: ref
                .watch(coffeeProvider)
                .getFullBrew()
                .asMap()
                .entries
                .map((e) {
              double ratio = e.value / ref.read(coffeeProvider).singleCupWeight;
              return Expanded(
                flex: ratio.ceil(),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  height: 15,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                      color: ref.watch(iterationProvider) == e.key
                          ? Theme.of(context).primaryColor
                          : Colors.black26,
                      borderRadius: BorderRadius.circular(4)),
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              ref.watch(coffeeProvider).getFullBrew().asMap().entries.map((e) {
            double ratio = e.value / ref.read(coffeeProvider).singleCupWeight;
            return Expanded(
              flex: ratio.ceil(),
              child: Text(
                '${e.value.toStringAsFixed(1)} ml',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
