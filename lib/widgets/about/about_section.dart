import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/language_provider.dart';
import '../../utils/app_localizations.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final isArabic = languageProvider.currentLocale.languageCode == 'ar';
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 60 : 100,
        horizontal: isMobile ? 20 : 40,
      ),
      color: AppColors.offWhite,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Section Title
              Text(
                AppLocalizations.translate('about_title', languageProvider.currentLocale.languageCode),
                style: AppTextStyles.getHeading2(isArabic).copyWith(
                  color: AppColors.saudiGreen,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              
              // Section Subtitle
              Text(
                AppLocalizations.translate('about_subtitle', languageProvider.currentLocale.languageCode),
                style: AppTextStyles.getSubtitle1(isArabic).copyWith(
                  color: AppColors.mediumGray,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),
              
              // Content Grid
              if (isMobile)
                _buildMobileLayout(languageProvider, isArabic)
              else
                _buildDesktopLayout(languageProvider, isArabic),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(LanguageProvider languageProvider, bool isArabic) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column - Company Overview
        Expanded(
          flex: 1,
          child: _buildCompanyOverview(languageProvider, isArabic),
        ),
        const SizedBox(width: 60),
        
        // Right Column - Mission, Vision, Values
        Expanded(
          flex: 1,
          child: Column(
            children: [
              _buildMissionVisionValues(languageProvider, isArabic),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(LanguageProvider languageProvider, bool isArabic) {
    return Column(
      children: [
        _buildCompanyOverview(languageProvider, isArabic),
        const SizedBox(height: 60),
        _buildMissionVisionValues(languageProvider, isArabic),
      ],
    );
  }

  Widget _buildCompanyOverview(LanguageProvider languageProvider, bool isArabic) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.translate('about_overview_title', languageProvider.currentLocale.languageCode),
          style: AppTextStyles.getHeading3(isArabic).copyWith(
            color: AppColors.darkGray,
          ),
        ),
        const SizedBox(height: 24),
        
        Text(
          AppLocalizations.translate('about_overview_content', languageProvider.currentLocale.languageCode),
          style: AppTextStyles.getBody1(isArabic).copyWith(
            height: 1.8,
          ),
        ),
        const SizedBox(height: 32),
        
        // Stats Row
        _buildStatsRow(languageProvider, isArabic),
      ],
    );
  }

  Widget _buildStatsRow(LanguageProvider languageProvider, bool isArabic) {
    return Row(
      children: [
        Expanded(
          child: _buildStatItem(
            '25+',
            AppLocalizations.translate('years_experience', languageProvider.currentLocale.languageCode),
            isArabic,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: _buildStatItem(
            '150+',
            AppLocalizations.translate('projects_completed', languageProvider.currentLocale.languageCode),
            isArabic,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: _buildStatItem(
            '12',
            AppLocalizations.translate('subsidiaries_count', languageProvider.currentLocale.languageCode),
            isArabic,
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(String number, String label, bool isArabic) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          number,
          style: AppTextStyles.getHeading2(isArabic).copyWith(
            color: AppColors.saudiGreen,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppTextStyles.getBody2(isArabic).copyWith(
            color: AppColors.mediumGray,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildMissionVisionValues(LanguageProvider languageProvider, bool isArabic) {
    return Column(
      children: [
        // Mission
        _buildMVVCard(
          Icons.flag,
          AppLocalizations.translate('mission_title', languageProvider.currentLocale.languageCode),
          AppLocalizations.translate('mission_content', languageProvider.currentLocale.languageCode),
          isArabic,
        ),
        const SizedBox(height: 32),
        
        // Vision
        _buildMVVCard(
          Icons.visibility,
          AppLocalizations.translate('vision_title', languageProvider.currentLocale.languageCode),
          AppLocalizations.translate('vision_content', languageProvider.currentLocale.languageCode),
          isArabic,
        ),
        const SizedBox(height: 32),
        
        // Values
        _buildMVVCard(
          Icons.star,
          AppLocalizations.translate('values_title', languageProvider.currentLocale.languageCode),
          AppLocalizations.translate('values_content', languageProvider.currentLocale.languageCode),
          isArabic,
        ),
      ],
    );
  }

  Widget _buildMVVCard(IconData icon, String title, String content, bool isArabic) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.saudiGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: AppColors.saudiGreen,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.getHeading4(isArabic).copyWith(
                    color: AppColors.darkGray,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            content,
            style: AppTextStyles.getBody1(isArabic).copyWith(
              height: 1.7,
              color: AppColors.mediumGray,
            ),
          ),
        ],
      ),
    );
  }
}