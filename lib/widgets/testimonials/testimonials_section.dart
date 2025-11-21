import 'package:altukhaim_holding/widgets/modern_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/language_provider.dart';
import '../../utils/app_localizations.dart';
import '../../utils/responsive_helper.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../common/animated_section.dart';
import '../animated_text.dart';
import '../animations/scroll_animations.dart';

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        final isArabic = languageProvider.isArabic;
        final screenWidth = MediaQuery.of(context).size.width;
        
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: ResponsiveHelper.getVerticalSpacing(screenWidth),
            horizontal: ResponsiveHelper.getHorizontalPadding(screenWidth),
          ),
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: ResponsiveHelper.getMaxWidth(screenWidth)),
              child: Column(
                children: [
                  // Section Header
                  AnimatedSection(
                    child: _buildSectionHeader(context, isArabic, screenWidth),
                  ),
                  
                  SizedBox(height: ResponsiveHelper.isMobile(screenWidth) ? 60 : 80),
                  
                  // Testimonials Grid
                  if (ResponsiveHelper.isMobile(screenWidth))
                    _buildMobileLayout(context, isArabic, screenWidth)
                  else
                    _buildDesktopLayout(context, isArabic, screenWidth),
                  
                  SizedBox(height: ResponsiveHelper.isMobile(screenWidth) ? 60 : 80),
                  
                  // Trust Indicators
                  AnimatedSection(
                    child: _buildTrustIndicators(context, isArabic, screenWidth),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(BuildContext context, bool isArabic, double screenWidth) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return Column(
          children: [
            // Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
               color: AppColors.white.withOpacity(0.1),
               borderRadius: BorderRadius.circular(20),
               border: Border.all(
                 color: AppColors.white.withOpacity(0.3),
                 width: 1,
               ),
             ),
             child: Text(
               AppLocalizations.translate('testimonials_badge', languageProvider.currentLocale.languageCode),
               style: AppTextStyles.labelMedium.copyWith(
                 color: AppColors.white,
                 fontWeight: FontWeight.w600,
               ),
             ),
            ),
            
            const SizedBox(height: 16),
            
            // Title
            AnimatedText(
              text: AppLocalizations.translate('testimonials_title', languageProvider.currentLocale.languageCode),
              style: AppTextStyles.displayMedium.copyWith(
                fontSize: ResponsiveHelper.getHeadingSize(screenWidth, baseSize: 42),
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
              textAlign: TextAlign.center,
              animationType: AnimationType.fadeInUp,
            ),
            
            const SizedBox(height: 16),
            
            // Subtitle
            Container(
              constraints: BoxConstraints(maxWidth: ResponsiveHelper.isMobile(screenWidth) ? screenWidth * 0.9 : 600),
              child: AnimatedText(
                text: AppLocalizations.translate('testimonials_subtitle', languageProvider.currentLocale.languageCode),
                style: AppTextStyles.bodyLarge.copyWith(
                  fontSize: ResponsiveHelper.getBodySize(screenWidth, baseSize: 18),
                  color: AppColors.white.withOpacity(0.8),
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
                animationType: AnimationType.fadeIn,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMobileLayout(BuildContext context, bool isArabic, double screenWidth) {
    final testimonials = _getTestimonials(isArabic);
    
    return Column(
      children: testimonials.map((testimonial) {
        return Container(
          margin: const EdgeInsets.only(bottom: 24),
          child: _buildTestimonialCard(
            name: testimonial['name'],
            position: testimonial['position'],
            company: testimonial['company'],
            testimonial: testimonial['quote'],
            rating: testimonial['rating'],
            isArabic: isArabic,
            screenWidth: screenWidth,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, bool isArabic, double screenWidth) {
    final testimonials = _getTestimonials(isArabic);
    final crossAxisCount = ResponsiveHelper.isTablet(screenWidth) ? 2 : 3;
    final spacing = ResponsiveHelper.isTablet(screenWidth) ? 24.0 : 32.0;
    
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      childAspectRatio: ResponsiveHelper.isTablet(screenWidth) ? 1.1 : 1.0,
      crossAxisSpacing: spacing,
      mainAxisSpacing: spacing,
      children: testimonials.map((testimonial) {
        return _buildTestimonialCard(
          name: testimonial['name'],
          position: testimonial['position'],
          company: testimonial['company'],
          testimonial: testimonial['quote'],
          rating: testimonial['rating'],
          isArabic: isArabic,
          screenWidth: screenWidth,
        );
      }).toList(),
    );
  }

  Widget _buildTestimonialCard({
    required String name,
    required String position,
    required String company,
    required String testimonial,
    required int rating,
    required bool isArabic,
    required double screenWidth,
  }) {
    return ModernCard(
      enableGlass: true,
      padding: EdgeInsets.all(ResponsiveHelper.isMobile(screenWidth) ? 20 : 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rating Stars
          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < rating ? Icons.star : Icons.star_border,
                color: AppColors.accent,
                size: ResponsiveHelper.isMobile(screenWidth) ? 18 : 20,
              );
            }),
          ),
          
          SizedBox(height: ResponsiveHelper.isMobile(screenWidth) ? 16 : 20),
          
          // Testimonial Text
          Expanded(
            child: Text(
              testimonial,
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: ResponsiveHelper.getBodySize(screenWidth, baseSize: 16),
                color: AppColors.white.withOpacity(0.9),
                height: 1.6,
                fontStyle: FontStyle.italic,
              ),
              textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            ),
          ),
          
          SizedBox(height: ResponsiveHelper.isMobile(screenWidth) ? 16 : 20),
          
          // Author Info
          Row(
            children: [
              // Avatar
              Container(
                width: ResponsiveHelper.isMobile(screenWidth) ? 40 : 48,
                height: ResponsiveHelper.isMobile(screenWidth) ? 40 : 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.accent,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Center(
                  child: Text(
                    name.isNotEmpty ? name[0].toUpperCase() : 'A',
                    style: AppTextStyles.headingSmall.copyWith(
                      fontSize: ResponsiveHelper.isMobile(screenWidth) ? 16 : 18,
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(width: 12),
              
              // Name and Position
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppTextStyles.labelLarge.copyWith(
                        fontSize: ResponsiveHelper.getBodySize(screenWidth, baseSize: 16),
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '$position, $company',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: ResponsiveHelper.getBodySize(screenWidth, baseSize: 14),
                        color: AppColors.white.withOpacity(0.7),
                      ),
                      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrustIndicators(BuildContext context, bool isArabic, double screenWidth) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return ModernCard(
          enableGlass: true,
          padding: EdgeInsets.all(ResponsiveHelper.isMobile(screenWidth) ? 24 : 40),
          child: Column(
            children: [
              if (ResponsiveHelper.isMobile(screenWidth)) ...[
                _buildTrustItem(
                  context,
                  '1000+',
                  AppLocalizations.translate('satisfied_clients', languageProvider.currentLocale.languageCode),
                  Icons.people_outline,
                  isArabic,
                  screenWidth,
                ),
                const SizedBox(height: 32),
                _buildTrustItem(
                  context,
                  '98%',
                  AppLocalizations.translate('satisfaction_rate', languageProvider.currentLocale.languageCode),
                  Icons.thumb_up_outlined,
                  isArabic,
                  screenWidth,
                ),
                const SizedBox(height: 32),
                _buildTrustItem(
                  context,
                  '15+',
                  AppLocalizations.translate('years_experience', languageProvider.currentLocale.languageCode),
                  Icons.timeline_outlined,
                  isArabic,
                  screenWidth,
                ),
                const SizedBox(height: 32),
                _buildTrustItem(
                  context,
                  '24/7',
                  AppLocalizations.translate('support_available', languageProvider.currentLocale.languageCode),
                  Icons.support_agent_outlined,
                  isArabic,
                  screenWidth,
                ),
              ] else ...[
                Row(
                  children: [
                    Expanded(
                      child: _buildTrustItem(
                        context,
                        '1000+',
                        AppLocalizations.translate('satisfied_clients', languageProvider.currentLocale.languageCode),
                        Icons.people_outline,
                        isArabic,
                        screenWidth,
                      ),
                    ),
                    Expanded(
                      child: _buildTrustItem(
                        context,
                        '98%',
                        AppLocalizations.translate('satisfaction_rate', languageProvider.currentLocale.languageCode),
                        Icons.thumb_up_outlined,
                        isArabic,
                        screenWidth,
                      ),
                    ),
                    Expanded(
                      child: _buildTrustItem(
                        context,
                        '15+',
                        AppLocalizations.translate('years_experience', languageProvider.currentLocale.languageCode),
                        Icons.timeline_outlined,
                        isArabic,
                        screenWidth,
                      ),
                    ),
                    Expanded(
                      child: _buildTrustItem(
                        context,
                        '24/7',
                        AppLocalizations.translate('support_available', languageProvider.currentLocale.languageCode),
                        Icons.support_agent_outlined,
                        isArabic,
                        screenWidth,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildTrustItem(BuildContext context, String number, String label, IconData icon, bool isArabic, double screenWidth) {
    return Column(
      children: [
        Container(
          width: ResponsiveHelper.isMobile(screenWidth) ? 56 : 64,
          height: ResponsiveHelper.isMobile(screenWidth) ? 56 : 64,
          decoration: BoxDecoration(
            color: AppColors.accent.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(ResponsiveHelper.isMobile(screenWidth) ? 28 : 32),
          ),
          child: Icon(
            icon,
            color: AppColors.white,
            size: ResponsiveHelper.isMobile(screenWidth) ? 28 : 32,
          ),
        ),
        
        const SizedBox(height: 16),
        
        AnimatedText(
          text: number,
          style: AppTextStyles.headingLarge.copyWith(
            fontSize: ResponsiveHelper.getHeadingSize(screenWidth, baseSize: 32),
            color: AppColors.white,
            fontWeight: FontWeight.w800,
          ),
          animationType: AnimationType.fadeInUp,
        ),
        
        const SizedBox(height: 8),
        
        AnimatedText(
          text: label,
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: ResponsiveHelper.getBodySize(screenWidth, baseSize: 14),
            color: AppColors.white.withOpacity(0.8),
          ),
          textAlign: TextAlign.center,
          animationType: AnimationType.fadeIn,
        ),
      ],
    );
  }

  List<Map<String, dynamic>> _getTestimonials(bool isArabic) {
    if (isArabic) {
      return [
        {
          'quote': 'شركة التخيم القابضة شريك موثوق وموثوق به. خدماتهم المهنية وخبرتهم في السوق السعودي لا مثيل لها.',
          'name': 'أحمد المحمد',
          'position': 'الرئيس التنفيذي',
          'company': 'شركة النور للتطوير',
          'rating': 5,
        },
        {
          'quote': 'التعامل مع التخيم القابضة كان تجربة رائعة. فريقهم محترف ومتفهم لاحتياجات السوق المحلي.',
          'name': 'فاطمة العلي',
          'position': 'مديرة العمليات',
          'company': 'مجموعة الخليج التجارية',
          'rating': 5,
        },
        {
          'quote': 'نوصي بشدة بخدمات شركة التخيم القابضة. لقد ساعدونا في تحقيق أهدافنا الاستراتيجية بكفاءة عالية.',
          'name': 'محمد الراشد',
          'position': 'مؤسس',
          'company': 'شركة الابتكار التقني',
          'rating': 5,
        },
      ];
    } else {
      return [
        {
          'quote': 'Altukhaim Holding has been an exceptional partner. Their professional services and deep understanding of the Saudi market are unmatched.',
          'name': 'Ahmed Al-Mohammed',
          'position': 'CEO',
          'company': 'Al-Noor Development Company',
          'rating': 5,
        },
        {
          'quote': 'Working with Altukhaim Holding has been a remarkable experience. Their team is professional and truly understands local market needs.',
          'name': 'Fatima Al-Ali',
          'position': 'Operations Manager',
          'company': 'Gulf Commercial Group',
          'rating': 5,
        },
        {
          'quote': 'We highly recommend Altukhaim Holding\'s services. They have helped us achieve our strategic goals with exceptional efficiency.',
          'name': 'Mohammed Al-Rashid',
          'position': 'Founder',
          'company': 'Innovation Tech Company',
          'rating': 5,
        },
      ];
    }
  }
}