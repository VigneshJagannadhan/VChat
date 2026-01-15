import 'dart:ui';

import 'package:vignesh_project_01/core/constants/app_enums.dart';

extension SupportedLocalesX on SupportedLocales {
  Locale get locale {
    switch (this) {
      case SupportedLocales.en:
        return const Locale('en');
      case SupportedLocales.es:
        return const Locale('es');
    }
  }

  String get label {
    switch (this) {
      case SupportedLocales.en:
        return 'English';
      case SupportedLocales.es:
        return 'Español';
    }
  }

  static SupportedLocales fromLocale(Locale locale) {
    switch (locale.languageCode) {
      case 'es':
        return SupportedLocales.es;
      case 'en':
      default:
        return SupportedLocales.en;
    }
  }
}
