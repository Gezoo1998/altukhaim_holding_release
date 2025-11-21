import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../providers/language_provider.dart';
import '../../utils/app_localizations.dart';
import '../../utils/responsive_helper.dart';
import '../common/animated_section.dart';
import '../common/animated_background.dart';
import '../modern_card.dart';
import '../animated_text.dart';
import '../animations/scroll_animations.dart' as scroll_anim;

class SubsidiariesSection extends StatelessWidget {
  const SubsidiariesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        final isArabic = languageProvider.currentLocale.languageCode == 'ar';
        final screenWidth = MediaQuery.of(context).size.width;

        return AnimatedBackground(
          enableParticles: true,
          enableGeometricShapes: true,
          opacity: 0.6,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: ResponsiveHelper.isMobile(screenWidth) ? 60 : 100,
              horizontal: ResponsiveHelper.getHorizontalPadding(screenWidth),
            ),
            decoration: const BoxDecoration(color: Colors.transparent),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1400),
                child: Column(
                  children: [
                    // Section Header
                    AnimatedSection(
                      duration: const Duration(milliseconds: 800),
                      child: _buildSectionHeader(
                        context,
                        languageProvider,
                        isArabic,
                        screenWidth,
                      ),
                    ),
                    SizedBox(
                      height: ResponsiveHelper.isMobile(screenWidth) ? 40 : 60,
                    ),

                    // Subsidiaries Grid
                    AnimatedSection(
                      duration: const Duration(milliseconds: 1000),
                      child: _buildSubsidiariesGrid(
                        context,
                        languageProvider,
                        isArabic,
                        screenWidth,
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

  Widget _buildSectionHeader(
    BuildContext context,
    LanguageProvider languageProvider,
    bool isArabic,
    double screenWidth,
  ) {
    return Column(
      children: [
        AnimatedText(
          text: AppLocalizations.translate(
            'subsidiaries',
            languageProvider.currentLocale.languageCode,
          ),
          style: AppTextStyles.headingLarge.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: ResponsiveHelper.isMobile(screenWidth) ? 32 : 48,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Container(
          width: 80,
          height: 4,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          AppLocalizations.translate(
            'subsidiaries_description',
            languageProvider.currentLocale.languageCode,
          ),
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.white.withOpacity(0.9),
            fontSize: ResponsiveHelper.isMobile(screenWidth) ? 16 : 18,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSubsidiariesGrid(
    BuildContext context,
    LanguageProvider languageProvider,
    bool isArabic,
    double screenWidth,
  ) {
    final subsidiaries = [
      {
        'title': AppLocalizations.translate(
          'altukhaim_trading',
          languageProvider.currentLocale.languageCode,
        ),
        'description': AppLocalizations.translate(
          'altukhaim_trading_desc',
          languageProvider.currentLocale.languageCode,
        ),
        'icon': Icons.business_center_rounded,
      },
      {
        'title': AppLocalizations.translate(
          'altukhaim_real_estate',
          languageProvider.currentLocale.languageCode,
        ),
        'description': AppLocalizations.translate(
          'altukhaim_real_estate_desc',
          languageProvider.currentLocale.languageCode,
        ),
        'icon': Icons.location_city_rounded,
      },
      {
        'title': AppLocalizations.translate(
          'altukhaim_investments',
          languageProvider.currentLocale.languageCode,
        ),
        'description': AppLocalizations.translate(
          'altukhaim_investments_desc',
          languageProvider.currentLocale.languageCode,
        ),
        'icon': Icons.trending_up_rounded,
      },
      {
        'title': AppLocalizations.translate(
          'altukhaim_hospitality',
          languageProvider.currentLocale.languageCode,
        ),
        'description': AppLocalizations.translate(
          'altukhaim_hospitality_desc',
          languageProvider.currentLocale.languageCode,
        ),
        'icon': Icons.hotel_rounded,
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: ResponsiveHelper.isMobile(screenWidth) ? 1 : 2,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: ResponsiveHelper.isMobile(screenWidth) ? 1.2 : 1.1,
      ),
      itemCount: subsidiaries.length,
      itemBuilder: (context, index) {
        final subsidiary = subsidiaries[index];
        return scroll_anim.ScrollFadeIn(
          duration: Duration(milliseconds: 600 + (index * 100)),
          slideFromBottom: true,
          child: ModernCard(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Icon(
                    subsidiary['icon'] as IconData,
                    size: 40,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                   subsidiary['title'] as String,
                   style: AppTextStyles.headingSmall.copyWith(
                     color: AppColors.white,
                     fontWeight: FontWeight.bold,
                   ),
                   textAlign: TextAlign.center,
                 ),
                const SizedBox(height: 16),
                Text(
                  subsidiary['description'] as String,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.white.withOpacity(0.8),
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    // Handle subsidiary details
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.translate(
                      'get_in_touch',
                      languageProvider.currentLocale.languageCode,
                    ),
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
