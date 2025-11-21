import 'package:altukhaim_holding/widgets/modern_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/language_provider.dart';
import '../../utils/app_localizations.dart';
import '../../utils/responsive_helper.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../common/animated_section.dart';
import '../common/animated_background.dart';
import '../animated_text.dart';
import '../animations/scroll_animations.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final isArabic = languageProvider.currentLocale.languageCode == 'ar';
    final screenWidth = MediaQuery.of(context).size.width;

    return AnimatedBackground(
      enableParticles: true,
      enableGeometricShapes: true,
      opacity: 0.7,
      child: AnimatedSection(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: ResponsiveHelper.getVerticalSpacing(screenWidth),
            horizontal: ResponsiveHelper.getHorizontalPadding(screenWidth),
          ),
          color: Colors.transparent,
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: ResponsiveHelper.getMaxWidth(screenWidth)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                // Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.white.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    AppLocalizations.translate('services_badge', languageProvider.currentLocale.languageCode),
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Section Title
                AnimatedSection(
                  duration: const Duration(milliseconds: 600),
                  child: Text(
                    AppLocalizations.translate(
                      'services_title',
                      languageProvider.currentLocale.languageCode,
                    ),
                    style: AppTextStyles.displayMedium.copyWith(
                      color: AppColors.white,
                      fontSize: ResponsiveHelper.getHeadingSize(
                        screenWidth,
                        baseSize: 42,
                      ),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),

                // Section Subtitle
                Container(
                  constraints: BoxConstraints(maxWidth: ResponsiveHelper.isMobile(screenWidth) ? screenWidth * 0.9 : 600),
                  child: AnimatedSection(
                    duration: const Duration(milliseconds: 800),
                    child: Text(
                      AppLocalizations.translate(
                        'services_subtitle',
                        languageProvider.currentLocale.languageCode,
                      ),
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.white.withOpacity(0.8),
                        fontSize: ResponsiveHelper.getBodySize(screenWidth, baseSize: 18),
                        height: 1.6,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                
                SizedBox(height: ResponsiveHelper.isMobile(screenWidth) ? 60 : 80),

                // Services Grid
                _buildServicesGrid(languageProvider, isArabic, screenWidth),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildServicesGrid(
    LanguageProvider languageProvider,
    bool isArabic,
    double screenWidth,
  ) {
    final services = [
      {
        'icon': Icons.trending_up,
        'title': 'investment_management',
        'description': 'investment_desc',
      },
      {
        'icon': Icons.business_center,
        'title': 'business_development',
        'description': 'business_desc',
      },
      {
        'icon': Icons.psychology,
        'title': 'consulting_services',
        'description': 'consulting_desc',
      },
      {
        'icon': Icons.location_city,
        'title': 'real_estate',
        'description': 'real_estate_desc',
      },
      {
        'icon': Icons.computer,
        'title': 'technology_solutions',
        'description': 'technology_desc',
      },
      {
        'icon': Icons.account_balance,
        'title': 'financial_services',
        'description': 'financial_desc',
      },
    ];

    if (ResponsiveHelper.isMobile(screenWidth)) {
      return StaggeredScrollAnimation(
        staggerDelay: const Duration(milliseconds: 150),
        animationDuration: const Duration(milliseconds: 800),
        children: services
            .map(
              (service) => Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: HoverAnimationWrapper(
                  elevation: 8,
                  child: _buildServiceCard(
                    service['icon'] as IconData,
                    AppLocalizations.translate(
                      service['title'] as String,
                      languageProvider.currentLocale.languageCode,
                    ),
                    AppLocalizations.translate(
                      service['description'] as String,
                      languageProvider.currentLocale.languageCode,
                    ),
                    isArabic,
                    screenWidth,
                  ),
                ),
              ),
            )
            .toList(),
      );
    } else {
      final crossAxisCount = ResponsiveHelper.isTablet(screenWidth) ? 2 : 3;
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
          childAspectRatio: 1.1,
        ),
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return ScrollFadeIn(
            duration: Duration(milliseconds: 600 + (index * 100)),
            slideFromBottom: true,
            child: HoverAnimationWrapper(
              elevation: 8,
              child: _buildServiceCard(
                service['icon'] as IconData,
                AppLocalizations.translate(
                  service['title'] as String,
                  languageProvider.currentLocale.languageCode,
                ),
                AppLocalizations.translate(
                  service['description'] as String,
                  languageProvider.currentLocale.languageCode,
                ),
                isArabic,
                screenWidth,
              ),
            ),
          );
        },
      );
    }
  }

  Widget _buildServiceCard(
    IconData icon,
    String title,
    String description,
    bool isArabic,
    double screenWidth,
  ) {
    return ModernCard(
      enableGlass: true,
      padding: EdgeInsets.all(ResponsiveHelper.isMobile(screenWidth) ? 24 : 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon Container
          Container(
            width: ResponsiveHelper.isMobile(screenWidth) ? 70 : 80,
            height: ResponsiveHelper.isMobile(screenWidth) ? 70 : 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.accent,
                  AppColors.accent.withValues(alpha: 0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: ResponsiveHelper.isMobile(screenWidth) ? 32 : 36,
            ),
          ),
          const SizedBox(height: 24),

          // Title
          AnimatedText(
            text: title,
            style: AppTextStyles.headingSmall.copyWith(
              fontSize: ResponsiveHelper.getHeadingSize(screenWidth, baseSize: 20),
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            animationType: AnimationType.fadeInUp,
          ),
          const SizedBox(height: 16),

          // Description
          Expanded(
            child: AnimatedText(
              text: description,
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: ResponsiveHelper.getBodySize(screenWidth, baseSize: 14),
                color: AppColors.white.withOpacity(0.8),
                height: 1.6,
              ),
              textAlign: TextAlign.center,
              animationType: AnimationType.fadeIn,
            ),
          ),
          const SizedBox(height: 24),

          // Learn More Button
          TextButton(
            onPressed: () {
              // TODO: Implement service details navigation
            },
            style: TextButton.styleFrom(
              foregroundColor: AppColors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              overlayColor: AppColors.white.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: AppColors.white.withOpacity(0.3),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppLocalizations.translate(
                    'learn_more',
                    'en',
                  ), // Using 'en' as fallback
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: ResponsiveHelper.getBodySize(screenWidth, baseSize: 12),
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  isArabic ? Icons.arrow_back : Icons.arrow_forward,
                  size: 16,
                  color: AppColors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
