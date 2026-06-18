import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const Color primary = Color(0xFF002D89);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF1A44AD);
  static const Color background = Color(0xFFFCF9F8);
  static const Color onBackground = Color(0xFF1C1B1B);
  static const Color surfaceVariant = Color(0xFFE5E2E1);
  static const Color surfaceContainer = Color(0xFFF0EDEC);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color outlineVariant = Color(0xFFC4C5D5);

  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: primary,
        onPrimary: onPrimary,
        primaryContainer: primaryContainer,
        surface: background,
        onSurface: onBackground,
        surfaceContainerHighest: surfaceVariant,
        surfaceTint: Colors.transparent,
      ),
      scaffoldBackgroundColor: background,
      textTheme: TextTheme(
        // display-lg
        displayLarge: GoogleFonts.workSans(
          fontSize: 48,
          fontWeight: FontWeight.w700,
          height: 56 / 48,
          letterSpacing: -0.02,
          color: primary,
        ),
        // display-lg-mobile
        displayMedium: GoogleFonts.workSans(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          height: 40 / 32,
          letterSpacing: -0.01,
          color: primary,
        ),
        // headline-md
        headlineMedium: GoogleFonts.workSans(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          height: 32 / 24,
          color: primary,
        ),
        // body-ui
        bodyLarge: GoogleFonts.workSans(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 24 / 16,
          color: onBackground,
        ),
        // metadata
        bodyMedium: GoogleFonts.workSans(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 20 / 14,
          color: onBackground.withValues(alpha: 0.6),
        ),
        // label-caps
        labelSmall: GoogleFonts.workSans(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          height: 16 / 12,
          letterSpacing: 0.05,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 4,
          textStyle: GoogleFonts.workSans(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            height: 24 / 16,
          ),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF6B93F3),
        onPrimary: Color(0xFF001B5A),
        primaryContainer: Color(0xFF002D89),
        surface: Color(0xFF1C1B1B),
        onSurface: Color(0xFFFCF9F8),
        surfaceContainerHighest: Color(0xFF333333),
        surfaceTint: Colors.transparent,
      ),
      scaffoldBackgroundColor: const Color(0xFF121212),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF121212),
        foregroundColor: Color(0xFFFCF9F8),
        elevation: 0,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.workSans(
          fontSize: 48,
          fontWeight: FontWeight.w700,
          height: 56 / 48,
          letterSpacing: -0.02,
          color: const Color(0xFF6B93F3),
        ),
        displayMedium: GoogleFonts.workSans(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          height: 40 / 32,
          letterSpacing: -0.01,
          color: const Color(0xFF6B93F3),
        ),
        headlineMedium: GoogleFonts.workSans(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          height: 32 / 24,
          color: const Color(0xFF6B93F3),
        ),
        bodyLarge: GoogleFonts.workSans(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 24 / 16,
          color: const Color(0xFFFCF9F8),
        ),
        bodyMedium: GoogleFonts.workSans(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 20 / 14,
          color: const Color(0xFFFCF9F8).withValues(alpha: 0.7),
        ),
        labelSmall: GoogleFonts.workSans(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          height: 16 / 12,
          letterSpacing: 0.05,
          color: const Color(0xFFFCF9F8),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6B93F3),
          foregroundColor: const Color(0xFF001B5A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 4,
          textStyle: GoogleFonts.workSans(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            height: 24 / 16,
          ),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: const Color(0xFF1C1B1B),
        selectedItemColor: const Color(0xFF6B93F3),
        unselectedItemColor: const Color(0xFFFCF9F8).withValues(alpha: 0.6),
      ),
    );
  }
}
