import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:woo_study_case/core/constants/app_strings.dart';
import 'package:woo_study_case/core/exports.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<AppStrings> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'tr'].contains(locale.languageCode);
  }

  @override
  Future<AppStrings> load(Locale locale) {
    appStrings = AppStrings(locale);

    return SynchronousFuture<AppStrings>(appStrings);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppStrings> old) {
    return false;
  }
}
