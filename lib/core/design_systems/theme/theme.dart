

import 'package:flutter/material.dart';

import 'app_typography.dart';

class QMaterialTheme {
  QMaterialTheme._();

  static ThemeData light() {
    return _theme(_lightScheme().toColorScheme());
  }

  static ThemeData dark() {
    return _theme(_darkScheme().toColorScheme());
  }

  static ThemeData _theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: AppTypographis.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
  );

  static MaterialScheme _lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xFF4A77FF),
      surfaceTint: Color(0xFF4A77FF),
      onPrimary: Colors.white,
      primaryContainer: Color(0xFFDCE4FF),
      onPrimaryContainer: Color(0xFF001A5F),
      secondary: Color(0xFF5C5F70),
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFFE1E3EC),
      onSecondaryContainer: Color(0xFF1A1C2B),
      tertiary: Color(0xFF00897B),
      onTertiary: Colors.white,
      tertiaryContainer: Color(0xFFB2DFDB),
      onTertiaryContainer: Color(0xFF00332D),
      error: Color(0xFFB00020),
      onError: Colors.white,
      errorContainer: Color(0xFFF9DEDC),
      onErrorContainer: Color(0xFF410E0B),
      background: Color(0xFFFAFAFF),
      onBackground: Color(0xFF1A1C1E),
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF1A1C1E),
      surfaceVariant: Color(0xFFE1E3EC),
      onSurfaceVariant: Color(0xFF44474F),
      outline: Color(0xFF767680),
      outlineVariant: Color(0xFFC4C6CF),
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: Color(0xFF2F3033),
      inverseOnSurface: Color(0xFFF1F0F4),
      inversePrimary: Color(0xFFADC2FF),
      primaryFixed: Color(0xFFDCE4FF),
      onPrimaryFixed: Color(0xFF001A5F),
      primaryFixedDim: Color(0xFFADC2FF),
      onPrimaryFixedVariant: Color(0xFF334ACC),
      secondaryFixed: Color(0xFFE1E3EC),
      onSecondaryFixed: Color(0xFF1A1C2B),
      secondaryFixedDim: Color(0xFFC3C6D6),
      onSecondaryFixedVariant: Color(0xFF434657),
      tertiaryFixed: Color(0xFFB2DFDB),
      onTertiaryFixed: Color(0xFF00332D),
      tertiaryFixedDim: Color(0xFF80CBC4),
      onTertiaryFixedVariant: Color(0xFF00695C),
      surfaceDim: Color(0xFFE0E0E0),
      surfaceBright: Color(0xFFFFFFFF),
      surfaceContainerLowest: Color(0xFFFFFFFF),
      surfaceContainerLow: Color(0xFFF5F5F5),
      surfaceContainer: Color(0xFFEFEFEF),
      surfaceContainerHigh: Color(0xFFE0E0E0),
      surfaceContainerHighest: Color(0xFFD6D6D6),
    );
  }

  static MaterialScheme _darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xFFADC2FF),
      surfaceTint: Color(0xFFADC2FF),
      onPrimary: Color(0xFF002C8B),
      primaryContainer: Color(0xFF334ACC),
      onPrimaryContainer: Color(0xFFDCE4FF),
      secondary: Color(0xFFC3C6D6),
      onSecondary: Color(0xFF2D303F),
      secondaryContainer: Color(0xFF434657),
      onSecondaryContainer: Color(0xFFE1E3EC),
      tertiary: Color(0xFF80CBC4),
      onTertiary: Color(0xFF003731),
      tertiaryContainer: Color(0xFF00695C),
      onTertiaryContainer: Color(0xFFB2DFDB),
      error: Color(0xFFFFB4AB),
      onError: Color(0xFF690005),
      errorContainer: Color(0xFF93000A),
      onErrorContainer: Color(0xFFFFDAD6),
      background: Color(0xFF1A1C1E),
      onBackground: Color(0xFFE3E2E6),
      surface: Color(0xFF1A1C1E),
      onSurface: Color(0xFFE3E2E6),
      surfaceVariant: Color(0xFF44474F),
      onSurfaceVariant: Color(0xFFC4C6CF),
      outline: Color(0xFF8D8F99),
      outlineVariant: Color(0xFF44474F),
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: Color(0xFFE3E2E6),
      inverseOnSurface: Color(0xFF2F3033),
      inversePrimary: Color(0xFF4A77FF),
      primaryFixed: Color(0xFFDCE4FF),
      onPrimaryFixed: Color(0xFF001A5F),
      primaryFixedDim: Color(0xFFADC2FF),
      onPrimaryFixedVariant: Color(0xFF334ACC),
      secondaryFixed: Color(0xFFE1E3EC),
      onSecondaryFixed: Color(0xFF1A1C2B),
      secondaryFixedDim: Color(0xFFC3C6D6),
      onSecondaryFixedVariant: Color(0xFF434657),
      tertiaryFixed: Color(0xFFB2DFDB),
      onTertiaryFixed: Color(0xFF00332D),
      tertiaryFixedDim: Color(0xFF80CBC4),
      onTertiaryFixedVariant: Color(0xFF00695C),
      surfaceDim: Color(0xFF121212),
      surfaceBright: Color(0xFF2C2C2C),
      surfaceContainerLowest: Color(0xFF0E0E0E),
      surfaceContainerLow: Color(0xFF1E1E1E),
      surfaceContainer: Color(0xFF2A2A2A),
      surfaceContainerHigh: Color(0xFF3A3A3A),
      surfaceContainerHighest: Color(0xFF474747),
    );
  }
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary,
    required this.surfaceTint,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.inverseOnSurface,
    required this.inversePrimary,
    required this.primaryFixed,
    required this.onPrimaryFixed,
    required this.primaryFixedDim,
    required this.onPrimaryFixedVariant,
    required this.secondaryFixed,
    required this.onSecondaryFixed,
    required this.secondaryFixedDim,
    required this.onSecondaryFixedVariant,
    required this.tertiaryFixed,
    required this.onTertiaryFixed,
    required this.tertiaryFixedDim,
    required this.onTertiaryFixedVariant,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      surface: background,
      onSurface: onBackground,
      surfaceContainerHigh: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}