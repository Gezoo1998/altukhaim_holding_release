import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/language_provider.dart';
import '../../utils/app_localizations.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../common/animated_section.dart';

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        final isArabic = languageProvider.isArabic;
        
        return LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 768;
            final isTablet = constraints.maxWidth >= 768 && constraints.maxWidth < 1024;
            
            return Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: isMobile ? 80 : 120,
                horizontal: isMobile ? 20 : 40,
              ),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                image: const DecorationImage(
                  image: AssetImage('assets/images/pattern-bg.svg'),
                  fit: BoxFit.cover,
                  opacity: 0.03,
                ),
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Column(
                  children: [
                    // Section Header
                    AnimatedSection(
                      child: _buildSectionHeader(context, isArabic, isMobile),
                    ),
                    
                    const SizedBox(height: 80),
                    
                    // Testimonials Grid
                    if (isMobile)
                      _buildMobileLayout(context, isArabic)
                    else
                      _buildDesktopLayout(context, isArabic, isTablet),
                    
                    const SizedBox(height: 80),
                    
                    // Trust Indicators
                    AnimatedSection(
                      child: _buildTrustIndicators(context, isArabic, isMobile),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSectionHeader(BuildContext context, bool isArabic, bool isMobile) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
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
               AppLocalizations.translate('testimonials_badge', languageProvider.currentLocale.languageCode),
               style: AppTextStyles.labelMedium.copyWith(
                 color: AppColors.primary,
                 fontWeight: FontWeight.w600,
               ),
             ),
            ),
            
            const SizedBox(height: 16),
            
            // Title
            Text(
              AppLocalizations.translate('testimonials_title', languageProvider.currentLocale.languageCode),
              style: AppTextStyles.displayMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 16),
            
            // Subtitle
            Container(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Text(
                AppLocalizations.translate('testimonials_subtitle', languageProvider.currentLocale.languageCode),
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMobileLayout(BuildContext context, bool isArabic) {
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
            isMobile: true,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, bool isArabic, bool isTablet) {
    final testimonials = _getTestimonials(isArabic);
    
    if (isTablet) {
      return Wrap(
        spacing: 24,
        runSpacing: 24,
        children: testimonials.map((testimonial) {
          return SizedBox(
            width: (MediaQuery.of(context).size.width - 128) / 2,
            child: _buildTestimonialCard(
              name: testimonial['name'],
              position: testimonial['position'],
              company: testimonial['company'],
              testimonial: testimonial['quote'],
              rating: testimonial['rating'],
              isArabic: isArabic,
              isMobile: false,
            ),
          );
        }).toList(),
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: testimonials.asMap().entries.map((entry) {
          final index = entry.key;
          final testimonial = entry.value;
          return Expanded(
            child: Container(
              margin: EdgeInsets.only(
                right: index < testimonials.length - 1 ? 24 : 0,
              ),
              child: _buildTestimonialCard(
                name: testimonial['name'],
                position: testimonial['position'],
                company: testimonial['company'],
                testimonial: testimonial['quote'],
                rating: testimonial['rating'],
                isArabic: isArabic,
                isMobile: false,
              ),
            ),
          );
        }).toList(),
      );
    }
  }

  Widget _buildTestimonialCard({
    required String name,
    required String position,
    required String company,
    required String testimonial,
    required int rating,
    required bool isArabic,
    required bool isMobile,
  }) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowMedium,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rating Stars
          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < rating ? Icons.star : Icons.star_border,
                color: AppColors.gold,
                size: 20,
              );
            }),
          ),
          
          const SizedBox(height: 20),
          
          // Testimonial Text
          Text(
            testimonial,
            style: AppTextStyles.bodyLarge.copyWith(
              fontStyle: FontStyle.italic,
              height: 1.6,
            ),
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
          ),
          
          const SizedBox(height: 24),
          
          // Author Info
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Icon(
                  Icons.person,
                  color: AppColors.accent,
                  size: 24,
                ),
              ),
              
              const SizedBox(width: 16),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppTextStyles.titleMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '$position, $company',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textTertiary,
                      ),
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

  Widget _buildTrustIndicators(BuildContext context, bool isArabic, bool isMobile) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return Container(
          padding: EdgeInsets.all(isMobile ? 24 : 40),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowLight,
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              if (isMobile) ...[
                _buildTrustItem(
                  context,
                  '1000+',
                  AppLocalizations.translate('satisfied_clients', languageProvider.currentLocale.languageCode),
                  Icons.people_outline,
                  isArabic,
                ),
                const SizedBox(height: 32),
                _buildTrustItem(
                  context,
                  '98%',
                  AppLocalizations.translate('satisfaction_rate', languageProvider.currentLocale.languageCode),
                  Icons.thumb_up_outlined,
                  isArabic,
                ),
                const SizedBox(height: 32),
                _buildTrustItem(
                  context,
                  '15+',
                  AppLocalizations.translate('years_experience', languageProvider.currentLocale.languageCode),
                  Icons.timeline_outlined,
                  isArabic,
                ),
                const SizedBox(height: 32),
                _buildTrustItem(
                  context,
                  '24/7',
                  AppLocalizations.translate('support_available', languageProvider.currentLocale.languageCode),
                  Icons.support_agent_outlined,
                  isArabic,
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
                      ),
                    ),
                    Expanded(
                      child: _buildTrustItem(
                        context,
                        '98%',
                        AppLocalizations.translate('satisfaction_rate', languageProvider.currentLocale.languageCode),
                        Icons.thumb_up_outlined,
                        isArabic,
                      ),
                    ),
                    Expanded(
                      child: _buildTrustItem(
                        context,
                        '15+',
                        AppLocalizations.translate('years_experience', languageProvider.currentLocale.languageCode),
                        Icons.timeline_outlined,
                        isArabic,
                      ),
                    ),
                    Expanded(
                      child: _buildTrustItem(
                        context,
                        '24/7',
                        AppLocalizations.translate('support_available', languageProvider.currentLocale.languageCode),
                        Icons.support_agent_outlined,
                        isArabic,
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

  Widget _buildTrustItem(BuildContext context, String number, String label, IconData icon, bool isArabic) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.accent.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(32),
          ),
          child: Icon(
            icon,
            color: AppColors.accent,
            size: 32,
          ),
        ),
        
        const SizedBox(height: 16),
        
        Text(
          number,
          style: AppTextStyles.headingLarge.copyWith(
            color: AppColors.accent,
            fontWeight: FontWeight.w800,
          ),
        ),
        
        const SizedBox(height: 8),
        
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
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