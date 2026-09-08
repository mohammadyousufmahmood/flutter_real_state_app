abstract interface class ApiClient {
  Future<T?> get<T>(String path, {Map<String, Object?>? queryParameters});

  Future<T?> post<T>(String path, {Object? body});

  Future<T?> put<T>(String path, {Object? body});

  Future<T?> delete<T>(String path, {Object? body});
}