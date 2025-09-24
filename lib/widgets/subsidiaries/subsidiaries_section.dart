import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../providers/language_provider.dart';
import '../../utils/app_localizations.dart';

class SubsidiariesSection extends StatelessWidget {
  const SubsidiariesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        final isArabic = languageProvider.currentLocale.languageCode == 'ar';
        
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 80),
          color: AppColors.lightGray,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1200),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                // Section Header
                _buildSectionHeader(context, languageProvider, isArabic),
                const SizedBox(height: 60),
                
                // Subsidiaries Grid
                _buildSubsidiariesGrid(context, languageProvider, isArabic),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(BuildContext context, LanguageProvider languageProvider, bool isArabic) {
    return Column(
      children: [
        Text(
          AppLocalizations.translate('subsidiaries_title', languageProvider.currentLocale.languageCode),
          style: AppTextStyles.heading1.copyWith(
            color: AppColors.primaryBlue,
          ),
          textAlign: TextAlign.center,
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        ),
        const SizedBox(height: 16),
        Container(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Text(
            AppLocalizations.translate('subsidiaries_subtitle', languageProvider.currentLocale.languageCode),
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          ),
        ),
      ],
    );
  }

  Widget _buildSubsidiariesGrid(BuildContext context, LanguageProvider languageProvider, bool isArabic) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount;
        double childAspectRatio;
        
        if (constraints.maxWidth > 1000) {
          crossAxisCount = 2;
          childAspectRatio = 1.2;
        } else if (constraints.maxWidth > 600) {
          crossAxisCount = 2;
          childAspectRatio = 1.0;
        } else {
          crossAxisCount = 1;
          childAspectRatio = 1.3;
        }

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          childAspectRatio: childAspectRatio,
          crossAxisSpacing: 30,
          mainAxisSpacing: 30,
          children: [
            _buildSubsidiaryCard(
              context,
              languageProvider,
              isArabic,
              'tokheim_investments',
              'tokheim_desc',
              Icons.trending_up,
              AppColors.primaryBlue,
            ),
            _buildSubsidiaryCard(
              context,
              languageProvider,
              isArabic,
              'tokheim_real_estate',
              'tokheim_real_desc',
              Icons.business,
              AppColors.accentGold,
            ),
            _buildSubsidiaryCard(
              context,
              languageProvider,
              isArabic,
              'tokheim_tech',
              'tokheim_tech_desc',
              Icons.computer,
              AppColors.primaryBlue,
            ),
            _buildSubsidiaryCard(
              context,
              languageProvider,
              isArabic,
              'tokheim_trading',
              'tokheim_trading_desc',
              Icons.public,
              AppColors.accentGold,
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
  ) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              size: 30,
              color: iconColor,
            ),
          ),
          const SizedBox(height: 24),
          
          // Title
          Text(
            AppLocalizations.translate(titleKey, languageProvider.currentLocale.languageCode),
            style: AppTextStyles.heading3.copyWith(
              color: AppColors.textPrimary,
            ),
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          ),
          const SizedBox(height: 12),
          
          // Description
          Expanded(
            child: Text(
              AppLocalizations.translate(descKey, languageProvider.currentLocale.languageCode),
              style: AppTextStyles.getBody1(isArabic).copyWith(
                color: AppColors.textSecondary,
                height: 1.6,
              ),
              textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            ),
          ),
          
          // Learn More Button
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              // Handle subsidiary details navigation
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppLocalizations.translate('learn_more', languageProvider.currentLocale.languageCode),
                  style: AppTextStyles.getBody1(isArabic).copyWith(
                    color: iconColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  isArabic ? Icons.arrow_back : Icons.arrow_forward,
                  size: 16,
                  color: iconColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}