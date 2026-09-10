import 'package:flutter/widgets.dart';

import 'language_flag_svgs.dart';

abstract final class AppLocales {
  static const Locale english = Locale('en');
  static const Locale pashto = Locale('ps');
  static const Locale dari = Locale('fa');

  static const Locale defaultLocale = english;

  static const List<Locale> supported = <Locale>[english, pashto, dari];

  static const List<AppLanguage> languages = <AppLanguage>[
    AppLanguage(
      locale: dari,
      nativeName: 'دری',
      englishName: 'Dari',
      flagSvg: LanguageFlagSvgs.af,
    ),
    AppLanguage(
      locale: pashto,
      nativeName: 'پښتو',
      englishName: 'Pashto',
      flagSvg: LanguageFlagSvgs.af,
    ),
    AppLanguage(
      locale: english,
      nativeName: 'English',
      englishName: 'English',
      flagSvg: LanguageFlagSvgs.gb,
    ),
  ];

  static bool isRtl(Locale locale) =>
      locale.languageCode == pashto.languageCode ||
      locale.languageCode == dari.languageCode;

  static TextDirection textDirectionOf(Locale locale) =>
      isRtl(locale) ? TextDirection.rtl : TextDirection.ltr;

  /// Maps a persisted language code to a supported locale, falling back
  /// to [defaultLocale] for unknown or missing values.
  static Locale resolve(String? languageCode) {
    if (languageCode == null) {
      return defaultLocale;
    }
    for (final language in languages) {
      if (language.locale.languageCode == languageCode) {
        return language.locale;
      }
    }
    return defaultLocale;
  }
}

/// Display metadata for one supported language.
///
/// Native names stay in their own script so the selection screen remains
/// recognizable before a locale has been applied.
class AppLanguage {
  const AppLanguage({
    required this.locale,
    required this.nativeName,
    required this.englishName,
    required this.flagSvg,
  });

  final Locale locale;
  final String nativeName;
  final String englishName;
  final String flagSvg;
}
