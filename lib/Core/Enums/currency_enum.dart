import 'package:sintir/locale_keys.dart';

enum Currency {
  egp,
  usd,
  eur,
}

extension CurrencyExtension on Currency {
  String get code {
    switch (this) {
      case Currency.egp:
        return 'EGP';
      case Currency.usd:
        return 'USD';
      case Currency.eur:
        return 'EUR';
    }
  }

  String get symbol {
    switch (this) {
      case Currency.egp:
        return LocaleKeys.currencyEgpSymbol;
      case Currency.usd:
        return '\$';
      case Currency.eur:
        return '€';
    }
  }

  String get name {
    switch (this) {
      case Currency.egp:
        return LocaleKeys.currencyEGP;
      case Currency.usd:
        return LocaleKeys.currencyUsd;
      case Currency.eur:
        return LocaleKeys.currencyEur;
    }
  }
}

Currency currencyFromString(String currencyString) {
  switch (currencyString.toUpperCase()) {
    case 'EGP':
      return Currency.egp;
    case 'USD':
      return Currency.usd;
    case 'EUR':
      return Currency.eur;
    default:
      throw ArgumentError('Invalid currency string: $currencyString');
  }
}
