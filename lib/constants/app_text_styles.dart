import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Display Styles - For Hero Sections
  static TextStyle get displayLarge => GoogleFonts.inter(
    fontSize: 64,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    height: 1.1,
    letterSpacing: -0.02,
  );

  static TextStyle get displayMedium => GoogleFonts.inter(
    fontSize: 48,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.2,
    letterSpacing: -0.01,
  );

  static TextStyle get displaySmall => GoogleFonts.inter(
    fontSize: 36,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
    letterSpacing: -0.005,
  );

  // Heading Styles - Modern Typography Scale
  static TextStyle get headingLarge => GoogleFonts.inter(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.25,
  );

  static TextStyle get headingMedium => GoogleFonts.inter(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static TextStyle get headingSmall => GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.35,
  );

  // Title Styles
  static TextStyle get titleLarge => GoogleFonts.inter(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static TextStyle get titleMedium => GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static TextStyle get titleSmall => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.45,
  );

  // Body Text Styles
  static TextStyle get bodyLarge => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.6,
  );

  static TextStyle get bodyMedium => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  static TextStyle get bodySmall => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  // Label Styles
  static TextStyle get labelLarge => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static TextStyle get labelMedium => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static TextStyle get labelSmall => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 1.4,
    letterSpacing: 0.5,
  );

  // Caption & Overline
  static TextStyle get caption => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textTertiary,
    height: 1.4,
  );

  static TextStyle get overline => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
    height: 1.4,
    letterSpacing: 1.2,
  );

  // Button Styles
  static TextStyle get buttonLarge => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    height: 1.2,
    letterSpacing: 0.2,
  );

  static TextStyle get buttonMedium => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    height: 1.2,
    letterSpacing: 0.2,
  );

  static TextStyle get buttonSmall => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    height: 1.2,
    letterSpacing: 0.3,
  );

  // Specialized Styles
  static TextStyle get heroTitle => GoogleFonts.inter(
    fontSize: 56,
    fontWeight: FontWeight.w800,
    color: AppColors.white,
    height: 1.1,
    letterSpacing: -0.02,
  );

  static TextStyle get heroSubtitle => GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppColors.white.withOpacity(0.9),
    height: 1.5,
  );

  static TextStyle get sectionTitle => GoogleFonts.inter(
    fontSize: 40,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.2,
    letterSpacing: -0.01,
  );

  static TextStyle get sectionSubtitle => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.6,
  );

  static TextStyle get cardTitle => GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static TextStyle get cardSubtitle => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  // Link Styles
  static TextStyle get link => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.accent,
    height: 1.5,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.accent,
  );

  static TextStyle get linkSmall => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.accent,
    height: 1.5,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.accent,
  );

  // Utility Methods for Color Variations
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }

  static TextStyle withOpacity(TextStyle style, double opacity) {
    return style.copyWith(color: style.color?.withOpacity(opacity));
  }

  static TextStyle withWeight(TextStyle style, FontWeight weight) {
    return style.copyWith(fontWeight: weight);
  }

  static TextStyle withSize(TextStyle style, double size) {
    return style.copyWith(fontSize: size);
  }

  // Responsive Text Styles
  static TextStyle responsiveDisplay(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 1200) return displayLarge;
    if (screenWidth > 768) return displayMedium;
    return displaySmall;
  }

  static TextStyle responsiveHeading(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 1200) return headingLarge;
    if (screenWidth > 768) return headingMedium;
    return headingSmall;
  }

  static TextStyle responsiveBody(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 768) return bodyLarge;
    return bodyMedium;
  }
}