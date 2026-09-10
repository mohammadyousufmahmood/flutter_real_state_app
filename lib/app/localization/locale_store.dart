import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_app/core/storages/secure_storage.dart';


/// Persists the selected language code.
///
/// Uses [SecureStorage] so no extra persistence dependency is introduced.
/// The value is not sensitive; this is a storage-channel choice, not a
/// security requirement.
class LocaleStore {
  const LocaleStore(this._storage);

  static const String storageKey = 'app.locale';

  final SecureStorage _storage;

  Future<String?> read() => _storage.read(key: storageKey);

  Future<void> write(String languageCode) =>
      _storage.write(key: storageKey, value: languageCode);
}

final localeStoreProvider = Provider<LocaleStore>(
  (ref) => LocaleStore(ref.watch(secureStorageProvider)),
);
