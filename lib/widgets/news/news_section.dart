import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../providers/language_provider.dart';
import '../../utils/app_localizations.dart';

class NewsSection extends StatelessWidget {
  const NewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        final isArabic = languageProvider.currentLocale.languageCode == 'ar';

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 80),
          color: Colors.transparent,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1200),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                // Section Header
                _buildSectionHeader(context, languageProvider, isArabic),
                const SizedBox(height: 60),

                // News Grid
                _buildNewsGrid(context, languageProvider, isArabic),
              ],
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
  ) {
    return Column(
      children: [
        Text(
          AppLocalizations.translate(
            'news_title',
            languageProvider.currentLocale.languageCode,
          ),
          style: AppTextStyles.headingLarge.copyWith(color: AppColors.primary),
          textAlign: TextAlign.center,
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        ),
        const SizedBox(height: 16),
        Container(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Text(
            AppLocalizations.translate(
              'news_subtitle',
              languageProvider.currentLocale.languageCode,
            ),
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

  Widget _buildNewsGrid(
    BuildContext context,
    LanguageProvider languageProvider,
    bool isArabic,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount;
        double childAspectRatio;
        double crossAxisSpacing;
        double mainAxisSpacing;

        if (constraints.maxWidth > 900) {
          crossAxisCount = 3;
          childAspectRatio = 0.8;
          crossAxisSpacing = 30;
          mainAxisSpacing = 30;
        } else if (constraints.maxWidth > 600) {
          crossAxisCount = 2;
          childAspectRatio = 0.9;
          crossAxisSpacing = 24;
          mainAxisSpacing = 24;
        } else {
          crossAxisCount = 1;
          childAspectRatio = 1; // Increased from 1.1 to give more height
          crossAxisSpacing = 16;
          mainAxisSpacing = 20;
        }

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          childAspectRatio: childAspectRatio,
          crossAxisSpacing: crossAxisSpacing,
          mainAxisSpacing: mainAxisSpacing,
          children: [
            _buildNewsCard(
              context,
              languageProvider,
              isArabic,
              'news_1_title',
              'news_1_desc',
              '2024-01-15',
              'assets/images/news1.jpg',
            ),
            _buildNewsCard(
              context,
              languageProvider,
              isArabic,
              'news_2_title',
              'news_2_desc',
              '2024-01-10',
              'assets/images/news2.jpg',
            ),
            _buildNewsCard(
              context,
              languageProvider,
              isArabic,
              'news_3_title',
              'news_3_desc',
              '2024-01-05',
              'assets/images/news3.jpg',
            ),
          ],
        );
      },
    );
  }

  Widget _buildNewsCard(
    BuildContext context,
    LanguageProvider languageProvider,
    bool isArabic,
    String titleKey,
    String descKey,
    String date,
    String imagePath,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= 600;

    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.white.withOpacity(0.1), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Placeholder
          Container(
            height: isMobile ? 160 : 200, // Reduced height for mobile
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary.withValues(alpha: 0.8),
                  AppColors.accent.withValues(alpha: 0.8),
                ],
              ),
            ),
            child: const Center(
              child: Icon(Icons.article, size: 60, color: Colors.white),
            ),
          ),

          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(
                isMobile ? 16 : 24,
              ), // Reduced padding for mobile
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date
                  Text(
                    _formatDate(date, isArabic),
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: isMobile ? 12 : 14, // Smaller font for mobile
                    ),
                    textDirection: isArabic
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                  ),
                  SizedBox(
                    height: isMobile ? 8 : 12,
                  ), // Reduced spacing for mobile
                  // Title
                  Text(
                    AppLocalizations.translate(
                      titleKey,
                      languageProvider.currentLocale.languageCode,
                    ),
                    style: AppTextStyles.headingSmall.copyWith(
                      color: AppColors.textPrimary,
                      height: 1.3,
                      fontSize: isMobile ? 16 : 18, // Smaller font for mobile
                    ),
                    textDirection: isArabic
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: isMobile ? 8 : 12,
                  ), // Reduced spacing for mobile
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
                        fontSize: isMobile ? 13 : 15, // Smaller font for mobile
                      ),
                      textDirection: isArabic
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      maxLines: isMobile ? 2 : 3, // Fewer lines for mobile
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  // Read More Button
                  SizedBox(
                    height: isMobile ? 12 : 16,
                  ), // Reduced spacing for mobile
                  InkWell(
                    onTap: () {
                      // Handle news article navigation
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          AppLocalizations.translate(
                            'read_more',
                            languageProvider.currentLocale.languageCode,
                          ),
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          isArabic ? Icons.arrow_back : Icons.arrow_forward,
                          size: 16,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String date, bool isArabic) {
    final DateTime dateTime = DateTime.parse(date);
    if (isArabic) {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    } else {
      const months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      return '${months[dateTime.month - 1]} ${dateTime.day}, ${dateTime.year}';
    }
  }
}
