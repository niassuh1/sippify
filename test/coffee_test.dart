import 'package:flutter_test/flutter_test.dart';
import 'package:glassbean/models/coffee.dart';

void main() {
  test(
      '20g regular sweetness and regular strength coffee should be brewed correctly',
      () {
    Coffee _coffee1 = Coffee(weight: 20);

    expect(_coffee1.getFullBrew(), [60, 60, 60, 60, 60]);
  });

  test('30g sweetness and regular strength coffee should be brewed correctly',
      () {
    Coffee _coffee1 = Coffee(weight: 30, sweetness: Sweetness.Sweet);

    expect(_coffee1.getFullBrew(), [62, 117, 90, 90, 90]);
  });
  test('30g sweetness and strong coffee should be brewed correctly', () {
    Coffee _coffee1 = Coffee(
        weight: 30, sweetness: Sweetness.Sweet, strength: Strength.Strong);

    expect(_coffee1.getFullBrew(), [45, 135, 67.5, 67.5, 67.5, 67.5]);
  });
  test('25g acidy and regular strength coffee should be brewed correctly', () {
    Coffee _coffee1 = Coffee(weight: 25, sweetness: Sweetness.Acidy);

    expect(_coffee1.getFullBrew(), [112.5, 37.5, 75, 75, 75]);
  });
}
