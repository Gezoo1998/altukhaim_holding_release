import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/language_provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../utils/app_localizations.dart';

class CTASection extends StatelessWidget {
  const CTASection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        final isArabic = languageProvider.currentLocale.languageCode == 'ar';
        
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.saudiGreen,
                AppColors.saudiGreenDark,
                AppColors.primaryBlue,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 768;
                final isTablet = constraints.maxWidth < 1024;
                
                return Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: Column(
                      children: [
                        // Section Header
                        _buildSectionHeader(context, isArabic, isMobile, isTablet),
                        
                        const SizedBox(height: 50),
                        
                        // CTA Buttons
                        _buildCTAButtons(context, isArabic, isMobile, isTablet),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(BuildContext context, bool isArabic, bool isMobile, bool isTablet) {
    return Column(
      children: [
        Text(
          AppLocalizations.translate('cta_title', isArabic ? 'ar' : 'en'),
          style: AppTextStyles.heading1.copyWith(
            fontSize: isMobile ? 32 : (isTablet ? 40 : 48),
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        
        const SizedBox(height: 20),
        
        Container(
          constraints: BoxConstraints(
            maxWidth: isMobile ? double.infinity : 600,
          ),
          child: Text(
            AppLocalizations.translate('cta_subtitle', isArabic ? 'ar' : 'en'),
            style: AppTextStyles.bodyLarge.copyWith(
              fontSize: isMobile ? 16 : (isTablet ? 18 : 20),
              color: AppColors.white.withValues(alpha: 0.9),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildCTAButtons(BuildContext context, bool isArabic, bool isMobile, bool isTablet) {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      alignment: WrapAlignment.center,
      children: [
        // Primary CTA Button
        _buildCTAButton(
          context: context,
          text: AppLocalizations.translate('work_with_us', isArabic ? 'ar' : 'en'),
          isPrimary: true,
          onPressed: () {
            // Navigate to contact section
            _scrollToSection(context, 'contact');
          },
          isMobile: isMobile,
          isTablet: isTablet,
          isArabic: isArabic,
        ),
        
        // Secondary CTA Button
        _buildCTAButton(
          context: context,
          text: AppLocalizations.translate('explore_opportunities', isArabic ? 'ar' : 'en'),
          isPrimary: false,
          onPressed: () {
            // Navigate to services section
            _scrollToSection(context, 'services');
          },
          isMobile: isMobile,
          isTablet: isTablet,
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
    required bool isMobile,
    required bool isTablet,
    required bool isArabic,
  }) {
    return Container(
      width: isMobile ? double.infinity : (isTablet ? 250 : 280),
      height: 60,
      decoration: BoxDecoration(
        color: isPrimary ? AppColors.accentGold : Colors.transparent,
        border: isPrimary ? null : Border.all(
          color: AppColors.white,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: isPrimary ? [
          BoxShadow(
            color: AppColors.accentGold.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ] : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: AppTextStyles.getBody1(isArabic).copyWith(
                    fontSize: isMobile ? 16 : 18,
                    fontWeight: FontWeight.w600,
                    color: isPrimary ? AppColors.darkGray : AppColors.white,
                  ),
                ),
                
                const SizedBox(width: 10),
                
                Icon(
                  Icons.arrow_forward,
                  color: isPrimary ? AppColors.darkGray : AppColors.white,
                  size: 20,
                ),
              ],
            ),
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