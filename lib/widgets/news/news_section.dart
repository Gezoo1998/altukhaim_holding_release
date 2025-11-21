import 'package:altukhaim_holding/widgets/modern_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../providers/language_provider.dart';
import '../../utils/app_localizations.dart';
import '../../utils/responsive_helper.dart';
import '../common/animated_background.dart';
import '../animated_text.dart';
import '../animations/scroll_animations.dart';

class NewsSection extends StatelessWidget {
  const NewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        final isArabic = languageProvider.currentLocale.languageCode == 'ar';
        final screenWidth = MediaQuery.of(context).size.width;
        
        return AnimatedBackground(
          enableParticles: true,
          enableGeometricShapes: true,
          opacity: 0.5,
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
                  children: [
                    // Section Header
                    _buildSectionHeader(context, languageProvider, isArabic, screenWidth),
                    SizedBox(height: ResponsiveHelper.isMobile(screenWidth) ? 40 : 60),
                    
                    // News Grid
                    _buildNewsGrid(context, languageProvider, isArabic, screenWidth),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(BuildContext context, LanguageProvider languageProvider, bool isArabic, double screenWidth) {
    return Column(
      children: [
        AnimatedText(
          text: AppLocalizations.translate('news_title', languageProvider.currentLocale.languageCode),
          style: AppTextStyles.headingLarge.copyWith(
            fontSize: ResponsiveHelper.getHeadingSize(screenWidth, baseSize: 42),
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
          animationType: AnimationType.fadeInUp,
        ),
        const SizedBox(height: 16),
        Container(
          constraints: BoxConstraints(maxWidth: ResponsiveHelper.isMobile(screenWidth) ? screenWidth * 0.9 : 600),
          child: AnimatedText(
            text: AppLocalizations.translate('news_subtitle', languageProvider.currentLocale.languageCode),
            style: AppTextStyles.bodyLarge.copyWith(
              fontSize: ResponsiveHelper.getBodySize(screenWidth, baseSize: 18),
              color: AppColors.white.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
            animationType: AnimationType.fadeIn,
          ),
        ),
      ],
    );
  }

  Widget _buildNewsGrid(BuildContext context, LanguageProvider languageProvider, bool isArabic, double screenWidth) {
    final crossAxisCount = ResponsiveHelper.getGridColumns(screenWidth);
    final spacing = ResponsiveHelper.isMobile(screenWidth) ? 20.0 : 30.0;
    final aspectRatio = ResponsiveHelper.getCardAspectRatio(screenWidth) * 0.7; // Adjusted for news cards

    final newsCards = [
      _buildNewsCard(
        context,
        languageProvider,
        isArabic,
        'news_1_title',
        'news_1_desc',
        '2024-01-15',
        'assets/images/news1.jpg',
        screenWidth,
      ),
      _buildNewsCard(
        context,
        languageProvider,
        isArabic,
        'news_2_title',
        'news_2_desc',
        '2024-01-10',
        'assets/images/news2.jpg',
        screenWidth,
      ),
      _buildNewsCard(
        context,
        languageProvider,
        isArabic,
        'news_3_title',
        'news_3_desc',
        '2024-01-05',
        'assets/images/news3.jpg',
        screenWidth,
      ),
    ];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      childAspectRatio: aspectRatio,
      crossAxisSpacing: spacing,
      mainAxisSpacing: spacing,
      children: newsCards,
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
    double screenWidth,
  ) {
    return ModernCard(
      enableGlass: true,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Placeholder
          Container(
            height: ResponsiveHelper.isMobile(screenWidth) ? 160 : 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
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
            child: Center(
              child: Icon(
                Icons.article,
                size: ResponsiveHelper.isMobile(screenWidth) ? 50 : 60,
                color: Colors.white,
              ),
            ),
          ),
          
          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(ResponsiveHelper.isMobile(screenWidth) ? 16 : 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date
                  Text(
                    _formatDate(date, isArabic),
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: ResponsiveHelper.getBodySize(screenWidth, baseSize: 12),
                      color: AppColors.white.withOpacity(0.7),
                    ),
                    textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                  ),
                  const SizedBox(height: 12),
                  
                  // Title
                  Text(
                    AppLocalizations.translate(titleKey, languageProvider.currentLocale.languageCode),
                    style: AppTextStyles.headingSmall.copyWith(
                      fontSize: ResponsiveHelper.getBodySize(screenWidth, baseSize: 18),
                      color: AppColors.white,
                      height: 1.3,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  
                  // Description
                  Expanded(
                    child: Text(
                      AppLocalizations.translate(descKey, languageProvider.currentLocale.languageCode),
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontSize: ResponsiveHelper.getBodySize(screenWidth, baseSize: 14),
                        color: AppColors.white.withOpacity(0.8),
                        height: 1.6,
                      ),
                      maxLines: ResponsiveHelper.isMobile(screenWidth) ? 2 : 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  
                  // Read More Button
                  const SizedBox(height: 16),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.transparent,
                      ),
                      child: InkWell(
                        onTap: () {
                          // Handle news article navigation
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              AppLocalizations.translate('read_more', languageProvider.currentLocale.languageCode),
                              style: AppTextStyles.bodyMedium.copyWith(
                                fontSize: ResponsiveHelper.getBodySize(screenWidth, baseSize: 14),
                                color: AppColors.accent,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              isArabic ? Icons.arrow_back : Icons.arrow_forward,
                              size: ResponsiveHelper.isMobile(screenWidth) ? 14 : 16,
                              color: AppColors.accent,
                            ),
                          ],
                        ),
                      ),
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
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
      ];
      return '${months[dateTime.month - 1]} ${dateTime.day}, ${dateTime.year}';
    }
  }
}