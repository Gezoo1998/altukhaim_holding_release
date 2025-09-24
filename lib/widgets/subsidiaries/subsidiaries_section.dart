import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../providers/language_provider.dart';
import '../../utils/app_localizations.dart';
import '../../utils/responsive_helper.dart';
import '../common/animated_section.dart';

class SubsidiariesSection extends StatelessWidget {
  const SubsidiariesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        final isArabic = languageProvider.currentLocale.languageCode == 'ar';
        final screenWidth = MediaQuery.of(context).size.width;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: ResponsiveHelper.isMobile(screenWidth) ? 60 : 100,
            horizontal: ResponsiveHelper.getHorizontalPadding(screenWidth),
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.surface, AppColors.surface.withOpacity(0.8)],
            ),
          ),
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
        // Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Text(
            AppLocalizations.translate(
              'subsidiaries',
              languageProvider.currentLocale.languageCode,
            ),
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Main Title
        Text(
          AppLocalizations.translate(
            'subsidiaries_title',
            languageProvider.currentLocale.languageCode,
          ),
          style: AppTextStyles.responsiveHeading(
            context,
          ).copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        ),

        const SizedBox(height: 20),

        // Subtitle
        Container(
          constraints: BoxConstraints(
            maxWidth: ResponsiveHelper.isMobile(screenWidth)
                ? double.infinity
                : 600,
          ),
          child: Text(
            AppLocalizations.translate(
              'subsidiaries_subtitle',
              languageProvider.currentLocale.languageCode,
            ),
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textSecondary,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          ),
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
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount;
        double childAspectRatio;
        double spacing;

        if (ResponsiveHelper.isDesktop(screenWidth)) {
          crossAxisCount = 2;
          childAspectRatio = 1.1;
          spacing = 40;
        } else if (ResponsiveHelper.isTablet(screenWidth)) {
          crossAxisCount = 2;
          childAspectRatio = 1.0;
          spacing = 30;
        } else {
          crossAxisCount = 1;
          childAspectRatio = 1.2;
          spacing = 20;
        }

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          childAspectRatio: childAspectRatio,
          crossAxisSpacing: spacing,
          mainAxisSpacing: spacing,
          children: [
            _buildSubsidiaryCard(
              context,
              languageProvider,
              isArabic,
              'tokheim_investments',
              'tokheim_desc',
              Icons.trending_up_rounded,
              AppColors.primary,
              screenWidth,
            ),
            _buildSubsidiaryCard(
              context,
              languageProvider,
              isArabic,
              'tokheim_real_estate',
              'tokheim_real_desc',
              Icons.business_rounded,
              AppColors.accent,
              screenWidth,
            ),
            _buildSubsidiaryCard(
              context,
              languageProvider,
              isArabic,
              'tokheim_tech',
              'tokheim_tech_desc',
              Icons.computer_rounded,
              AppColors.primary,
              screenWidth,
            ),
            _buildSubsidiaryCard(
              context,
              languageProvider,
              isArabic,
              'tokheim_trading',
              'tokheim_trading_desc',
              Icons.public_rounded,
              AppColors.accent,
              screenWidth,
            ),
          ],
        );
      },
    );
  }

  Widget _buildSubsidiaryCard(
    BuildContext context,
    LanguageProvider languageProvider,
    bool isArabic,
    String titleKey,
    String descKey,
    IconData icon,
    Color iconColor,
    double screenWidth,
  ) {
    return AnimatedSection(
      duration: const Duration(milliseconds: 600),
      child: Container(
        padding: EdgeInsets.all(
          ResponsiveHelper.isMobile(screenWidth) ? 24 : 32,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
          border: Border.all(
            color: AppColors.surface.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon with gradient background
            Container(
              width: ResponsiveHelper.isMobile(screenWidth) ? 56 : 64,
              height: ResponsiveHelper.isMobile(screenWidth) ? 56 : 64,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [iconColor, iconColor.withOpacity(0.7)],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: iconColor.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Icon(
                icon,
                size: ResponsiveHelper.isMobile(screenWidth) ? 28 : 32,
                color: AppColors.white,
              ),
            ),

            SizedBox(height: ResponsiveHelper.isMobile(screenWidth) ? 20 : 24),

            // Title
            Text(
              AppLocalizations.translate(
                titleKey,
                languageProvider.currentLocale.languageCode,
              ),
              style: AppTextStyles.headingMedium.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
              textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            ),

            SizedBox(height: ResponsiveHelper.isMobile(screenWidth) ? 12 : 16),

            // Description
            Expanded(
              child: Text(
                AppLocalizations.translate(
                  descKey,
                  languageProvider.currentLocale.languageCode,
                ),
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.6,
                ),
                textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
              ),
            ),

            // Learn More Button with hover effect
            SizedBox(height: ResponsiveHelper.isMobile(screenWidth) ? 16 : 20),
            InkWell(
              onTap: () {
                // Handle subsidiary details navigation
                _showSubsidiaryDetails(
                  context,
                  titleKey,
                  descKey,
                  languageProvider,
                );
              },
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppLocalizations.translate(
                        'learn_more',
                        languageProvider.currentLocale.languageCode,
                      ),
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: iconColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      isArabic
                          ? Icons.arrow_back_rounded
                          : Icons.arrow_forward_rounded,
                      size: 18,
                      color: iconColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSubsidiaryDetails(
    BuildContext context,
    String titleKey,
    String descKey,
    LanguageProvider languageProvider,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(32),
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        AppLocalizations.translate(
                          titleKey,
                          languageProvider.currentLocale.languageCode,
                        ),
                        style: AppTextStyles.headingMedium.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close_rounded),
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Description
                Text(
                  AppLocalizations.translate(
                    descKey,
                    languageProvider.currentLocale.languageCode,
                  ),
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: 24),

                // Contact Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // Navigate to contact section or show contact form
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
