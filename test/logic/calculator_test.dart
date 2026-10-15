import 'package:flutter_test/flutter_test.dart';
import 'package:calc_web/logic/calculator.dart';

void main() {
  group('Calculator tests', () {
    test('Addition: 2 + 3 = 5', () {
      final result = calculate('2', '+', '3');
      expect(result, isA<CalcSuccess>());
      expect((result as CalcSuccess).value, equals(5.0));
    });

    test('Subtraction: 10 - 4 = 6', () {
      final result = calculate('10', '-', '4');
      expect(result, isA<CalcSuccess>());
      expect((result as CalcSuccess).value, equals(6.0));
    });

    test('Multiplication: 3 * 7 = 21', () {
      final result = calculate('3', '*', '7');
      expect(result, isA<CalcSuccess>());
      expect((result as CalcSuccess).value, equals(21.0));
    });

    test('Division: 20 / 4 = 5', () {
      final result = calculate('20', '/', '4');
      expect(result, isA<CalcSuccess>());
      expect((result as CalcSuccess).value, equals(5.0));
    });

    test('Division by zero', () {
      final result = calculate('10', '/', '0');
      expect(result, isA<CalcFailure>());
      expect((result as CalcFailure).message, contains('Деление на ноль'));
    });

    test('Invalid number in parameter a', () {
      final result = calculate('abc', '+', '5');
      expect(result, isA<CalcFailure>());
    });

    test('Unknown operation', () {
      final result = calculate('5', '%', '3');
      expect(result, isA<CalcFailure>());
    });

    test('Null parameters', () {
      final result = calculate(null, '+', '5');
      expect(result, isA<CalcFailure>());
    });

    test('Decimal numbers: 2.5 + 3.7 = 6.2', () {
      final result = calculate('2.5', '+', '3.7');
      expect(result, isA<CalcSuccess>());
      expect((result as CalcSuccess).value, closeTo(6.2, 0.0001));
    });

    test('Comma as decimal separator', () {
      final result = calculate('2,5', '+', '3,7');
      expect(result, isA<CalcSuccess>());
      expect((result as CalcSuccess).value, closeTo(6.2, 0.0001));
    });
  });
}