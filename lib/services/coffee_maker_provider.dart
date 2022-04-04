import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glassbean/models/coffee.dart';

/// Provider for the weight
final weightProvider = StateProvider<double>((_) => 15.0);

/// Provider for the sweetness
final sweetnessProvider = StateProvider<Sweetness>((_) => Sweetness.Regular);

/// Provider for the sweetness
final strengthProvider = StateProvider<Strength>((_) => Strength.Regular);

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
