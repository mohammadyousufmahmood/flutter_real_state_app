/// Spacing scale shared across the application. Use these tokens instead of
/// ad-hoc pixel values to keep layouts consistent.
abstract final class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double page = 20;
  static const double lg = 24;
  static const double xl = 32;
}

/// Common dimensions.
abstract final class AppDimensions {
  /// Minimum touch target size required for accessibility (Material
  /// guidance: 48x48 dp).
  static const double minTouchTarget = 48;

  /// Maximum width of centered content on large screens (tablet/web).
  static const double maxContentWidth = 480;
}
