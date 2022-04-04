import 'package:flutter/material.dart';

enum Sweetness { Acidy, Regular, Sweet }

enum Strength { Weak, Regular, Strong }

class Coffee {
  final double? weight;
  final Sweetness sweetness;
  final Strength strength;
  late List<double> brewAmounts = List<double>.filled(totalBrews, 0);

  Coffee({
    this.weight = 15,
    this.sweetness = Sweetness.Regular,
    this.strength = Strength.Regular,
  });

  /// Gets the full weight of the water
  /// which is weight * 3 * 5
  double get fullWaterWeight => weight! * 15;

  /// Gets single brew weight
  /// Which is weight * 3
  double get singleCupWeight => weight! * 3;

  /// Gets total amount of brews
  int get totalBrews {
    switch (strength) {
      case Strength.Weak:
        return 4;
      case Strength.Regular:
        return 5;
      case Strength.Strong:
        return 6;
    }
  }

  /// Gets the first 40% of the overall brews
  /// ![](https://mynewchapterinlife.files.wordpress.com/2020/09/adj-taste-e1601310065997.jpg)
  void _get40Brews() {
    double fortyPercentBrew = singleCupWeight * 2;
    switch (sweetness) {
      case Sweetness.Acidy:
        brewAmounts[0] = fortyPercentBrew * .75;
        brewAmounts[1] = fortyPercentBrew * .25;
        break;
      case Sweetness.Regular:
        brewAmounts[0] = fortyPercentBrew / 2;
        brewAmounts[1] = fortyPercentBrew / 2;
        break;
      case Sweetness.Sweet:
        brewAmounts[0] = fortyPercentBrew * .25;
        brewAmounts[1] = fortyPercentBrew * .75;
        break;
    }
  }

  /// Gets the 60% of the overall brews
  void _get60Brews() {
    double sixtyPercentRemaining = fullWaterWeight * .6;
    switch (strength) {
      case Strength.Weak:
        brewAmounts[2] = sixtyPercentRemaining * .5;
        brewAmounts[3] = sixtyPercentRemaining * .5;
        break;
      case Strength.Regular:
        brewAmounts[2] = singleCupWeight;
        brewAmounts[3] = singleCupWeight;
        brewAmounts[4] = singleCupWeight;
        break;
      case Strength.Strong:
        brewAmounts[2] = sixtyPercentRemaining / 4;
        brewAmounts[3] = sixtyPercentRemaining / 4;
        brewAmounts[4] = sixtyPercentRemaining / 4;
        brewAmounts[5] = sixtyPercentRemaining / 4;
        break;
    }
  }

  List<double> getFullBrew() {
    _get40Brews();
    _get60Brews();
    return this.brewAmounts;
  }
}
