import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_app/app/config/app_environment.dart';
import 'package:state_app/core/logging/log_level.dart';

@immutable
class AppConfig {
  final AppEnvironment environment;
  final String apiBaseUrl;
  final LogLevel minimumLogLevel;
  final bool enableNetworkLogging;

  const AppConfig({
    required this.environment,
    required this.apiBaseUrl,
    required this.minimumLogLevel,
    required this.enableNetworkLogging,
  });

  /// Validates raw configuration values and applies environment-aware
  /// defaults. Extracted from [AppConfig.fromEnvironment] so it is unit
  /// testable (const `String.fromEnvironment` cannot be varied in tests).
  factory AppConfig.resolve({
    required String environmentName,
    required String apiBaseUrl,
    String logLevelName = '',
    bool? enableNetworkLogging,
  }) {
    final environment = AppEnvironment.parse(environmentName);

    final baseUri = Uri.tryParse(apiBaseUrl);
    if (apiBaseUrl.isEmpty || baseUri == null || !baseUri.hasScheme) {
      throw ArgumentError.value(
        apiBaseUrl,
        'apiBaseUrl',
        'API_BASE_URL must be an absolute URL.',
      );
    }
    // HTTPS is mandatory outside local development (financial application).
    if (!environment.isDevelopment && baseUri.scheme != 'https') {
      throw ArgumentError.value(
        apiBaseUrl,
        'apiBaseUrl',
        'API_BASE_URL must use HTTPS in ${environment.name}.',
      );
    }

    final minimumLogLevel = logLevelName.isEmpty
        ? (environment.isDevelopment ? LogLevel.debug : LogLevel.info)
        : LogLevel.parse(logLevelName);

    // Network logging may leak request metadata; it is opt-in, defaults to
    // development only, and can never be enabled in production.
    final networkLogging =
        !environment.isProduction &&
        (enableNetworkLogging ?? environment.isDevelopment);

    return AppConfig(
      environment: environment,
      apiBaseUrl: apiBaseUrl,
      minimumLogLevel: minimumLogLevel,
      enableNetworkLogging: networkLogging,
    );
  }

  factory AppConfig.fromEnvironment() {
    const hasNetworkLogging = bool.hasEnvironment('ENABLE_NETWORK_LOGGING');
    
    return AppConfig.resolve(
      environmentName: const String.fromEnvironment('APP_ENV', defaultValue: 'development'),
      apiBaseUrl: const String.fromEnvironment('API_BASE_URL', defaultValue: 'http://localhost:5001'),  // .NET https://localhost:7001 , NODEJS http://localhost:3000, 
      logLevelName: const String.fromEnvironment('LOG_LEVEL'),
      enableNetworkLogging: hasNetworkLogging ? 
          const bool.fromEnvironment('ENABLE_NETWORK_LOGGING', defaultValue: false) : false,
    );
  }

  AppConfig forLocalDevice() {
  if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) {
    return this; // not Android → do nothing, return config unchanged
  }
  final uri = Uri.tryParse(apiBaseUrl);
  if (uri == null || (uri.host != 'localhost' && uri.host != '127.0.0.1')) {
    return this; // not pointing at localhost → nothing to fix
  }
  // Otherwise: rewrite the host to 10.0.2.2
  return AppConfig(
    environment: environment,
    apiBaseUrl: uri.replace(host: '10.0.2.2').toString(),
    minimumLogLevel: minimumLogLevel,
    enableNetworkLogging: enableNetworkLogging,
  );
}

}

/// Provides the resolved [AppConfig].
///
/// Overridden with a concrete value during bootstrap (and in tests); reading
/// it without an override is a programming error, hence the throw.
final appConfigProvider = Provider<AppConfig>((ref) {
  throw StateError('appConfigProvider must be overridden during bootstrap.');
});
