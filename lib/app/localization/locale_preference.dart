import 'package:flutter/widgets.dart';

import 'app_locales.dart';

/// User-facing locale plus whether the user has confirmed a choice.
///
/// [locale] is always a supported value (English until the user picks
/// another). [hasSelected] is false on first launch so the router can
/// require the language screen before sign-in / browsing listings.
class LocalePreference {
  const LocalePreference({required this.locale, required this.hasSelected});

  final Locale locale;
  final bool hasSelected;

  static const LocalePreference initial = LocalePreference(
    locale: AppLocales.defaultLocale,
    hasSelected: false,
  );

  @override
  bool operator ==(Object other) {
    return other is LocalePreference &&
        other.locale == locale &&
        other.hasSelected == hasSelected;
  }

  @override
  int get hashCode => Object.hash(locale, hasSelected);
}
