import 'package:flutter/material.dart';

/// Brand and surface colors for light and dark themes.
///
/// ZarVilla palette: deep charcoal/black surfaces with a warm metallic
/// gold brand color, matching the ZarVilla logo (black background, gold
/// house mark and wordmark).
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.brightness,
    required this.brand,
    required this.brandHover,
    required this.brandLight,
    required this.brandForeground,
    required this.pageBg,
    required this.border,
    required this.muted,
    required this.foreground,
    required this.placeholder,
    required this.danger,
    required this.cashIn,
    required this.cashInLight,
    required this.cashOut,
    required this.cashOutLight,
    required this.success,
    required this.surface,
    required this.mutedFill,
    required this.slate,
    required this.iconMuted,
    required this.ringTrack,
    required this.controlBorder,
    required this.fabGradientStart,
    required this.heroStart,
    required this.heroMid,
    required this.heroEnd,
    required this.heroTitle,
    required this.heroSubtitle,
    required this.heroGlowBlue,
    required this.heroGrid,
    required this.heroWave,
  });

  final Brightness brightness;
  final Color brand;
  final Color brandHover;
  final Color brandLight;
  final Color brandForeground;
  final Color pageBg;
  final Color border;
  final Color muted;
  final Color foreground;
  final Color placeholder;
  final Color danger;
  final Color cashIn;
  final Color cashInLight;
  final Color cashOut;
  final Color cashOutLight;
  final Color success;
  final Color surface;
  final Color mutedFill;
  final Color slate;
  final Color iconMuted;
  final Color ringTrack;
  final Color controlBorder;
  final Color fabGradientStart;
  final Color heroStart;
  final Color heroMid;
  final Color heroEnd;
  final Color heroTitle;
  final Color heroSubtitle;
  final Color heroGlowBlue;
  final Color heroGrid;
  final Color heroWave;

  /// Decorative highlight gold used on heroes and payment/listing cards.
  /// A lighter, brighter tone than [brand] so it reads as a shine/accent
  /// rather than the functional button color. Same in both themes.
  static const Color gold = Color(0xFFE8C468);

  /// Gold glow overlay on the auth hero. Same in both themes.
  static const Color heroGlowGold = Color(0x40D4AF37);

  /// Near-black surface used by snackbars; always a dark brand surface.
  static const Color heroNavy = Color(0xFF120E06);

  bool get isDark => brightness == Brightness.dark;

  static const AppColors light = AppColors(
    brightness: Brightness.light,
    brand: Color(0xFFB8860B),
    brandHover: Color(0xFF9C730A),
    brandLight: Color(0xFFFBF0D9),
    brandForeground: Color(0xFF17130A),
    pageBg: Color(0xFFFAF8F3),
    border: Color(0xFFE8E1D3),
    muted: Color(0xFF6B6255),
    foreground: Color(0xFF1A1611),
    placeholder: Color(0xFFA79C89),
    danger: Color(0xFFDC2626),
    cashIn: Color(0xFF15803D),
    cashInLight: Color(0xFFECFDF3),
    cashOut: Color(0xFFB45309),
    cashOutLight: Color(0xFFFFFBEB),
    success: Color(0xFF15803D),
    surface: Color(0xFFFFFFFF),
    mutedFill: Color(0xFFF5F1E8),
    slate: Color(0xFF3F3A2E),
    iconMuted: Color(0xFF7A7060),
    ringTrack: Color(0xFFE5DFCF),
    controlBorder: Color(0xFFD6CDB8),
    fabGradientStart: Color(0xFF8B6914),
    heroStart: Color(0xFF0A0A0A),
    heroMid: Color(0xFF1A1409),
    heroEnd: Color(0xFF0F0D08),
    heroTitle: Color(0xFFFFFFFF),
    heroSubtitle: Color(0xD6D6C9A8),
    heroGlowBlue: Color(0x33D4AF37),
    heroGrid: Color(0x0AFFFFFF),
    heroWave: Color(0x22D4AF37),
  );

  static const AppColors dark = AppColors(
    brightness: Brightness.dark,
    brand: Color(0xFFE8C468),
    brandHover: Color(0xFFF0D488),
    brandLight: Color(0x33D4AF37),
    brandForeground: Color(0xFF14110A),
    pageBg: Color(0xFF0A0908),
    border: Color(0x1AFFFFFF),
    muted: Color(0xFFA99B7C),
    foreground: Color(0xFFF5F0E6),
    placeholder: Color(0xFF8A7F68),
    danger: Color(0xFFFF6467),
    cashIn: Color(0xFF34D399),
    cashInLight: Color(0x2E059669),
    cashOut: Color(0xFFFBBF24),
    cashOutLight: Color(0x2ED97706),
    success: Color(0xFF34D399),
    surface: Color(0xFF121008),
    mutedFill: Color(0xFF1E1A12),
    slate: Color(0xFFE8DFC8),
    iconMuted: Color(0xFFA99B7C),
    ringTrack: Color(0x26FFFFFF),
    controlBorder: Color(0x33FFFFFF),
    fabGradientStart: Color(0xFFC9A227),
    heroStart: Color(0xFF000000),
    heroMid: Color(0xFF0A0805),
    heroEnd: Color(0xFF050403),
    heroTitle: Color(0xFFF8F5EC),
    heroSubtitle: Color(0xD9C9BFA0),
    heroGlowBlue: Color(0x40D4AF37),
    heroGrid: Color(0x14FFFFFF),
    heroWave: Color(0x40D4AF37),
  );

  Color get brandFocusRing => brand.withValues(alpha: 0.12);

  Color get brandShadow => brand.withValues(alpha: 0.25);

  /// Soft all-around elevation used by listing/payment cards.
  List<BoxShadow> get paymentCardShadow => [
    BoxShadow(
      color: foreground.withValues(alpha: 0.06),
      blurRadius: 20,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: foreground.withValues(alpha: 0.08),
      blurRadius: 16,
      offset: const Offset(0, 6),
    ),
  ];

  /// Brand-tinted (gold) all-around elevation used by the wallet/featured
  /// card.
  List<BoxShadow> get walletCardShadow => [
    BoxShadow(
      color: brand.withValues(alpha: 0.12),
      blurRadius: 22,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: brandShadow,
      blurRadius: 28,
      offset: const Offset(0, 10),
    ),
    BoxShadow(
      color: foreground.withValues(alpha: 0.06),
      blurRadius: 10,
      offset: const Offset(0, 3),
    ),
  ];

  /// Black-to-gold sheen used by the wallet/hero card gradient — echoes
  /// the logo's black background with a gold-lit edge.
  List<Color> get walletGradient => isDark
      ? const <Color>[
          Color(0xFF0A0908),
          Color(0xFF1E1A12),
          Color(0xFF3D310F),
          Color(0xFF6B5312),
        ]
      : const <Color>[
          Color(0xFFFDFBF5),
          Color(0xFFF7EFD9),
          Color(0xFFF0E2B8),
          Color(0xFFE3CD8E),
        ];

  @override
  AppColors copyWith({
    Brightness? brightness,
    Color? brand,
    Color? brandHover,
    Color? brandLight,
    Color? brandForeground,
    Color? pageBg,
    Color? border,
    Color? muted,
    Color? foreground,
    Color? placeholder,
    Color? danger,
    Color? cashIn,
    Color? cashInLight,
    Color? cashOut,
    Color? cashOutLight,
    Color? success,
    Color? surface,
    Color? mutedFill,
    Color? slate,
    Color? iconMuted,
    Color? ringTrack,
    Color? controlBorder,
    Color? fabGradientStart,
    Color? heroStart,
    Color? heroMid,
    Color? heroEnd,
    Color? heroTitle,
    Color? heroSubtitle,
    Color? heroGlowBlue,
    Color? heroGrid,
    Color? heroWave,
  }) {
    return AppColors(
      brightness: brightness ?? this.brightness,
      brand: brand ?? this.brand,
      brandHover: brandHover ?? this.brandHover,
      brandLight: brandLight ?? this.brandLight,
      brandForeground: brandForeground ?? this.brandForeground,
      pageBg: pageBg ?? this.pageBg,
      border: border ?? this.border,
      muted: muted ?? this.muted,
      foreground: foreground ?? this.foreground,
      placeholder: placeholder ?? this.placeholder,
      danger: danger ?? this.danger,
      cashIn: cashIn ?? this.cashIn,
      cashInLight: cashInLight ?? this.cashInLight,
      cashOut: cashOut ?? this.cashOut,
      cashOutLight: cashOutLight ?? this.cashOutLight,
      success: success ?? this.success,
      surface: surface ?? this.surface,
      mutedFill: mutedFill ?? this.mutedFill,
      slate: slate ?? this.slate,
      iconMuted: iconMuted ?? this.iconMuted,
      ringTrack: ringTrack ?? this.ringTrack,
      controlBorder: controlBorder ?? this.controlBorder,
      fabGradientStart: fabGradientStart ?? this.fabGradientStart,
      heroStart: heroStart ?? this.heroStart,
      heroMid: heroMid ?? this.heroMid,
      heroEnd: heroEnd ?? this.heroEnd,
      heroTitle: heroTitle ?? this.heroTitle,
      heroSubtitle: heroSubtitle ?? this.heroSubtitle,
      heroGlowBlue: heroGlowBlue ?? this.heroGlowBlue,
      heroGrid: heroGrid ?? this.heroGrid,
      heroWave: heroWave ?? this.heroWave,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      brightness: t < 0.5 ? brightness : other.brightness,
      brand: Color.lerp(brand, other.brand, t)!,
      brandHover: Color.lerp(brandHover, other.brandHover, t)!,
      brandLight: Color.lerp(brandLight, other.brandLight, t)!,
      brandForeground: Color.lerp(brandForeground, other.brandForeground, t)!,
      pageBg: Color.lerp(pageBg, other.pageBg, t)!,
      border: Color.lerp(border, other.border, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
      foreground: Color.lerp(foreground, other.foreground, t)!,
      placeholder: Color.lerp(placeholder, other.placeholder, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      cashIn: Color.lerp(cashIn, other.cashIn, t)!,
      cashInLight: Color.lerp(cashInLight, other.cashInLight, t)!,
      cashOut: Color.lerp(cashOut, other.cashOut, t)!,
      cashOutLight: Color.lerp(cashOutLight, other.cashOutLight, t)!,
      success: Color.lerp(success, other.success, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      mutedFill: Color.lerp(mutedFill, other.mutedFill, t)!,
      slate: Color.lerp(slate, other.slate, t)!,
      iconMuted: Color.lerp(iconMuted, other.iconMuted, t)!,
      ringTrack: Color.lerp(ringTrack, other.ringTrack, t)!,
      controlBorder: Color.lerp(controlBorder, other.controlBorder, t)!,
      fabGradientStart: Color.lerp(
        fabGradientStart,
        other.fabGradientStart,
        t,
      )!,
      heroStart: Color.lerp(heroStart, other.heroStart, t)!,
      heroMid: Color.lerp(heroMid, other.heroMid, t)!,
      heroEnd: Color.lerp(heroEnd, other.heroEnd, t)!,
      heroTitle: Color.lerp(heroTitle, other.heroTitle, t)!,
      heroSubtitle: Color.lerp(heroSubtitle, other.heroSubtitle, t)!,
      heroGlowBlue: Color.lerp(heroGlowBlue, other.heroGlowBlue, t)!,
      heroGrid: Color.lerp(heroGrid, other.heroGrid, t)!,
      heroWave: Color.lerp(heroWave, other.heroWave, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AppColors &&
            brightness == other.brightness &&
            brand == other.brand &&
            brandHover == other.brandHover &&
            brandLight == other.brandLight &&
            brandForeground == other.brandForeground &&
            pageBg == other.pageBg &&
            border == other.border &&
            muted == other.muted &&
            foreground == other.foreground &&
            placeholder == other.placeholder &&
            danger == other.danger &&
            cashIn == other.cashIn &&
            cashInLight == other.cashInLight &&
            cashOut == other.cashOut &&
            cashOutLight == other.cashOutLight &&
            success == other.success &&
            surface == other.surface &&
            mutedFill == other.mutedFill &&
            slate == other.slate &&
            iconMuted == other.iconMuted &&
            ringTrack == other.ringTrack &&
            controlBorder == other.controlBorder &&
            fabGradientStart == other.fabGradientStart &&
            heroStart == other.heroStart &&
            heroMid == other.heroMid &&
            heroEnd == other.heroEnd &&
            heroTitle == other.heroTitle &&
            heroSubtitle == other.heroSubtitle &&
            heroGlowBlue == other.heroGlowBlue &&
            heroGrid == other.heroGrid &&
            heroWave == other.heroWave;
  }

  @override
  int get hashCode => Object.hashAll(<Object?>[
    brightness,
    brand,
    brandHover,
    brandLight,
    brandForeground,
    pageBg,
    border,
    muted,
    foreground,
    placeholder,
    danger,
    cashIn,
    cashInLight,
    cashOut,
    cashOutLight,
    success,
    surface,
    mutedFill,
    slate,
    iconMuted,
    ringTrack,
    controlBorder,
    fabGradientStart,
    heroStart,
    heroMid,
    heroEnd,
    heroTitle,
    heroSubtitle,
    heroGlowBlue,
    heroGrid,
    heroWave,
  ]);
}

/// Reads the active [AppColors] extension from the ambient theme.
extension AppColorsX on BuildContext {
  AppColors get colors =>
      Theme.of(this).extension<AppColors>() ?? AppColors.light;
}
