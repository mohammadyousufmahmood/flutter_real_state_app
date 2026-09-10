import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_app/app/app.dart';
import 'package:state_app/app/config/app_config.dart';
import 'package:state_app/app/localization/locale_controller.dart';
import 'package:state_app/app/them/theme_controller.dart';
import 'package:state_app/core/logging/app_logger.dart';
import 'package:state_app/core/logging/console_app_logger.dart';
import 'package:state_app/core/networks/api_client.dart';
import 'package:state_app/core/networks/dio_api_client.dart';
import 'package:state_app/core/networks/interceptors/logging_interceptor.dart';
import 'package:state_app/core/networks/interceptors/request_id_interceptor.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  final config = AppConfig.fromEnvironment();
  final logger = ConsoleAppLogger(minimumLevel: config.minimumLogLevel);

  _registerErrorHandlers(logger);

  final providerContainer = ProviderContainer(
    overrides: [
      appConfigProvider.overrideWithValue(config),
      appLoggerProvider.overrideWithValue(logger),
      apiClientProvider.overrideWith((ref) => _buildApiClient(ref)),

    ],
  );


  logger.info('Real State application in ${config.environment.name} mode.');

  // TODO:  Restore session before the first frame so the

  await Future.wait<void>([
    providerContainer.read(themeControllerProvider.notifier).restore(),
    providerContainer.read(localeControllerProvider.notifier).restore(),
  ]);

  runApp(
    UncontrolledProviderScope(
      container: providerContainer,
      child: const MyApp(),
    ),
  );

}


/// Routes uncaught framework and platform errors through the central logger,
/// which is also where a crash-reporting sink would plug in later.
void _registerErrorHandlers(AppLogger logger) {
  FlutterError.onError = (details) {
    logger.error(
      'Uncaught Flutter framework error.',
      error: details.exception,
      stackTrace: details.stack,
    );
    FlutterError.presentError(details);
  };
  WidgetsBinding.instance.platformDispatcher.onError = (error, stackTrace) {
    logger.error(
      'Uncaught platform error.',
      error: error,
      stackTrace: stackTrace,
    );
    return true;
  };
}


ApiClient _buildApiClient(Ref ref) {

  final config = ref.watch(appConfigProvider);

  final dio = Dio(
    BaseOptions(
      baseUrl: config.apiBaseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 15),
      headers: const { 'Accept': 'application/json' },
    ),
  );

  dio.interceptors.addAll([
    RequestIdInterceptor(),
        if (config.enableNetworkLogging)
      NetworkLoggingInterceptor(ref.watch(appLoggerProvider)),
  ]);

  return DioApiClient(dio);
}


