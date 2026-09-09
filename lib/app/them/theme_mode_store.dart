import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_app/core/storages/secure_storage.dart';


class ThemeModeStore {
  const ThemeModeStore(this._storage);

  static const String storageKey = 'app.themeMode';

  static const String lightValue = 'light';
  static const String darkValue = 'dark';
  static const String systemValue = 'system';

  final SecureStorage _storage;

  Future<String?> read() => _storage.read( key : storageKey);

  Future<void> write(ThemeMode mode) =>
      _storage.write( key : storageKey, value : encode(mode));

  static String encode(ThemeMode mode) {
    return switch (mode) {
      ThemeMode.light => lightValue,
      ThemeMode.dark => darkValue,
      ThemeMode.system => systemValue,
    };
  }

  static ThemeMode decode(String? value) {
    return switch (value) {
      lightValue => ThemeMode.light,
      darkValue => ThemeMode.dark,
      systemValue => ThemeMode.system,
      _ => ThemeMode.system,
    };
  }
}

final themeModeStoreProvider = Provider<ThemeModeStore>(
  (ref) => ThemeModeStore(ref.watch(secureStorageProvider)),
);
