import 'dart:async';

import 'package:dio/dio.dart';

/// Attaches the access token to outgoing requests and signals session
/// expiration when the backend responds with 401.
///
/// Login paths (`/api/auth/login`, `/api/auth/register`) are excluded: a
/// wrong password or a taken email is a 401/409 but must not look like a
/// session expiry. Token refresh IS implemented here via `refreshToken`,
/// since the listings API supports refresh tokens.
class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required this.readAccessToken,
    required this.refreshAccessToken,
    required this.onUnauthorized,
  });

  /// Reads the current access token, or `null` when unauthenticated
  /// (e.g. a visitor just browsing listings without an account).
  final Future<String?> Function() readAccessToken;

  /// Attempts to refresh the access token using the stored refresh token.
  /// Returns the new access token on success, or `null` if refresh failed
  /// (refresh token expired/revoked too).
  final Future<String?> Function() refreshAccessToken;

  /// Invoked when the session cannot be salvaged — e.g. refresh failed too.
  /// Should clear stored tokens and route the user back to browsing as a
  /// guest or to the login screen if they were mid-checkout on an offer.
  final Future<void> Function() onUnauthorized;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await readAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final isUnauthorized = err.response?.statusCode == 401;
    final isAuthEndpoint = _isAuthPath(err.requestOptions.path);

    if (isUnauthorized && !isAuthEndpoint) {
      // Try to silently refresh before giving up — e.g. the user is mid-
      // scroll through listings and shouldn't be booted out for an expired
      // (but refreshable) access token.
      final newToken = await refreshAccessToken();
      if (newToken != null) {
        final retryOptions = err.requestOptions
          ..headers['Authorization'] = 'Bearer $newToken';
        try {
          final response = await Dio().fetch(retryOptions);
          return handler.resolve(response);
        } catch (_) {
          // Retry itself failed; fall through to logout below.
        }
      }
      await onUnauthorized();
    }

    handler.next(err);
  }

  /// Endpoints where a 401/409 is an expected auth-flow response, not a
  /// sign of session expiry — e.g. bad credentials on login, or a
  /// duplicate email on registration.
  static bool _isAuthPath(String path) =>
      path.contains('/api/auth/login') ||
      path.contains('/api/auth/register') ||
      path.contains('/api/auth/forgot-password');
}