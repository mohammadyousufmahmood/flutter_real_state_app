import 'package:dio/dio.dart';
import 'package:state_app/core/logging/app_logger.dart';
import 'package:state_app/core/securities/redaction.dart';

class NetworkLoggingInterceptor extends Interceptor {

  NetworkLoggingInterceptor(this._logger);
  final AppLogger _logger;


  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
  
    _logger.debug(
      '----> ${options.method} ${options.baseUrl}${options.path}'
      'headers: ${redactHeaders(options.headers)}'
    );
    handler.next(options);
    }

  @override
  void onResponse(Response<Object?> response, ResponseInterceptorHandler handler) {
    _logger.debug(
      '<---- ${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.uri} ${response.requestOptions.path}'
      'headers: ${redactHeaders(response.headers.map)}'
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.error(
      '<---- ${err.response?.statusCode ?? err.type.name} ${err.requestOptions.method} ${err.requestOptions.uri} ${err.requestOptions.path}',
      error: err,
      stackTrace: err.stackTrace,
    );
    handler.next(err);
  }

}

