import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Flutter ships no Material/Cupertino/Widgets catalogs for Pashto.
///
/// These delegates keep widget chrome (tooltips, reorder labels) available
/// while app copy comes from `app_ps.arb`. Widgets fallback is RTL so
/// scaffold direction matches Pashto.
///
/// Dari (`fa`, Persian) needs no entry here — Flutter ships native
/// Material/Cupertino/Widgets localizations for it already.
const Set<String> _fallbackLanguageCodes = <String>{'ps'};

class FallbackMaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      _fallbackLanguageCodes.contains(locale.languageCode);

  @override
  Future<MaterialLocalizations> load(Locale locale) {
    return DefaultMaterialLocalizations.load(const Locale('en'));
  }

  @override
  bool shouldReload(FallbackMaterialLocalizationsDelegate old) => false;
}

class FallbackCupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      _fallbackLanguageCodes.contains(locale.languageCode);

  @override
  Future<CupertinoLocalizations> load(Locale locale) {
    return DefaultCupertinoLocalizations.load(const Locale('en'));
  }

  @override
  bool shouldReload(FallbackCupertinoLocalizationsDelegate old) => false;
}

class FallbackWidgetsLocalizationsDelegate
    extends LocalizationsDelegate<WidgetsLocalizations> {
  const FallbackWidgetsLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      _fallbackLanguageCodes.contains(locale.languageCode);

  @override
  Future<WidgetsLocalizations> load(Locale locale) {
    return Future<WidgetsLocalizations>.value(
      const _RtlEnglishWidgetsLocalizations(),
    );
  }

  @override
  bool shouldReload(FallbackWidgetsLocalizationsDelegate old) => false;
}

class _RtlEnglishWidgetsLocalizations extends DefaultWidgetsLocalizations {
  const _RtlEnglishWidgetsLocalizations();

  @override
  TextDirection get textDirection => TextDirection.rtl;
}
