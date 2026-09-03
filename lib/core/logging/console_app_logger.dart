import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_app/app/config/app_config.dart';
import 'package:state_app/core/logging/app_logger.dart';
import 'package:state_app/core/logging/log_level.dart';

class ConsoleAppLogger implements AppLogger {
  const ConsoleAppLogger({required this.minimumLevel});

  final LogLevel minimumLevel;

  @override
  void debug(String message) => _log(LogLevel.debug, message);

  @override
  void info(String message) => _log(LogLevel.info, message);

  @override
  void warning(String message, {Object? error, StackTrace? stackTrace}) =>
      _log(LogLevel.warning, message, error: error, stackTrace: stackTrace);

  @override
  void error(String message, {Object? error, StackTrace? stackTrace}) =>
      _log(LogLevel.error, message, error: error, stackTrace: stackTrace);

  void _log(
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (!(level >= minimumLevel)) {
      return;
    }
    final timestamp = DateTime.now().toIso8601String();
    final buffer = StringBuffer(
      '$timestamp [${level.name.toUpperCase()}] $message',
    );
    if (error != null) {
      buffer.write('\n  error: $error');
    }
    if (stackTrace != null) {
      buffer.write('\n$stackTrace');
    }
    debugPrint(buffer.toString());
  }
}


final appLoggerProvider = Provider<AppLogger>((ref) {
  final config = ref.watch(appConfigProvider);
  return ConsoleAppLogger(minimumLevel: config.minimumLogLevel);
});