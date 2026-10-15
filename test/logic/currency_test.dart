import 'package:flutter_test/flutter_test.dart';
import 'package:calc_web/logic/currency.dart';

void main() {
  group('Currency converter tests', () {
    test('USD to EUR conversion', () {
      final result = convertCurrency('100', 'USD', 'EUR');
      expect(result, isA<ConvertSuccess>());
      expect((result as ConvertSuccess).value, closeTo(85.0, 0.01));
    });

    test('EUR to USD conversion', () {
      final result = convertCurrency('85', 'EUR', 'USD');
      expect(result, isA<ConvertSuccess>());
      expect((result as ConvertSuccess).value, closeTo(100.0, 0.01));
    });

    test('USD to RUB conversion', () {
      final result = convertCurrency('1', 'USD', 'RUB');
      expect(result, isA<ConvertSuccess>());
      expect((result as ConvertSuccess).value, closeTo(92.5, 0.01));
    });

    test('Same currency conversion', () {
      final result = convertCurrency('100', 'USD', 'USD');
      expect(result, isA<ConvertSuccess>());
      expect((result as ConvertSuccess).value, equals(100.0));
    });

    test('Invalid amount', () {
      final result = convertCurrency('abc', 'USD', 'EUR');
      expect(result, isA<ConvertFailure>());
    });

    test('Null amount', () {
      final result = convertCurrency(null, 'USD', 'EUR');
      expect(result, isA<ConvertFailure>());
    });

    test('Unknown currency', () {
      final result = convertCurrency('100', 'XXX', 'EUR');
      expect(result, isA<ConvertFailure>());
    });

    test('Null currency parameter', () {
      final result = convertCurrency('100', null, 'EUR');
      expect(result, isA<ConvertFailure>());
    });

    test('Decimal amount', () {
      final result = convertCurrency('100.50', 'USD', 'EUR');
      expect(result, isA<ConvertSuccess>());
      expect((result as ConvertSuccess).value, closeTo(85.425, 0.01));
    });

    test('Comma as decimal separator', () {
      final result = convertCurrency('100,50', 'USD', 'EUR');
      expect(result, isA<ConvertSuccess>());
      expect((result as ConvertSuccess).value, closeTo(85.425, 0.01));
    });
  });

  group('Currency names', () {
    test('Get currency name for USD', () {
      expect(getCurrencyName('USD'), equals('Доллар США'));
    });

    test('Get currency name for RUB', () {
      expect(getCurrencyName('RUB'), equals('Российский рубль'));
    });

    test('Get currency name for unknown code', () {
      expect(getCurrencyName('XXX'), equals('XXX'));
    });
  });
}