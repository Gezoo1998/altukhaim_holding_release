import 'package:flutter/material.dart';

class AppColors {
  // Saudi-inspired primary colors
  static const Color saudiGreen = Color(0xFF006C35);
  static const Color saudiGreenLight = Color(0xFF00A651);
  static const Color saudiGreenDark = Color(0xFF004D26);
  
  // Secondary colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFF8F9FA);
  static const Color lightGray = Color(0xFFF5F5F5);
  static const Color mediumGray = Color(0xFF6C757D);
  static const Color darkGray = Color(0xFF343A40);
  static const Color black = Color(0xFF000000);
  
  // Primary brand colors
  static const Color primaryBlue = Color(0xFF1E3A8A);
  static const Color accentGold = Color(0xFFFFD700);
  
  // Text colors
  static const Color textPrimary = Color(0xFF1F2937);
  static const Color textSecondary = Color(0xFF6B7280);
  
  // Accent colors
  static const Color gold = Color(0xFFFFD700);
  static const Color goldLight = Color(0xFFF8DC);
  
  // Status colors
  static const Color success = Color(0xFF28A745);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFDC3545);
  static const Color info = Color(0xFF17A2B8);
  
  // Gradient colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [saudiGreen, saudiGreenLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient heroGradient = LinearGradient(
    colors: [saudiGreenDark, saudiGreen],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  // Shadow colors
  static const Color shadowLight = Color(0x1A000000);
  static const Color shadowMedium = Color(0x33000000);
  static const Color shadowDark = Color(0x4D000000);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: MaterialColor(
        AppColors.saudiGreen.value,
        const <int, Color>{
          50: Color(0xFFE8F5E8),
          100: Color(0xFFC8E6C9),
          200: Color(0xFFA5D6A7),
          300: Color(0xFF81C784),
          400: Color(0xFF66BB6A),
          500: AppColors.saudiGreen,
          600: Color(0xFF43A047),
          700: Color(0xFF388E3C),
          800: Color(0xFF2E7D32),
          900: Color(0xFF1B5E20),
        },
      ),
      primaryColor: AppColors.saudiGreen,
      scaffoldBackgroundColor: AppColors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.darkGray,
        elevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.saudiGreen,
          foregroundColor: AppColors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.saudiGreen,
          side: const BorderSide(color: AppColors.saudiGreen),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: AppColors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.mediumGray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.saudiGreen, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      colorScheme: const ColorScheme.light(
        primary: AppColors.saudiGreen,
        secondary: AppColors.gold,
        surface: AppColors.white,
        background: AppColors.offWhite,
        error: AppColors.error,
        onPrimary: AppColors.white,
        onSecondary: AppColors.darkGray,
        onSurface: AppColors.darkGray,
        onBackground: AppColors.darkGray,
        onError: AppColors.white,
      ),
    );
  }
}