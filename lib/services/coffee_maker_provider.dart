import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glassbean/models/coffee.dart';

class CoffeeNotifier extends StateNotifier<Coffee> {
  CoffeeNotifier() : super(Coffee(strength: Strength.Weak));

  void setWeight(double v) {
    state =
        Coffee(weight: v, sweetness: state.sweetness, strength: state.strength);
  }

  get weight => state.weight;

  void setSweetness(Sweetness v) {
    state =
        Coffee(weight: state.weight, sweetness: v, strength: state.strength);
  }

  get sweetness => state.sweetness;

  void setStrength(Strength v) {
    state =
        Coffee(weight: state.weight, sweetness: state.sweetness, strength: v);
  }

  get strength => state.strength;
}

final coffeeProvider =
    StateNotifierProvider<CoffeeNotifier, Coffee>((_) => CoffeeNotifier());
