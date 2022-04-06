import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoffeeMaker {
  late bool timerStarted = false;
  late bool timerPaused = true;
  late double currentWaterBrewed = 0;

  CoffeeMaker({
    this.timerStarted = false,
    this.timerPaused = true,
    this.currentWaterBrewed = 0,
  });
}

class CoffeeMakerNotifier extends StateNotifier<CoffeeMaker> {
  CoffeeMakerNotifier() : super(CoffeeMaker());

  void start() {
    state = CoffeeMaker(
        timerStarted: true,
        timerPaused: false,
        currentWaterBrewed: state.currentWaterBrewed);
  }

  void resume() {
    state = CoffeeMaker(
      timerStarted: true,
      timerPaused: false,
      currentWaterBrewed: state.currentWaterBrewed,
    );
  }

  void restart() {
    state = CoffeeMaker();
  }

  void pause() {
    state = CoffeeMaker(
        timerStarted: state.timerStarted,
        timerPaused: true,
        currentWaterBrewed: state.currentWaterBrewed);
  }

  void setWaterAmount(double v) {
    state = CoffeeMaker(
        timerStarted: state.timerStarted,
        timerPaused: this.state.timerPaused,
        currentWaterBrewed: v);
  }
}

final coffeeMakerProvider =
    StateNotifierProvider<CoffeeMakerNotifier, CoffeeMaker>(
        (_) => CoffeeMakerNotifier());
