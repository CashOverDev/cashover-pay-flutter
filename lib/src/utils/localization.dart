import 'dart:ui';

import 'lang.dart';

class CashOverLocalization {
  static final Map<String, Map<String, String>> _languages = {
    "en": en,
    "es": es,
    "fr": fr,
    // add other languages here
  };

  /// Get translated text synchronously
  static String translate(String key, {String? language}) {
    String lang = language ?? PlatformDispatcher.instance.locale.languageCode;
    if (!_languages.containsKey(lang)) lang = 'en';
    return _languages[lang]?[key] ?? _languages['en']?[key] ?? key;
  }
}
