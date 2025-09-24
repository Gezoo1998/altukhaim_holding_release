import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/language_provider.dart';
import '../../utils/app_localizations.dart';
import '../../utils/responsive_helper.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../common/animated_section.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final isArabic = languageProvider.currentLocale.languageCode == 'ar';
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: ResponsiveHelper.isMobile(screenWidth) ? 80 : 120,
        horizontal: ResponsiveHelper.getHorizontalPadding(screenWidth),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.surface,
            AppColors.surface.withOpacity(0.8),
          ],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Section Header
              AnimatedSection(
                duration: const Duration(milliseconds: 800),
                child: _buildSectionHeader(context, languageProvider, screenWidth),
              ),
              
              SizedBox(height: ResponsiveHelper.isMobile(screenWidth) ? 60 : 80),
              
              // Main Content
              if (ResponsiveHelper.isMobile(screenWidth))
                _buildMobileLayout(languageProvider, isArabic, screenWidth)
              else
                _buildDesktopLayout(languageProvider, isArabic, screenWidth),
              
              SizedBox(height: ResponsiveHelper.isMobile(screenWidth) ? 60 : 80),
              
              // Company Stats
              AnimatedSection(
                duration: const Duration(milliseconds: 1400),
                child: _buildModernStats(languageProvider, isArabic, screenWidth),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, LanguageProvider languageProvider, double screenWidth) {
    return Column(
      children: [
        // Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Text(
            'About Us',
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Main Title
        Text(
          AppLocalizations.translate('about_title', languageProvider.currentLocale.languageCode),
          style: AppTextStyles.responsiveHeading(context).copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        
        const SizedBox(height: 20),
        
        // Subtitle
        Container(
          constraints: BoxConstraints(
            maxWidth: ResponsiveHelper.isMobile(screenWidth) ? double.infinity : 600,
          ),
          child: Text(
            AppLocalizations.translate('about_subtitle', languageProvider.currentLocale.languageCode),
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textSecondary,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(LanguageProvider languageProvider, bool isArabic, double screenWidth) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column - Company Overview
        Expanded(
          flex: 5,
          child: AnimatedSection(
            duration: const Duration(milliseconds: 1000),
            child: _buildCompanyOverview(languageProvider, isArabic, screenWidth),
          ),
        ),
        
        const SizedBox(width: 80),
        
        // Right Column - Mission, Vision, Values
        Expanded(
          flex: 4,
          child: AnimatedSection(
            duration: const Duration(milliseconds: 1200),
            child: _buildMissionVisionValues(languageProvider, isArabic, screenWidth),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(LanguageProvider languageProvider, bool isArabic, double screenWidth) {
    return Column(
      children: [
        AnimatedSection(
          duration: const Duration(milliseconds: 1000),
          child: _buildCompanyOverview(languageProvider, isArabic, screenWidth),
        ),
        const SizedBox(height: 60),
        AnimatedSection(
          duration: const Duration(milliseconds: 1200),
          child: _buildMissionVisionValues(languageProvider, isArabic, screenWidth),
        ),
      ],
    );
  }

  Widget _buildCompanyOverview(LanguageProvider languageProvider, bool isArabic, double screenWidth) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon and Title
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Icons.business_rounded,
                  color: AppColors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  AppLocalizations.translate('about_overview_title', languageProvider.currentLocale.languageCode),
                  style: AppTextStyles.headingMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Content
          Text(
            AppLocalizations.translate('about_overview_content', languageProvider.currentLocale.languageCode),
            style: AppTextStyles.bodyLarge.copyWith(
              height: 1.7,
              color: AppColors.textSecondary,
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Key Features
          _buildKeyFeatures(languageProvider, isArabic),
        ],
      ),
    );
  }

  Widget _buildKeyFeatures(LanguageProvider languageProvider, bool isArabic) {
    final features = [
      {'icon': Icons.trending_up_rounded, 'text': 'Strategic Investment Focus'},
      {'icon': Icons.public_rounded, 'text': 'Global Market Presence'},
      {'icon': Icons.security_rounded, 'text': 'Risk Management Excellence'},
      {'icon': Icons.groups_rounded, 'text': 'Stakeholder Value Creation'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Key Strengths',
          style: AppTextStyles.titleMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        ...features.map((feature) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  feature['icon'] as IconData,
                  color: AppColors.accent,
                  size: 16,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  feature['text'] as String,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        )).toList(),
      ],
    );
  }

  Widget _buildMissionVisionValues(LanguageProvider languageProvider, bool isArabic, double screenWidth) {
    return Column(
      children: [
        // Mission
        _buildModernMVVCard(
          Icons.flag_rounded,
          AppLocalizations.translate('mission_title', languageProvider.currentLocale.languageCode),
          AppLocalizations.translate('mission_content', languageProvider.currentLocale.languageCode),
          AppColors.primary,
          isArabic,
        ),
        const SizedBox(height: 24),
        
        // Vision
        _buildModernMVVCard(
          Icons.visibility_rounded,
          AppLocalizations.translate('vision_title', languageProvider.currentLocale.languageCode),
          AppLocalizations.translate('vision_content', languageProvider.currentLocale.languageCode),
          AppColors.accent,
          isArabic,
        ),
        const SizedBox(height: 24),
        
        // Values
        _buildModernMVVCard(
          Icons.star_rounded,
          AppLocalizations.translate('values_title', languageProvider.currentLocale.languageCode),
          AppLocalizations.translate('values_content', languageProvider.currentLocale.languageCode),
          AppColors.secondary,
          isArabic,
        ),
      ],
    );
  }

  Widget _buildModernMVVCard(IconData icon, String title, String content, Color accentColor, bool isArabic) {
    return HoverAnimationWrapper(
      hoverScale: 1.02,
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: accentColor.withOpacity(0.1),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon and Title
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: accentColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyles.titleLarge.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Content
            Text(
              content,
              style: AppTextStyles.bodyMedium.copyWith(
                height: 1.6,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernStats(LanguageProvider languageProvider, bool isArabic, double screenWidth) {
    return Container(
      padding: EdgeInsets.all(ResponsiveHelper.isMobile(screenWidth) ? 24 : 40),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: ResponsiveHelper.isMobile(screenWidth)
          ? _buildMobileStatsLayout(languageProvider, isArabic)
          : _buildDesktopStatsLayout(languageProvider, isArabic),
    );
  }

  Widget _buildDesktopStatsLayout(LanguageProvider languageProvider, bool isArabic) {
    return Row(
      children: [
        Expanded(
          child: _buildModernStatItem(
            '25+',
            AppLocalizations.translate('years_experience', languageProvider.currentLocale.languageCode),
            Icons.timeline_rounded,
          ),
        ),
        _buildStatDivider(),
        Expanded(
          child: _buildModernStatItem(
            '500+',
            AppLocalizations.translate('projects_completed', languageProvider.currentLocale.languageCode),
            Icons.assignment_turned_in_rounded,
          ),
        ),
        _buildStatDivider(),
        Expanded(
          child: _buildModernStatItem(
            '12',
            AppLocalizations.translate('subsidiaries_count', languageProvider.currentLocale.languageCode),
            Icons.business_center_rounded,
          ),
        ),
        _buildStatDivider(),
        Expanded(
          child: _buildModernStatItem(
            '50+',
            'Global Partners',
            Icons.handshake_rounded,
          ),
        ),
      ],
    );
  }

  Widget _buildMobileStatsLayout(LanguageProvider languageProvider, bool isArabic) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildModernStatItem(
                '25+',
                AppLocalizations.translate('years_experience', languageProvider.currentLocale.languageCode),
                Icons.timeline_rounded,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _buildModernStatItem(
                '500+',
                AppLocalizations.translate('projects_completed', languageProvider.currentLocale.languageCode),
                Icons.assignment_turned_in_rounded,
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            Expanded(
              child: _buildModernStatItem(
                '12',
                AppLocalizations.translate('subsidiaries_count', languageProvider.currentLocale.languageCode),
                Icons.business_center_rounded,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _buildModernStatItem(
                '50+',
                'Global Partners',
                Icons.handshake_rounded,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildModernStatItem(String number, String label, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: AppColors.white.withOpacity(0.8),
          size: 32,
        ),
        const SizedBox(height: 12),
        Text(
          number,
          style: AppTextStyles.displaySmall.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.white.withOpacity(0.9),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildStatDivider() {
    return Container(
      width: 1,
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 32),
      color: AppColors.white.withOpacity(0.3),
    );
  }
}