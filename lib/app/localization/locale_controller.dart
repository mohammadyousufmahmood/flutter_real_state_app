import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_app/core/logging/console_app_logger.dart';
import 'app_locales.dart';
import 'locale_preference.dart';
import 'locale_store.dart';

/// Owns the active app locale and whether the user has confirmed it.
class LocaleController extends Notifier<LocalePreference> {
  @override
  LocalePreference build() => LocalePreference.initial;

  /// Restores a persisted locale during bootstrap.
  ///
  /// Missing values leave English selected in memory but [hasSelected]
  /// false so first launch still shows the language screen. Storage
  /// failures fail open to English with the screen skipped so a broken
  /// store cannot trap the user on onboarding.
  Future<void> restore() async {
    try {
      final languageCode = await ref.read(localeStoreProvider).read();
      if (languageCode == null) {
        state = LocalePreference.initial;
        return;
      }
      state = LocalePreference(
        locale: AppLocales.resolve(languageCode),
        hasSelected: true,
      );
    } catch (error, stackTrace) {
      ref
          .read(appLoggerProvider)
          .error(
            'Locale restoration failed; using English.',
            error: error,
            stackTrace: stackTrace,
          );
      state = const LocalePreference(
        locale: AppLocales.defaultLocale,
        hasSelected: true,
      );
    }
  }

  /// Updates the in-memory locale. Persists only after a confirmed choice
  /// so backing out of first-run selection does not skip the screen later.
  Future<void> select(Locale locale) async {
    final resolved = AppLocales.resolve(locale.languageCode);
    state = LocalePreference(locale: resolved, hasSelected: state.hasSelected);
    if (state.hasSelected) {
      await ref.read(localeStoreProvider).write(resolved.languageCode);
    }
  }

  /// Persists the current locale and marks first-run selection complete.
  Future<void> confirmSelection() async {
    final locale = state.locale;
    await ref.read(localeStoreProvider).write(locale.languageCode);
    state = LocalePreference(locale: locale, hasSelected: true);
  }
}

final localeControllerProvider =
    NotifierProvider<LocaleController, LocalePreference>(LocaleController.new);
