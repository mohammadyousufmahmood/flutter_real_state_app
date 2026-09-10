import 'package:flutter/widgets.dart';

import '../../l10n/generated/app_localizations.dart';
import 'fallback_localizations.dart';

export '../../l10n/generated/app_localizations.dart';
export 'app_locales.dart';
export 'locale_controller.dart';
export 'locale_preference.dart';

/// Convenience accessor for localized strings.
extension LocalizationX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

/// App strings plus Material/Cupertino fallbacks for locales Flutter
/// does not ship catalogs for (currently Pashto).
List<LocalizationsDelegate<dynamic>> get appLocalizationDelegates =>
    <LocalizationsDelegate<dynamic>>[
      ...AppLocalizations.localizationsDelegates,
      const FallbackMaterialLocalizationsDelegate(),
      const FallbackCupertinoLocalizationsDelegate(),
      const FallbackWidgetsLocalizationsDelegate(),
    ];
