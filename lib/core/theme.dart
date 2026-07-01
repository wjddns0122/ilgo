import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/models/enums.dart';

/// Design tokens for "읽고". Optimized for low-literacy / accessibility:
/// large type (body 18sp+, key 24sp+), high contrast, 48dp+ touch targets.
/// Mirrors the variables handed off from Figma.
abstract class AppColors {
  static const primary = Color(0xFF1D6FB8); // trustworthy blue
  static const primaryDark = Color(0xFF15568F);
  static const background = Color(0xFFF7F8FA);
  static const surface = Color(0xFFFFFFFF);
  static const textPrimary = Color(0xFF1A1C1E);
  static const textSecondary = Color(0xFF5A5F66);
  static const border = Color(0xFFDDE1E6);

  // Traffic-light risk colors (WCAG-contrast tuned).
  static const riskGreen = Color(0xFF1E8E3E);
  static const riskGreenBg = Color(0xFFE6F4EA);
  static const riskYellow = Color(0xFF9A6700);
  static const riskYellowBg = Color(0xFFFEF7E0);
  static const riskRed = Color(0xFFC5221F);
  static const riskRedBg = Color(0xFFFCE8E6);
}

/// Risk styling helper — unknown levels intentionally render as yellow so a
/// possible risk is never hidden (see CLAUDE.md: 확신 없으면 yellow).
class RiskStyle {
  const RiskStyle(this.color, this.background, this.icon, this.emoji);

  final Color color;
  final Color background;
  final IconData icon;
  final String emoji;

  static RiskStyle of(RiskLevel level) {
    switch (level) {
      case RiskLevel.green:
        return const RiskStyle(
            AppColors.riskGreen, AppColors.riskGreenBg, Icons.check_circle, '🟢');
      case RiskLevel.red:
        return const RiskStyle(
            AppColors.riskRed, AppColors.riskRedBg, Icons.error, '🔴');
      case RiskLevel.yellow:
      case RiskLevel.unknown:
        return const RiskStyle(
            AppColors.riskYellow, AppColors.riskYellowBg, Icons.warning, '🟡');
    }
  }
}

abstract class AppTheme {
  /// Minimum touch target (accessibility).
  static const double minTouch = 48;

  static ThemeData light() {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        surface: AppColors.surface,
      ),
      scaffoldBackgroundColor: AppColors.background,
    );

    final textTheme = GoogleFonts.notoSansKrTextTheme(base.textTheme).copyWith(
      displaySmall: GoogleFonts.notoSansKr(
          fontSize: 30, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
      headlineMedium: GoogleFonts.notoSansKr(
          fontSize: 26, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
      titleLarge: GoogleFonts.notoSansKr(
          fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
      bodyLarge: GoogleFonts.notoSansKr(
          fontSize: 19, height: 1.5, color: AppColors.textPrimary),
      bodyMedium: GoogleFonts.notoSansKr(
          fontSize: 18, height: 1.5, color: AppColors.textPrimary),
      labelLarge: GoogleFonts.notoSansKr(
          fontSize: 18, fontWeight: FontWeight.w700),
    );

    return base.copyWith(
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: textTheme.titleLarge,
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.border),
        ),
        margin: EdgeInsets.zero,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(56),
          textStyle: textTheme.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          minimumSize: const Size.fromHeight(56),
          textStyle: textTheme.labelLarge,
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}
