import 'package:flutter/material.dart';

class AppStrings {
  final Locale locale;

  static AppStrings? _instance;
  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'all_tab': 'All',
      'future_tab': 'Future',
      'last_price': 'Last Price',
      'no_data': 'No results found',
      'search': 'Search',
      'spot_tab': 'Spot',
      'symbol': 'Symbol',
      'title': 'Woo Study Case',
      'type_in': 'type in ...',
      'volume': 'Volume',
    },
    'tr': {
      'all_tab': 'Tüm Liste',
      'future_tab': 'Vadeli',
      'last_price': 'Son Fiyat',
      'no_data': 'Sonuç bulunamadı',
      'search': 'Arama',
      'spot_tab': 'Spot',
      'symbol': 'Sembol',
      'title': 'Woo Study Case',
      'type_in': 'arayın...',
      'volume': 'Hacim',
    },
  };

  AppStrings(this.locale);

  static AppStrings get instance => _instance ?? AppStrings(const Locale('en'));

  String get futureTab => _getString('future_tab');
  String get allTab => _getString('all_tab');
  String get lastPrice => _getString('last_price');
  String get noData => _getString('no_data');
  String get search => _getString('search');
  String get spotTab => _getString('spot_tab');
  String get symbol => _getString('symbol');
  String get title => _getString('title');
  String get typeIn => _getString('type_in');
  String get volume => _getString('volume');

  String _getString(String key) =>
      _localizedValues[locale.languageCode]?.entries.singleWhere((entry) => entry.key == key).value ?? '';
}
