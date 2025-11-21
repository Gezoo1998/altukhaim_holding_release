import 'package:altukhaim_holding/constants/app_colors.dart';
import 'package:altukhaim_holding/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/language_provider.dart';
import '../../utils/app_localizations.dart';
import '../../utils/responsive_helper.dart';
import '../animated_text.dart';

class CTASection extends StatelessWidget {
  const CTASection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        final isArabic = languageProvider.currentLocale.languageCode == 'ar';
        final screenWidth = MediaQuery.of(context).size.width;

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.accent.withOpacity(0.3),
                AppColors.accentDark.withOpacity(0.2),
                AppColors.primary.withOpacity(0.3),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: ResponsiveHelper.getVerticalSpacing(screenWidth),
              horizontal: ResponsiveHelper.getHorizontalPadding(screenWidth),
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: ResponsiveHelper.getMaxWidth(screenWidth)),
                child: Column(
                  children: [
                    // Section Header
                    _buildSectionHeader(context, isArabic, screenWidth),

                    SizedBox(height: ResponsiveHelper.isMobile(screenWidth) ? 40 : 50),

                    // CTA Buttons
                    _buildCTAButtons(context, isArabic, screenWidth),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    bool isArabic,
    double screenWidth,
  ) {
    return Column(
      children: [
        AnimatedText(
          text: AppLocalizations.translate('cta_title', isArabic ? 'ar' : 'en'),
          style: AppTextStyles.headingLarge.copyWith(
            fontSize: ResponsiveHelper.getHeadingSize(screenWidth, baseSize: 48),
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
          animationType: AnimationType.fadeInUp,
        ),

        const SizedBox(height: 20),

        Container(
          constraints: BoxConstraints(
            maxWidth: ResponsiveHelper.isMobile(screenWidth) ? screenWidth * 0.9 : 600,
          ),
          child: AnimatedText(
            text: AppLocalizations.translate(
              'cta_subtitle',
              isArabic ? 'ar' : 'en',
            ),
            style: AppTextStyles.bodyLarge.copyWith(
              fontSize: ResponsiveHelper.getBodySize(screenWidth, baseSize: 20),
              color: AppColors.white.withValues(alpha: 0.9),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
            animationType: AnimationType.fadeIn,
          ),
        ),
      ],
    );
  }

  Widget _buildCTAButtons(
    BuildContext context,
    bool isArabic,
    double screenWidth,
  ) {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      alignment: WrapAlignment.center,
      children: [
        // Primary CTA Button
        _buildCTAButton(
          context: context,
          text: AppLocalizations.translate(
            'work_with_us',
            isArabic ? 'ar' : 'en',
          ),
          isPrimary: true,
          onPressed: () {
            // Navigate to contact section
            _scrollToSection(context, 'contact');
          },
          screenWidth: screenWidth,
          isArabic: isArabic,
        ),

        // Secondary CTA Button
        _buildCTAButton(
          context: context,
          text: AppLocalizations.translate(
            'explore_opportunities',
            isArabic ? 'ar' : 'en',
          ),
          isPrimary: false,
          onPressed: () {
            // Navigate to services section
            _scrollToSection(context, 'services');
          },
          screenWidth: screenWidth,
          isArabic: isArabic,
        ),
      ],
    );
  }

  Widget _buildCTAButton({
    required BuildContext context,
    required String text,
    required bool isPrimary,
    required VoidCallback onPressed,
    required double screenWidth,
    required bool isArabic,
  }) {
    return Container(
      constraints: BoxConstraints(
        minWidth: ResponsiveHelper.isMobile(screenWidth) ? 200 : 220,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary 
              ? AppColors.white 
              : Colors.transparent,
          foregroundColor: isPrimary 
              ? AppColors.primary 
              : AppColors.white,
          elevation: isPrimary ? 8 : 0,
          shadowColor: isPrimary 
              ? AppColors.white.withOpacity(0.3) 
              : Colors.transparent,
          side: isPrimary 
              ? null 
              : BorderSide(
                  color: AppColors.white.withOpacity(0.5),
                  width: 2,
                ),
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveHelper.isMobile(screenWidth) ? 32 : 40,
            vertical: ResponsiveHelper.isMobile(screenWidth) ? 16 : 20,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          text,
          style: AppTextStyles.buttonLarge.copyWith(
            fontSize: ResponsiveHelper.getBodySize(screenWidth, baseSize: 16),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _scrollToSection(BuildContext context, String section) {
    // This would typically use a scroll controller or navigation
    // For now, we'll just show a snackbar as placeholder
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Navigating to $section section...'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
