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
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
      ),
      child: Stack(
        children: [
          // Modern geometric background elements
          _buildBackgroundElements(screenWidth, screenHeight),
          
          // Main content
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveHelper.getHorizontalPadding(screenWidth),
                  vertical: 40,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: screenHeight - 80,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  // Badge/Tag
                  AnimatedSection(
                    duration: const Duration(milliseconds: 800),
                    child: _buildHeroBadge(context, languageProvider),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Main headline
                  AnimatedSection(
                    duration: const Duration(milliseconds: 1000),
                    child: Text(
                      AppLocalizations.translate('hero_title', languageProvider.currentLocale.languageCode),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.responsiveDisplay(context).copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Subheadline
                  AnimatedSection(
                    duration: const Duration(milliseconds: 1200),
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: ResponsiveHelper.isMobile(screenWidth) ? double.infinity : 700,
                      ),
                      child: Text(
                        AppLocalizations.translate('hero_subtitle', languageProvider.currentLocale.languageCode),
                        textAlign: TextAlign.center,
                        style: AppTextStyles.heroSubtitle.copyWith(
                          fontSize: ResponsiveHelper.isMobile(screenWidth) ? 18 : 22,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 48),
                  
                  // CTA Buttons
                  AnimatedSection(
                    duration: const Duration(milliseconds: 1400),
                    child: _buildModernCTAButtons(context, languageProvider, screenWidth),
                  ),
                  
                  const SizedBox(height: 80),
                  
                  // Trust indicators or stats
                  AnimatedSection(
                    duration: const Duration(milliseconds: 1600),
                    child: _buildTrustIndicators(context, languageProvider, screenWidth),
                  ),
                  
                  const SizedBox(height: 60),
                  
                  // Scroll indicator
                  AnimatedSection(
                    duration: const Duration(milliseconds: 1800),
                    child: _buildScrollIndicator(context, languageProvider),
                  ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundElements(double screenWidth, double screenHeight) {
    return Stack(
      children: [
        // Gradient overlay for better text readability
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.3),
                Colors.black.withOpacity(0.1),
                Colors.black.withOpacity(0.2),
              ],
            ),
          ),
        ),
        
        // Modern geometric shapes
        Positioned(
          top: screenHeight * 0.1,
          right: screenWidth * 0.1,
          child: AnimatedSection(
            duration: const Duration(milliseconds: 2000),
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  colors: [
                    AppColors.accent.withOpacity(0.2),
                    AppColors.accent.withOpacity(0.05),
                  ],
                ),
                border: Border.all(
                  color: AppColors.accent.withOpacity(0.3),
                  width: 1,
                ),
              ),
            ),
          ),
        ),
        
        Positioned(
          bottom: screenHeight * 0.2,
          left: screenWidth * 0.05,
          child: AnimatedSection(
            duration: const Duration(milliseconds: 2200),
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.secondary.withOpacity(0.3),
                    AppColors.secondary.withOpacity(0.1),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ),
        
        // Floating particles effect
        ...List.generate(6, (index) => Positioned(
          top: (screenHeight * 0.2) + (index * 80),
          right: (screenWidth * 0.8) + (index * 20),
          child: AnimatedSection(
            duration: Duration(milliseconds: 1500 + (index * 200)),
            child: Container(
              width: 4 + (index * 2),
              height: 4 + (index * 2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white.withOpacity(0.3 - (index * 0.05)),
              ),
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildHeroBadge(BuildContext context, LanguageProvider languageProvider) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: AppColors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.accent,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Leading Investment Holding Company',
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernCTAButtons(BuildContext context, LanguageProvider languageProvider, double screenWidth) {
    return Wrap(
      spacing: 20,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: [
        // Primary CTA - Modern gradient button
        HoverAnimationWrapper(
          hoverScale: 1.02,
          elevation: 12,
          child: Container(
            decoration: BoxDecoration(
              gradient: AppColors.accentGradient,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: onLearnMore,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveHelper.isMobile(screenWidth) ? 28 : 36,
                  vertical: ResponsiveHelper.isMobile(screenWidth) ? 16 : 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.translate('learn_more', languageProvider.currentLocale.languageCode),
                    style: AppTextStyles.buttonLarge.copyWith(
                      fontSize: ResponsiveHelper.isMobile(screenWidth) ? 14 : 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: ResponsiveHelper.isMobile(screenWidth) ? 18 : 20,
                    color: AppColors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
        
        // Secondary CTA - Glass morphism style
        HoverAnimationWrapper(
          hoverScale: 1.02,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.white.withOpacity(0.3),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: onGetInTouch,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveHelper.isMobile(screenWidth) ? 28 : 36,
                  vertical: ResponsiveHelper.isMobile(screenWidth) ? 16 : 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                AppLocalizations.translate('contact_us', languageProvider.currentLocale.languageCode),
                style: AppTextStyles.buttonLarge.copyWith(
                  fontSize: ResponsiveHelper.isMobile(screenWidth) ? 14 : 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTrustIndicators(BuildContext context, LanguageProvider languageProvider, double screenWidth) {
    if (ResponsiveHelper.isMobile(screenWidth)) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTrustItem('25+', 'Years Experience'),
          const SizedBox(width: 40),
          Container(
            width: 1,
            height: 40,
            color: AppColors.white.withOpacity(0.3),
          ),
          const SizedBox(width: 40),
          _buildTrustItem('500+', 'Projects Completed'),
          const SizedBox(width: 40),
          Container(
            width: 1,
            height: 40,
            color: AppColors.white.withOpacity(0.3),
          ),
          const SizedBox(width: 40),
          _buildTrustItem('50+', 'Global Partners'),
        ],
      ),
    );
  }

  Widget _buildTrustItem(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: AppTextStyles.headingMedium.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildScrollIndicator(BuildContext context, LanguageProvider languageProvider) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.white.withOpacity(0.1),
            border: Border.all(
              color: AppColors.white.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.white.withOpacity(0.8),
            size: 24,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          AppLocalizations.translate('scroll_down', languageProvider.currentLocale.languageCode),
          style: AppTextStyles.caption.copyWith(
            color: AppColors.white.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}