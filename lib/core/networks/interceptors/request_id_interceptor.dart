
import 'dart:math';

import 'package:dio/dio.dart';

class RequestIdInterceptor extends Interceptor {

  RequestIdInterceptor({Random? random}) : _random = random ?? Random();

  final Random _random;

  
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    
    options.headers.putIfAbsent('X-Request-ID', _generateRequestId);
    super.onRequest(options, handler);
  }

  String _generateRequestId() {
    
    final timestamp = DateTime.now().microsecondsSinceEpoch.toRadixString(16);
    final suffix = List.generate(
      8,
      (_) => _random.nextInt(16).toRadixString(16),
    ).join();
    return '$timestamp-$suffix';  }

}