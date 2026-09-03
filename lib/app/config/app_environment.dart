/// The deployment environments supported by the application.
enum AppEnvironment {
  development,
  staging,
  production;

  /// Parses an environment name provided via `--dart-define`.
  ///
  /// Fails fast on unknown values: silently falling back to a default
  /// environment is dangerous in a financial application.
  static AppEnvironment parse(String value) {
    return switch (value.trim().toLowerCase()) {
      'development' || 'dev' => AppEnvironment.development,
      'staging' => AppEnvironment.staging,
      'production' || 'prod' => AppEnvironment.production,
      _ => throw ArgumentError.value(
        value,
        'value',
        'Unknown APP_ENV. Expected one of: development, staging, production.',
      ),
    };
  }

  bool get isDevelopment => this == AppEnvironment.development;
  bool get isProduction => this == AppEnvironment.production;
}
