import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_app/core/logging/console_app_logger.dart';
import 'theme_mode_store.dart';

/// Owns the persisted appearance preference (light, dark, or system).
class ThemeController extends Notifier<ThemeMode> {
  @override
  ThemeMode build() => ThemeMode.system;

  /// Restores a persisted theme during bootstrap.
  ///
  /// Missing or unknown values leave the app on [ThemeMode.system]. Storage
  /// failures fail open to system so a broken store cannot trap the user
  /// in an unexpected appearance.
  Future<void> restore() async {
    try {
      final stored = await ref.read(themeModeStoreProvider).read();
      state = ThemeModeStore.decode(stored);
    } catch (error, stackTrace) {
      ref
          .read(appLoggerProvider)
          .error(
            'Theme restoration failed; using system appearance.',
            error: error,
            stackTrace: stackTrace,
          );
      state = ThemeMode.system;
    }
  }

  /// Updates and persists the appearance preference.
  Future<void> select(ThemeMode mode) async {
    state = mode;
    await ref.read(themeModeStoreProvider).write(mode);
  }
}

final themeControllerProvider = NotifierProvider<ThemeController, ThemeMode>(
  ThemeController.new,
);
