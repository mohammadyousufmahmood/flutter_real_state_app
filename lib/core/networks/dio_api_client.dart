import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_app/core/networks/api_client.dart';
import 'package:dio/dio.dart';
import 'package:state_app/core/networks/dio_exception_mapper.dart';

class DioApiClient implements ApiClient {
  final Dio _dio;

  DioApiClient(this._dio);



  @override
  Future<T?> get<T>(String path, {Map<String, Object?>? queryParameters}) {

    return _run(() => _dio.get<T>(path, queryParameters: queryParameters));

  }

  @override
  Future<T?> post<T>(String path, {Object? body}) {
    return _run(() => _dio.post<T>(path, data: body));
  }

  @override
  Future<T?> put<T>(String path, {Object? body}) {

    return _run(() => _dio.put<T>(path, data: body));
  }

  @override
  Future<T?> delete<T>(String path, {Object? body}) {
    return _run(() => _dio.delete<T>(path, data: body));
  }

  Future<T?> _run<T>(Future<Response<T>> Function() request) async {
    try {
      final response = await request();
      return response.data;
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }
}

final apiClientProvider = Provider<ApiClient>((ref) {
  throw StateError('apiClientProvider must be overridden during bootstrap.');
});