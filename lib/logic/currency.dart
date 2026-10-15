const Map<String, String> currencyNames = {
  'USD': 'Доллар США',
  'EUR': 'Евро',
  'RUB': 'Российский рубль',
  'GBP': 'Британский фунт',
  'JPY': 'Японская иена',
  'CNY': 'Китайский юань',
  'CHF': 'Швейцарский франк',
};

const Map<String, double> exchangeRates = {
  'USD': 1.0,
  'EUR': 0.85,
  'RUB': 92.5,
  'GBP': 0.79,
  'JPY': 149.5,
  'CNY': 7.24,
  'CHF': 0.88,
};

const Map<String, String> currencies = currencyNames;

sealed class ConvertResult {
  const ConvertResult();
}

class ConvertSuccess extends ConvertResult {
  final double value;
  const ConvertSuccess(this.value);
}

class ConvertFailure extends ConvertResult {
  final String message;
  const ConvertFailure(this.message);
}

ConvertResult convertCurrency(String? rawAmount, String? from, String? to) {
  final amount = double.tryParse(rawAmount?.replaceAll(',', '.') ?? '');

  if (amount == null) {
    return const ConvertFailure('Некорректная сумма');
  }

  if (from == null || to == null) {
    return const ConvertFailure('Не указаны валюты');
  }

  final fromRate = exchangeRates[from];
  final toRate = exchangeRates[to];

  if (fromRate == null || toRate == null) {
    return const ConvertFailure('Неизвестная валюта');
  }

  if (from == to) {
    return ConvertSuccess(amount);
  }

  final amountInUSD = amount / fromRate;
  final result = amountInUSD * toRate;

  return ConvertSuccess(result);
}

String getCurrencyName(String code) {
  return currencyNames[code] ?? code;
}