library;

const String redactedPlaceholder = '<redacted>';

const Set<String> sensitiveHeaderNames = {
  'authorization',
  'proxy-authorization',
  'cookie',
  'set-cookie',
  'x-api-key',
  'x-auth-token',
  'x-refresh-token',
};

/// Returns a copy of [headers] with sensitive values replaced by
/// [redactedPlaceholder]. Safe to log in development.
Map<String, Object?> redactHeaders(Map<String, Object?> headers) {
  return {
    for (final entry in headers.entries)
      entry.key: sensitiveHeaderNames.contains(entry.key.toLowerCase())
          ? redactedPlaceholder
          : entry.value,
  };
}
