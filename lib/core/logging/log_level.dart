/// Severity levels supported by the logging abstraction.
///
/// Ordered from least to most severe so levels can be compared numerically.
enum LogLevel {
  debug,
  info,
  warning,
  error;

  /// Parses a level name provided via configuration.
  static LogLevel parse(String value) {
    return switch (value.trim().toLowerCase()) {
      'debug' => LogLevel.debug,
      'info' => LogLevel.info,
      'warning' || 'warn' => LogLevel.warning,
      'error' => LogLevel.error,
      _ => throw ArgumentError.value(
        value,
        'value',
        'Unknown LOG_LEVEL. Expected one of: debug, info, warning, error.',
      ),
    };
  }

  bool operator >=(LogLevel other) => index >= other.index;
}