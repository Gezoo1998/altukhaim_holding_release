import 'package:flutter/material.dart';

class AppColors {
  // Modern Primary Colors - Deep Blue & Emerald
  static const Color primary = Color(0xFF0F172A); // Slate 900
  static const Color primaryLight = Color(0xFF1E293B); // Slate 800
  static const Color primaryDark = Color(0xFF020617); // Slate 950
  
  // Accent Colors - Modern Emerald & Gold
  static const Color accent = Color(0xFF10B981); // Emerald 500
  static const Color accentLight = Color(0xFF34D399); // Emerald 400
  static const Color accentDark = Color(0xFF059669); // Emerald 600
  
  // Secondary Colors - Sophisticated Blues
  static const Color secondary = Color(0xFF3B82F6); // Blue 500
  static const Color secondaryLight = Color(0xFF60A5FA); // Blue 400
  static const Color secondaryDark = Color(0xFF2563EB); // Blue 600
  
  // Neutral Colors - Modern Grays
  static const Color white = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFFAFAFA); // Neutral 50
  static const Color lightGray = Color(0xFFF5F5F5); // Neutral 100
  static const Color mediumGray = Color(0xFF737373); // Neutral 500
  static const Color darkGray = Color(0xFF404040); // Neutral 700
  static const Color black = Color(0xFF0A0A0A); // Neutral 950
  
  // Surface Colors
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF8FAFC); // Slate 50
  static const Color surfaceContainer = Color(0xFFF1F5F9); // Slate 100
  
  // Text Colors - High Contrast
  static const Color textPrimary = Color(0xFF0F172A); // Slate 900
  static const Color textSecondary = Color(0xFF475569); // Slate 600
  static const Color textTertiary = Color(0xFF94A3B8); // Slate 400
  static const Color textOnDark = Color(0xFFFFFFFF);
  
  // Gold Accent - Luxury Touch
  static const Color gold = Color(0xFFF59E0B); // Amber 500
  static const Color goldLight = Color(0xFFFBBF24); // Amber 400
  static const Color goldDark = Color(0xFFD97706); // Amber 600
  
  // Status Colors - Modern & Accessible
  static const Color success = Color(0xFF10B981); // Emerald 500
  static const Color warning = Color(0xFFF59E0B); // Amber 500
  static const Color error = Color(0xFFEF4444); // Red 500
  static const Color info = Color(0xFF3B82F6); // Blue 500
  
  // Modern Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFF10B981), Color(0xFF34D399)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient heroGradient = LinearGradient(
    colors: [
      Color(0xFF0F172A),
      Color(0xFF1E293B),
      Color(0xFF334155),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 0.6, 1.0],
  );
  
  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFF8FAFC)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient goldGradient = LinearGradient(
    colors: [Color(0xFFF59E0B), Color(0xFFFBBF24)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Modern Shadow Colors
  static const Color shadowLight = Color(0x08000000); // 3% opacity
  static const Color shadowMedium = Color(0x15000000); // 8% opacity
  static const Color shadowDark = Color(0x25000000); // 15% opacity
  static const Color shadowHeavy = Color(0x40000000); // 25% opacity
  
  // Hover & Focus States
  static const Color hoverLight = Color(0x08000000);
  static const Color hoverMedium = Color(0x12000000);
  static const Color focusRing = Color(0x4D3B82F6); // Blue with opacity
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: MaterialColor(
        AppColors.primary.value,
        const <int, Color>{
          50: Color(0xFFF8FAFC),
          100: Color(0xFFF1F5F9),
          200: Color(0xFFE2E8F0),
          300: Color(0xFFCBD5E1),
          400: Color(0xFF94A3B8),
          500: AppColors.primary,
          600: Color(0xFF475569),
          700: Color(0xFF334155),
          800: Color(0xFF1E293B),
          900: Color(0xFF0F172A),
        },
      ),
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: AppColors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ).copyWith(
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return AppColors.accentDark.withOpacity(0.1);
              }
              if (states.contains(MaterialState.pressed)) {
                return AppColors.accentDark.withOpacity(0.2);
              }
              return null;
            },
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.accent,
          side: const BorderSide(color: AppColors.accent, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ).copyWith(
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return AppColors.accent.withOpacity(0.1);
              }
              if (states.contains(MaterialState.pressed)) {
                return AppColors.accent.withOpacity(0.2);
              }
              return null;
            },
          ),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shadowColor: AppColors.shadowMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: AppColors.white,
        surfaceTintColor: Colors.transparent,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.mediumGray, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.mediumGray, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.accent, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        filled: true,
        fillColor: AppColors.surfaceVariant,
      ),
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: AppColors.white,
        background: AppColors.offWhite,
        error: AppColors.error,
        onPrimary: AppColors.white,
        onSecondary: AppColors.white,
        onSurface: AppColors.textPrimary,
        onBackground: AppColors.textPrimary,
        onError: AppColors.white,
        tertiary: AppColors.gold,
        onTertiary: AppColors.white,
        surfaceVariant: AppColors.surfaceVariant,
        onSurfaceVariant: AppColors.textSecondary,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.lightGray,
        thickness: 1,
        space: 1,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surfaceContainer,
        selectedColor: AppColors.accent,
        disabledColor: AppColors.lightGray,
        labelStyle: const TextStyle(color: AppColors.textPrimary),
        secondaryLabelStyle: const TextStyle(color: AppColors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}