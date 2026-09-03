sealed class AppException implements Exception {
  const AppException({this.message, this.cause});

  /// Technical description for logs. Never shown to users and must never
  /// contain sensitive data.
  final String? message;

  /// The underlying error, if any (e.g. a `DioException`).
  final Object? cause;

  @override
  String toString() => '$runtimeType(${message ?? ''})';
}


/// Device is offline or the host is unreachable.
final class NetworkUnavailableException extends AppException {
  const NetworkUnavailableException({super.message, super.cause});
}

/// The request exceeded the configured timeouts.
final class RequestTimeoutException extends AppException {
  const RequestTimeoutException({super.message, super.cause});
}

/// The user is not authenticated or the session is no longer valid (401).
final class AuthenticationException extends AppException {
  const AuthenticationException({super.message, super.cause, this.code});

  /// Optional Problem Details key without the `error.` prefix.
  final String? code;
}

/// The user is authenticated but not allowed to perform the action (403).
final class AuthorizationException extends AppException {
  const AuthorizationException({super.message, super.cause, this.code});

  /// Optional Problem Details key without the `error.` prefix.
  final String? code;
}

/// The request was rejected because of invalid input (400/422).
final class ValidationException extends AppException {
  const ValidationException({super.message, super.cause, this.fieldErrors});

  /// Optional per-field errors as provided by the backend.
  final Map<String, List<String>>? fieldErrors;
}


/// The backend failed to process the request (5xx).
final class ServerException extends AppException {
  const ServerException({this.statusCode, super.message, super.cause});

  final int? statusCode;
}

/// Anything that could not be classified.
final class UnknownException extends AppException {
  const UnknownException({super.message, super.cause});
}