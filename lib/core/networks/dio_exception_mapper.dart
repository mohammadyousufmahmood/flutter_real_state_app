import 'package:dio/dio.dart';

import '../errors/app_exception.dart';

const _businessErrorKeys = <String>{
  'invalidOtp',
  'invalidChallenge',
  'identifierRequired',
  'identifierNotFound',
  'invalidCredentials',
  'accountBlocked',
  'accountLocked',
  'otpResendCooldown',
  'passwordPolicy',
  'passwordMismatch',
};

AppException mapDioException(DioException exception) {
  switch (exception.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.transformTimeout:
      return RequestTimeoutException(
        message: 'Request timed out: ${exception.requestOptions.uri.path}',
        cause: exception,
      );
    case DioExceptionType.connectionError:
      return NetworkUnavailableException(
        message: 'Connection failed: ${exception.requestOptions.uri.host}',
        cause: exception,
      );
    case DioExceptionType.badCertificate:
      // Treated as a network-security failure; the request must not proceed.
      return NetworkUnavailableException(
        message: 'TLS certificate validation failed.',
        cause: exception,
      );
    case DioExceptionType.badResponse:
      return _mapStatusCode(exception);
    case DioExceptionType.cancel:
    case DioExceptionType.unknown:
      return UnknownException(
        message: 'Unclassified network error.',
        cause: exception,
      );
  }
}

AppException _mapStatusCode(DioException exception) {
  final statusCode = exception.response?.statusCode;
  final problem = _parseProblemDetails(exception.response?.data);
  return switch (statusCode) {
    401 => AuthenticationException(
      code: problem.code,
      message: 'Unauthorized (401).',
      cause: exception,
    ),
    403 => AuthorizationException(
      code: problem.code,
      message: 'Forbidden (403).',
      cause: exception,
    ),
    404 => BusinessException(
      code: problem.code ?? 'notFound',
      serverMessage: problem.detail,
      message: 'Not found (404).',
      cause: exception,
    ),
    429 => BusinessException(
      code: problem.code ?? 'tooManyRequests',
      serverMessage: problem.detail,
      message: 'Too many requests (429).',
      cause: exception,
    ),
    400 || 422 => _mapClientError(problem, exception, statusCode!),
    final int code when code >= 500 => ServerException(
      statusCode: code,
      message: 'Server error ($code).',
      cause: exception,
    ),
    _ => UnknownException(
      message: 'Unexpected HTTP status ($statusCode).',
      cause: exception,
    ),
  };
}

AppException _mapClientError(
  _ProblemDetails problem,
  DioException exception,
  int statusCode,
) {
  final code = problem.code;
  if (code != null && _businessErrorKeys.contains(code)) {
    return BusinessException(
      code: code,
      serverMessage: problem.detail,
      message: 'Business rejection ($statusCode).',
      cause: exception,
    );
  }
  return ValidationException(
    message: 'Request rejected as invalid ($statusCode).',
    cause: exception,
    fieldErrors: problem.fieldErrors,
  );
}

_ProblemDetails _parseProblemDetails(Object? data) {
  if (data is! Map) {
    return const _ProblemDetails();
  }
  final json = data.map((key, value) => MapEntry(key.toString(), value));
  final rawMessage = json['message']?.toString();
  String? code;
  if (rawMessage != null && rawMessage.isNotEmpty) {
    code = rawMessage.startsWith('error.')
        ? rawMessage.substring('error.'.length)
        : rawMessage;
  }
  return _ProblemDetails(
    code: code,
    detail: json['detail']?.toString() ?? json['title']?.toString(),
    fieldErrors: _parseFieldErrors(json['fieldErrors']),
  );
}

Map<String, List<String>>? _parseFieldErrors(Object? raw) {
  if (raw is! List) {
    return null;
  }
  final result = <String, List<String>>{};
  for (final item in raw) {
    if (item is! Map) {
      continue;
    }
    final field = item['field']?.toString();
    final message = item['message']?.toString();
    if (field == null || message == null) {
      continue;
    }
    result.putIfAbsent(field, () => <String>[]).add(message);
  }
  return result.isEmpty ? null : result;
}

class _ProblemDetails {
  const _ProblemDetails({this.code, this.detail, this.fieldErrors});

  final String? code;
  final String? detail;
  final Map<String, List<String>>? fieldErrors;
}
