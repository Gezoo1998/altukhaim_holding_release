import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/language_provider.dart';
import '../../utils/app_localizations.dart';
import '../../utils/responsive_helper.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../common/animated_section.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback? onGetInTouch;
  final VoidCallback? onLearnMore;
  
  const HeroSection({
    Key? key,
    this.onGetInTouch,
    this.onLearnMore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final isArabic = languageProvider.currentLocale.languageCode == 'ar';
    
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      height: screenHeight,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Stack(
        children: [
          // Decorative gradient shapes
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.saudiGreen.withValues(alpha: 0.2),
                    AppColors.saudiGreen.withValues(alpha: 0.05),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          
          Positioned(
            bottom: -150,
            left: -150,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.saudiGreen.withValues(alpha: 0.15),
                    AppColors.saudiGreen.withValues(alpha: 0.03),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          
          // Geometric shapes for modern look
          Positioned(
            top: screenHeight * 0.2,
            right: screenWidth * 0.1,
            child: Transform.rotate(
              angle: 0.5,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.saudiGreen.withValues(alpha: 0.1),
                      AppColors.saudiGreen.withValues(alpha: 0.05),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          Positioned(
            bottom: screenHeight * 0.3,
            left: screenWidth * 0.05,
            child: Transform.rotate(
              angle: -0.3,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.gold.withValues(alpha: 0.2),
                      AppColors.gold.withValues(alpha: 0.05),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          // Main content
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.getHorizontalPadding(screenWidth),
                vertical: 40,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Main headline
                  AnimatedSection(
                    duration: const Duration(milliseconds: 1000),
                    child: Text(
                      AppLocalizations.translate('hero_title', languageProvider.currentLocale.languageCode),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.getHeading1(isArabic).copyWith(
                        fontSize: ResponsiveHelper.getHeadingSize(screenWidth, baseSize: 48),
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Subheadline
                  AnimatedSection(
                    duration: const Duration(milliseconds: 1200),
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: ResponsiveHelper.isMobile(screenWidth) ? double.infinity : 800,
                      ),
                      child: Text(
                          AppLocalizations.translate('hero_subtitle', languageProvider.currentLocale.languageCode),
                        textAlign: TextAlign.center,
                        style: AppTextStyles.getSubtitle1(isArabic).copyWith(
                          fontSize: ResponsiveHelper.getBodySize(screenWidth, baseSize: 18),
                          color: AppColors.white.withValues(alpha: 0.9),
                          height: 1.6,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // CTA Buttons
                  AnimatedSection(
                    duration: const Duration(milliseconds: 1400),
                    child: _buildCTAButtons(context, languageProvider, screenWidth, isArabic),
                  ),
                  
                  const SizedBox(height: 60),
                  
                  // Scroll indicator
                  AnimatedSection(
                    duration: const Duration(milliseconds: 1600),
                    child: Column(
                      children: [
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.white.withValues(alpha: 0.7),
                          size: 32,
                        ),
                        const SizedBox(height: 8),
                      Text(
                          AppLocalizations.translate('scroll_down', languageProvider.currentLocale.languageCode),
                        style: AppTextStyles.getCaption(isArabic).copyWith(
                          color: AppColors.white.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
              ),],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCTAButtons(BuildContext context, LanguageProvider languageProvider, double screenWidth, bool isArabic) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: [
        // Primary CTA
        HoverAnimationWrapper(
          child: ElevatedButton(
             onPressed: onLearnMore,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.gold,
              foregroundColor: AppColors.darkGray,
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.isMobile(screenWidth) ? 24 : 32,
                vertical: ResponsiveHelper.isMobile(screenWidth) ? 12 : 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 4,
            ),
            child: Text(
                AppLocalizations.translate('learn_more', languageProvider.currentLocale.languageCode),
              style: AppTextStyles.getButtonText(isArabic).copyWith(
                color: AppColors.darkGray,
                fontSize: ResponsiveHelper.getBodySize(screenWidth, baseSize: 16),
              ),
            ),
          ),
        ),
        
        // Secondary CTA
        HoverAnimationWrapper(
          child: OutlinedButton(
            onPressed: onGetInTouch,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.white,
              side: const BorderSide(color: AppColors.white, width: 2),
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.getHorizontalPadding(screenWidth) * 0.75,
                vertical: ResponsiveHelper.getVerticalPadding(screenWidth) * 0.75,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              AppLocalizations.translate('contact_us', languageProvider.currentLocale.languageCode),
              style: AppTextStyles.getButtonText(isArabic).copyWith(
                color: AppColors.white,
                fontSize: ResponsiveHelper.getBodySize(screenWidth, baseSize: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}