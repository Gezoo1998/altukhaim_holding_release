import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/language_provider.dart';
import '../../utils/responsive_helper.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../utils/app_localizations.dart';
import '../common/animated_section.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback? onGetInTouch;
  final VoidCallback? onLearnMore;

  const HeroSection({
    super.key,
    this.onGetInTouch,
    this.onLearnMore,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        final isRTL = languageProvider.isArabic;
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;
        final isMobile = ResponsiveHelper.isMobile(screenWidth);
        final isTablet = ResponsiveHelper.isTablet(screenWidth);

        return Container(
          width: double.infinity,
          constraints: BoxConstraints(
            minHeight: screenHeight * 0.9,
          ),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: screenHeight * 0.9,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 20 : (isTablet ? 40 : 80),
                  vertical: isMobile ? 40 : 60,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Badge
                    AnimatedSection(
                      duration: const Duration(milliseconds: 800),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accent.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: AppColors.accent.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Text(
                           'Leading Investment Holding Company',
                           style: AppTextStyles.bodyMedium.copyWith(
                             color: AppColors.accent,
                             fontWeight: FontWeight.w600,
                           ),
                         ),
                      ),
                    ),
                    
                    const SizedBox(height: 30),
                    
                    // Main Headline
                    AnimatedSection(
                      duration: const Duration(milliseconds: 1000),
                      child: Text(
                         AppLocalizations.translate('hero_title', languageProvider.currentLocale.languageCode),
                         textAlign: TextAlign.center,
                        style: isMobile 
                          ? AppTextStyles.headingLarge.copyWith(
                              fontSize: 32,
                              height: 1.2,
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                            )
                          : AppTextStyles.displayLarge.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Subheadline
                    AnimatedSection(
                      duration: const Duration(milliseconds: 1200),
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: isMobile ? screenWidth * 0.9 : 600,
                        ),
                        child: Text(
                          AppLocalizations.translate('hero_subtitle', languageProvider.currentLocale.languageCode),
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: AppColors.white.withOpacity(0.9),
                            height: 1.6,
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // CTA Buttons
                    AnimatedSection(
                      duration: const Duration(milliseconds: 1400),
                      child: Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        alignment: WrapAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: onGetInTouch,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.accent,
                              foregroundColor: AppColors.white,
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 24 : 32,
                                vertical: isMobile ? 12 : 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                               AppLocalizations.translate('get_in_touch', languageProvider.currentLocale.languageCode),
                               style: AppTextStyles.buttonLarge.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          OutlinedButton(
                            onPressed: onLearnMore,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.white,
                              side: BorderSide(
                                color: AppColors.white.withOpacity(0.3),
                                width: 1,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 24 : 32,
                                vertical: isMobile ? 12 : 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                               AppLocalizations.translate('learn_more', languageProvider.currentLocale.languageCode),
                               style: AppTextStyles.buttonLarge.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 60),
                    
                    // Trust Indicators
                    AnimatedSection(
                      duration: const Duration(milliseconds: 1600),
                      child: Column(
                        children: [
                          Text(
                             'Trusted by leading companies',
                             style: AppTextStyles.bodySmall.copyWith(
                               color: AppColors.white.withOpacity(0.7),
                             ),
                           ),
                          const SizedBox(height: 20),
                          Wrap(
                            spacing: 40,
                            runSpacing: 20,
                            alignment: WrapAlignment.center,
                            children: [
                              _buildTrustIndicator('25+', AppLocalizations.translate('years_experience', languageProvider.currentLocale.languageCode)),
                              _buildTrustIndicator('100+', AppLocalizations.translate('projects_completed', languageProvider.currentLocale.languageCode)),
                              _buildTrustIndicator('50+', 'Satisfied Clients'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // Scroll Indicator
                    AnimatedSection(
                      duration: const Duration(milliseconds: 1800),
                      child: Column(
                        children: [
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColors.white.withOpacity(0.6),
                            size: 24,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Scroll to explore',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.white.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTrustIndicator(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: AppTextStyles.headingMedium.copyWith(
            color: AppColors.accent,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
}