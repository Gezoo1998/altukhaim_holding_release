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
            vertical: ResponsiveHelper.isMobile(screenWidth) ? 80 : 120,
            horizontal: ResponsiveHelper.getHorizontalPadding(screenWidth),
          ),
          decoration: const BoxDecoration(
            color: Colors.transparent,
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
                    height: ResponsiveHelper.isMobile(screenWidth) ? 50 : 80,
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
        // Modern Badge with Gradient
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary.withOpacity(0.15),
                AppColors.accent.withOpacity(0.15),
              ],
            ),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.asset(
                    'assets/images/nawaf_logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                AppLocalizations.translate(
                  'subsidiaries',
                  languageProvider.currentLocale.languageCode,
                ),
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        // Enhanced Main Title
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.white, AppColors.white.withOpacity(0.8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [AppColors.white, AppColors.primary.withOpacity(0.9)],
            ).createShader(bounds),
            child: Text(
              AppLocalizations.translate(
                'subsidiaries_title',
                languageProvider.currentLocale.languageCode,
              ),
              style: AppTextStyles.responsiveHeading(context).copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w800,
                height: 1.2,
              ),
              textAlign: TextAlign.center,
              textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Enhanced Subtitle with better styling
        Container(
          constraints: BoxConstraints(
            maxWidth: ResponsiveHelper.isMobile(screenWidth) ? double.infinity : 700,
          ),
          child: Text(
            AppLocalizations.translate(
              'subsidiaries_subtitle',
              languageProvider.currentLocale.languageCode,
            ),
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.white.withOpacity(0.85),
              height: 1.7,
              fontSize: ResponsiveHelper.isMobile(screenWidth) ? 16 : 18,
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
          childAspectRatio = 1.15;
          spacing = 32;
        } else if (ResponsiveHelper.isTablet(screenWidth)) {
          crossAxisCount = 2;
          childAspectRatio = 1.1;
          spacing = 24;
        } else {
          crossAxisCount = 1;
          childAspectRatio = 1.3;
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
            _buildModernSubsidiaryCard(
              context,
              languageProvider,
              isArabic,
              'tokheim_investments',
              'tokheim_desc',
              Icons.trending_up_rounded,
              [AppColors.primary, AppColors.primary.withOpacity(0.6)],
              screenWidth,
            ),
            _buildModernSubsidiaryCard(
              context,
              languageProvider,
              isArabic,
              'tokheim_real_estate',
              'tokheim_real_desc',
              Icons.business_rounded,
              [AppColors.accent, AppColors.accent.withOpacity(0.6)],
              screenWidth,
            ),
            _buildModernSubsidiaryCard(
              context,
              languageProvider,
              isArabic,
              'tokheim_tech',
              'tokheim_tech_desc',
              Icons.computer_rounded,
              [AppColors.primary, AppColors.primary.withOpacity(0.6)],
              screenWidth,
            ),
            _buildModernSubsidiaryCard(
              context,
              languageProvider,
              isArabic,
              'tokheim_trading',
              'tokheim_trading_desc',
              Icons.public_rounded,
              [AppColors.accent, AppColors.accent.withOpacity(0.6)],
              screenWidth,
            ),
          ],
        );
      },
    );
  }

  Widget _buildModernSubsidiaryCard(
    BuildContext context,
    LanguageProvider languageProvider,
    bool isArabic,
    String titleKey,
    String descKey,
    IconData icon,
    List<Color> gradientColors,
    double screenWidth,
  ) {
    return AnimatedSection(
      duration: const Duration(milliseconds: 600),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.all(
            ResponsiveHelper.isMobile(screenWidth) ? 28 : 36,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.white.withOpacity(0.08),
                AppColors.white.withOpacity(0.03),
              ],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: AppColors.white.withOpacity(0.15),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: gradientColors[0].withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Enhanced Icon with modern design
              Container(
                width: ResponsiveHelper.isMobile(screenWidth) ? 64 : 72,
                height: ResponsiveHelper.isMobile(screenWidth) ? 64 : 72,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradientColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: gradientColors[0].withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  size: ResponsiveHelper.isMobile(screenWidth) ? 32 : 36,
                  color: AppColors.white,
                ),
              ),

              SizedBox(height: ResponsiveHelper.isMobile(screenWidth) ? 24 : 28),

              // Enhanced Title
              Text(
                AppLocalizations.translate(
                  titleKey,
                  languageProvider.currentLocale.languageCode,
                ),
                style: AppTextStyles.headingMedium.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: ResponsiveHelper.isMobile(screenWidth) ? 20 : 22,
                  height: 1.3,
                ),
                textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
              ),

              SizedBox(height: ResponsiveHelper.isMobile(screenWidth) ? 16 : 20),

              // Enhanced Description
              Expanded(
                child: Text(
                  AppLocalizations.translate(
                    descKey,
                    languageProvider.currentLocale.languageCode,
                  ),
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.white.withOpacity(0.8),
                    height: 1.7,
                    fontSize: ResponsiveHelper.isMobile(screenWidth) ? 14 : 15,
                  ),
                  textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                ),
              ),

              // Modern Learn More Button
              SizedBox(height: ResponsiveHelper.isMobile(screenWidth) ? 20 : 24),
              InkWell(
                onTap: () {
                  _showSubsidiaryDetails(
                    context,
                    titleKey,
                    descKey,
                    languageProvider,
                  );
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        gradientColors[0].withOpacity(0.2),
                        gradientColors[1].withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: gradientColors[0].withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppLocalizations.translate(
                          'learn_more',
                          languageProvider.currentLocale.languageCode,
                        ),
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        isArabic
                            ? Icons.arrow_back_rounded
                            : Icons.arrow_forward_rounded,
                        size: 18,
                        color: AppColors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
