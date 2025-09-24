import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Commonly used text styles
  static TextStyle get heading1 => GoogleFonts.inter(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: AppColors.darkGray,
    height: 1.2,
  );

  static TextStyle get heading3 => GoogleFonts.inter(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.darkGray,
    height: 1.3,
  );

  static TextStyle get heading4 => GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.darkGray,
    height: 1.4,
  );

  static TextStyle get bodyLarge => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: AppColors.mediumGray,
    height: 1.5,
  );

  static TextStyle get bodyMedium => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.mediumGray,
    height: 1.5,
  );

  static TextStyle get bodySmall => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.mediumGray,
    height: 1.5,
  );

  // English fonts (Inter)
  static TextStyle get englishHeading1 => GoogleFonts.inter(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: AppColors.darkGray,
    height: 1.2,
  );

  static TextStyle get englishHeading2 => GoogleFonts.inter(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: AppColors.darkGray,
    height: 1.3,
  );

  static TextStyle get englishHeading3 => GoogleFonts.inter(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.darkGray,
    height: 1.3,
  );

  static TextStyle get englishHeading4 => GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.darkGray,
    height: 1.4,
  );

  static TextStyle get englishSubtitle1 => GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.mediumGray,
    height: 1.5,
  );

  static TextStyle get englishSubtitle2 => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.mediumGray,
    height: 1.5,
  );

  static TextStyle get englishBody1 => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.darkGray,
    height: 1.6,
  );

  static TextStyle get englishBody2 => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.mediumGray,
    height: 1.6,
  );

  static TextStyle get englishCaption => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.mediumGray,
    height: 1.4,
  );

  // Arabic fonts (Cairo)
  static TextStyle get arabicHeading1 => GoogleFonts.cairo(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: AppColors.darkGray,
    height: 1.4,
  );

  static TextStyle get arabicHeading2 => GoogleFonts.cairo(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: AppColors.darkGray,
    height: 1.5,
  );

  static TextStyle get arabicHeading3 => GoogleFonts.cairo(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.darkGray,
    height: 1.5,
  );

  static TextStyle get arabicHeading4 => GoogleFonts.cairo(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.darkGray,
    height: 1.6,
  );

  static TextStyle get arabicSubtitle1 => GoogleFonts.cairo(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.mediumGray,
    height: 1.7,
  );

  static TextStyle get arabicSubtitle2 => GoogleFonts.cairo(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.mediumGray,
    height: 1.7,
  );

  static TextStyle get arabicBody1 => GoogleFonts.cairo(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.darkGray,
    height: 1.8,
  );

  static TextStyle get arabicBody2 => GoogleFonts.cairo(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.mediumGray,
    height: 1.8,
  );

  static TextStyle get arabicCaption => GoogleFonts.cairo(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.mediumGray,
    height: 1.6,
  );

  // Button styles
  static TextStyle get buttonText => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  static TextStyle get buttonTextArabic => GoogleFonts.cairo(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  // Navigation styles
  static TextStyle get navText => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.darkGray,
  );

  static TextStyle get navTextArabic => GoogleFonts.cairo(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.darkGray,
  );

  // Helper methods to get appropriate style based on language
  static TextStyle getHeading1(bool isArabic) => isArabic ? arabicHeading1 : englishHeading1;
  static TextStyle getHeading2(bool isArabic) => isArabic ? arabicHeading2 : englishHeading2;
  static TextStyle getHeading3(bool isArabic) => isArabic ? arabicHeading3 : englishHeading3;
  static TextStyle getHeading4(bool isArabic) => isArabic ? arabicHeading4 : englishHeading4;
  static TextStyle getSubtitle1(bool isArabic) => isArabic ? arabicSubtitle1 : englishSubtitle1;
  static TextStyle getSubtitle2(bool isArabic) => isArabic ? arabicSubtitle2 : englishSubtitle2;
  static TextStyle getBody1(bool isArabic) => isArabic ? arabicBody1 : englishBody1;
  static TextStyle getBody2(bool isArabic) => isArabic ? arabicBody2 : englishBody2;
  static TextStyle getCaption(bool isArabic) => isArabic ? arabicCaption : englishCaption;
  static TextStyle getButtonText(bool isArabic) => isArabic ? buttonTextArabic : buttonText;
  static TextStyle getNavText(bool isArabic) => isArabic ? navTextArabic : navText;

  // Colored variants
  static TextStyle withColor(TextStyle style, Color color) => style.copyWith(color: color);
  static TextStyle withSaudiGreen(TextStyle style) => style.copyWith(color: AppColors.saudiGreen);
  static TextStyle withWhite(TextStyle style) => style.copyWith(color: AppColors.white);
  static TextStyle withGold(TextStyle style) => style.copyWith(color: AppColors.gold);
}