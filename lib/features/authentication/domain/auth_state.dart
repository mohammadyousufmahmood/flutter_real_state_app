sealed class AuthState {
  const AuthState();
}

/// Session restoration has not completed yet (app is starting).
final class AuthStateUnknown extends AuthState {
  const AuthStateUnknown();
}

/// No valid session exists; the user must sign in.
final class AuthStateUnauthenticated extends AuthState {
  const AuthStateUnauthenticated();
}

/// A session exists. Token values are intentionally not carried in UI state;
/// they live in secure storage and are attached to requests by the network
/// layer.
final class AuthStateAuthenticated extends AuthState {
  const AuthStateAuthenticated();
}