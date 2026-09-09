import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_spacing.dart';

/// Material 3 theme built from [AppColors] tokens.
abstract final class AppTheme {
  static ThemeData light() => _build(AppColors.light, Brightness.light);

  static ThemeData dark() => _build(AppColors.dark, Brightness.dark);

  static ThemeData _build(AppColors colors, Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: colors.brand,
      onPrimary: colors.brandForeground,
      secondary: colors.mutedFill,
      onSecondary: colors.foreground,
      error: colors.danger,
      onError: isDark ? colors.foreground : const Color(0xFFFFFFFF),
      surface: colors.surface,
      onSurface: colors.foreground,
      outline: colors.border,
      outlineVariant: colors.controlBorder,
    );

    final overlayStyle = isDark
        ? SystemUiOverlayStyle.light.copyWith(
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: colors.surface,
            systemNavigationBarIconBrightness: Brightness.light,
          )
        : SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: colors.surface,
            systemNavigationBarIconBrightness: Brightness.dark,
          );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colors.pageBg,
      canvasColor: colors.pageBg,
      dividerColor: colors.border,
      extensions: <ThemeExtension<dynamic>>[colors],
      materialTapTargetSize: MaterialTapTargetSize.padded,
      visualDensity: VisualDensity.standard,
      // Slightly wider letter-spacing on titles reads as a more refined,
      // "real estate brochure" feel that suits the ZarVilla gold branding
      // without pulling in a custom font package.
      textTheme: ThemeData(brightness: brightness).textTheme.copyWith(
        headlineSmall: ThemeData(
          brightness: brightness,
        ).textTheme.headlineSmall?.copyWith(
          color: colors.foreground,
          letterSpacing: 0.3,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: ThemeData(
          brightness: brightness,
        ).textTheme.titleLarge?.copyWith(
          color: colors.foreground,
          letterSpacing: 0.2,
          fontWeight: FontWeight.w600,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colors.surface,
        foregroundColor: colors.foreground,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: overlayStyle,
        iconTheme: IconThemeData(color: colors.iconMuted),
        actionsIconTheme: IconThemeData(color: colors.iconMuted),
      ),
      cardTheme: CardThemeData(
        color: colors.surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: colors.border),
        ),
      ),
      dividerTheme: DividerThemeData(color: colors.border, space: 1),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColors.heroNavy,
        contentTextStyle: TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        behavior: SnackBarBehavior.floating,
      ),
      iconTheme: IconThemeData(color: colors.iconMuted),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colors.brand,
          foregroundColor: colors.brandForeground,
          disabledBackgroundColor: colors.brand.withValues(alpha: 0.45),
          disabledForegroundColor: colors.brandForeground.withValues(
            alpha: 0.7,
          ),
          minimumSize: const Size.fromHeight(AppDimensions.minTouchTarget),
        ),
      ),
    );
  }
}
