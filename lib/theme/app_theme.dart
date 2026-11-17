import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Primary Greens from Wireframes
  static const Color primary = Color(0xFF1E6F38);
  static const Color primaryDark = Color(0xFF16542A);
  static const Color primaryLight = Color(0xFF2E8B4E);
  static const Color primarySurface = Color(0xFFE8F5E9);
  static const Color primaryBorder = Color(0xFFC8E6C9);

  // Backgrounds & Surface
  static const Color background = Color(0xFFF7FAF6);
  static const Color cardBg = Colors.white;
  static const Color cardBorder = Color(0xFFE5EDE3);
  static const Color lightGreenCard = Color(0xFFF0F7EE);

  // Text colors
  static const Color textDark = Color(0xFF1B2E1D);
  static const Color textMedium = Color(0xFF4A5568);
  static const Color textLight = Color(0xFF718096);
  static const Color textMuted = Color(0xFF9E9E9E);

  // Accent Status Badges
  static const Color badgeGreenBg = Color(0xFFDCFCE7);
  static const Color badgeGreenText = Color(0xFF15803D);

  static const Color badgeOrangeBg = Color(0xFFFEF3C7);
  static const Color badgeOrangeText = Color(0xFFB45309);

  static const Color badgeBlueBg = Color(0xFFE0F2FE);
  static const Color badgeBlueText = Color(0xFF0284C7);

  static const Color badgePurpleBg = Color(0xFFF3E8FF);
  static const Color badgePurpleText = Color(0xFF7E22CE);

  static const Color badgeGrayBg = Color(0xFFF1F5F9);
  static const Color badgeGrayText = Color(0xFF475569);

  // Alert Box
  static const Color alertBg = Color(0xFFF2F9F0);
  static const Color alertBorder = Color(0xFFD4EAD0);
}

class AppTheme {
  static ThemeData get lightTheme {
    final textTheme = GoogleFonts.hindVadodaraTextTheme();

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primary,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        surface: AppColors.cardBg,
      ),
      textTheme: textTheme.copyWith(
        displayLarge: GoogleFonts.hindVadodara(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: AppColors.textDark,
        ),
        headlineLarge: GoogleFonts.hindVadodara(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.textDark,
        ),
        headlineMedium: GoogleFonts.hindVadodara(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.textDark,
        ),
        titleLarge: GoogleFonts.hindVadodara(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
        titleMedium: GoogleFonts.hindVadodara(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
        bodyLarge: GoogleFonts.hindVadodara(
          fontSize: 15,
          fontWeight: FontWeight.normal,
          color: AppColors.textDark,
        ),
        bodyMedium: GoogleFonts.hindVadodara(
          fontSize: 13,
          fontWeight: FontWeight.normal,
          color: AppColors.textMedium,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppColors.textDark),
      ),
      cardTheme: CardThemeData(
        color: AppColors.cardBg,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.cardBorder, width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.cardBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.cardBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        hintStyle: GoogleFonts.hindVadodara(
          color: AppColors.textMuted,
          fontSize: 14,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.hindVadodara(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
