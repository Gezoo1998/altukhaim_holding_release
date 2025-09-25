import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../providers/language_provider.dart';
import '../../utils/app_localizations.dart';
import '../../utils/responsive_helper.dart';
import '../common/animated_section.dart';

class TestimonialsSection extends StatefulWidget {
  const TestimonialsSection({super.key});

  @override
  State<TestimonialsSection> createState() => _TestimonialsSectionState();
}

class _TestimonialsSectionState extends State<TestimonialsSection>
    with TickerProviderStateMixin {
  late PageController _pageController;
  int _currentIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

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

                  // Testimonials Carousel
                  AnimatedSection(
                    duration: const Duration(milliseconds: 1000),
                    child: _buildTestimonialsCarousel(
                      context,
                      languageProvider,
                      isArabic,
                      screenWidth,
                    ),
                  ),

                  SizedBox(
                    height: ResponsiveHelper.isMobile(screenWidth) ? 50 : 80,
                  ),

                  // Trust Indicators
                  AnimatedSection(
                    duration: const Duration(milliseconds: 1200),
                    child: _buildTrustIndicators(
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
                AppColors.accent.withOpacity(0.15),
                AppColors.primary.withOpacity(0.15),
              ],
            ),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: AppColors.accent.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.star_rounded,
                color: AppColors.accent,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                AppLocalizations.translate(
                  'testimonials',
                  languageProvider.currentLocale.languageCode,
                ),
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.accent,
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
              colors: [AppColors.white, AppColors.accent.withOpacity(0.9)],
            ).createShader(bounds),
            child: Text(
              AppLocalizations.translate(
                'testimonials_title',
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

        // Enhanced Subtitle
        Container(
          constraints: BoxConstraints(
            maxWidth: ResponsiveHelper.isMobile(screenWidth) ? double.infinity : 700,
          ),
          child: Text(
            AppLocalizations.translate(
              'testimonials_subtitle',
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

  Widget _buildTestimonialsCarousel(
    BuildContext context,
    LanguageProvider languageProvider,
    bool isArabic,
    double screenWidth,
  ) {
    final testimonials = _getTestimonials(languageProvider);

    return Column(
      children: [
        // Testimonials PageView
        Container(
          height: ResponsiveHelper.isMobile(screenWidth) ? 400 : 450,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: testimonials.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveHelper.isMobile(screenWidth) ? 8 : 16,
                ),
                child: _buildModernTestimonialCard(
                  context,
                  testimonials[index],
                  isArabic,
                  screenWidth,
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 40),

        // Modern Page Indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            testimonials.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentIndex == index ? 32 : 8,
              height: 8,
              decoration: BoxDecoration(
                gradient: _currentIndex == index
                    ? LinearGradient(
                        colors: [AppColors.accent, AppColors.primary],
                      )
                    : null,
                color: _currentIndex == index
                    ? null
                    : AppColors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),

        const SizedBox(height: 32),

        // Navigation Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildNavigationButton(
              icon: isArabic ? Icons.arrow_forward_rounded : Icons.arrow_back_rounded,
              onTap: () {
                if (_currentIndex > 0) {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
              isEnabled: _currentIndex > 0,
            ),
            const SizedBox(width: 24),
            _buildNavigationButton(
              icon: isArabic ? Icons.arrow_back_rounded : Icons.arrow_forward_rounded,
              onTap: () {
                if (_currentIndex < testimonials.length - 1) {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
              isEnabled: _currentIndex < testimonials.length - 1,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNavigationButton({
    required IconData icon,
    required VoidCallback onTap,
    required bool isEnabled,
  }) {
    return InkWell(
      onTap: isEnabled ? onTap : null,
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          gradient: isEnabled
              ? LinearGradient(
                  colors: [
                    AppColors.accent.withOpacity(0.2),
                    AppColors.primary.withOpacity(0.2),
                  ],
                )
              : null,
          color: isEnabled ? null : AppColors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isEnabled
                ? AppColors.accent.withOpacity(0.3)
                : AppColors.white.withOpacity(0.2),
            width: 1.5,
          ),
        ),
        child: Icon(
          icon,
          color: isEnabled ? AppColors.white : AppColors.white.withOpacity(0.5),
          size: 20,
        ),
      ),
    );
  }

  Widget _buildModernTestimonialCard(
    BuildContext context,
    Map<String, String> testimonial,
    bool isArabic,
    double screenWidth,
  ) {
    return MouseRegion(
      onEnter: (_) => setState(() {}),
      onExit: (_) => setState(() {}),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.isMobile(screenWidth) ? 8 : 12,
        ),
        child: InkWell(
          onTap: () {
            // Handle testimonial card tap
          },
          borderRadius: BorderRadius.circular(24),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            padding: EdgeInsets.all(
              ResponsiveHelper.isMobile(screenWidth) ? 24 : 32,
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
                  color: AppColors.accent.withOpacity(0.1),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            transform: Matrix4.identity(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Enhanced Quote Icon with animation
                TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 800),
                  tween: Tween(begin: 0.0, end: 1.0),
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: 0.8 + (0.2 * value),
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.accent,
                              AppColors.primary,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.accent.withOpacity(0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.format_quote_rounded,
                          color: AppColors.white,
                          size: 24,
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: ResponsiveHelper.isMobile(screenWidth) ? 20 : 24),

                // Enhanced Testimonial Text with fade-in animation
                TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 1000),
                  tween: Tween(begin: 0.0, end: 1.0),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 20 * (1 - value)),
                        child: Text(
                          testimonial['text']!,
                          style: AppTextStyles.cardBodyOnTransparent.copyWith(
                            fontSize: ResponsiveHelper.isMobile(screenWidth) ? 16 : 18,
                            height: 1.7,
                            fontStyle: FontStyle.italic,
                          ),
                          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: ResponsiveHelper.isMobile(screenWidth) ? 24 : 32),

                // Enhanced Author Info with staggered animation
                TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 1200),
                  tween: Tween(begin: 0.0, end: 1.0),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 30 * (1 - value)),
                        child: Row(
                          children: [
                            // Enhanced Avatar with animation
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.accent.withOpacity(0.3),
                                    AppColors.primary.withOpacity(0.3),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(28),
                                border: Border.all(
                                  color: AppColors.white.withOpacity(0.2),
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.accent.withOpacity(0.2),
                                    blurRadius: 15,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.person_rounded,
                                color: AppColors.white,
                                size: 28,
                              ),
                            ),

                            const SizedBox(width: 16),

                            // Enhanced Author Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    testimonial['author']!,
                                    style: AppTextStyles.cardTitleOnTransparent.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    testimonial['position']!,
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: AppColors.white.withOpacity(0.7),
                                      fontSize: 14,
                                    ),
                                    textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                                  ),
                                ],
                              ),
                            ),

                            // Animated Rating Stars
                            Row(
                              children: List.generate(
                                5,
                                (index) => TweenAnimationBuilder<double>(
                                  duration: Duration(milliseconds: 600 + (index * 100)),
                                  tween: Tween(begin: 0.0, end: 1.0),
                                  builder: (context, starValue, child) {
                                    return Transform.scale(
                                      scale: starValue,
                                      child: Icon(
                                        Icons.star_rounded,
                                        color: AppColors.accent,
                                        size: 18,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTrustIndicators(
    BuildContext context,
    LanguageProvider languageProvider,
    bool isArabic,
    double screenWidth,
  ) {
    return Container(
      padding: EdgeInsets.all(
        ResponsiveHelper.isMobile(screenWidth) ? 32 : 48,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.white.withOpacity(0.06),
            AppColors.white.withOpacity(0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.white.withOpacity(0.1),
          width: 1.5,
        ),
      ),
      child: ResponsiveHelper.isMobile(screenWidth)
          ? Column(
              children: [
                _buildTrustItem(
                  '500+',
                  AppLocalizations.translate(
                    'satisfied_clients',
                    languageProvider.currentLocale.languageCode,
                  ),
                  Icons.people_rounded,
                  isArabic,
                  screenWidth,
                ),
                const SizedBox(height: 32),
                _buildTrustItem(
                  '15+',
                  AppLocalizations.translate(
                    'years_experience',
                    languageProvider.currentLocale.languageCode,
                  ),
                  Icons.timeline_rounded,
                  isArabic,
                  screenWidth,
                ),
                const SizedBox(height: 32),
                _buildTrustItem(
                  '98%',
                  AppLocalizations.translate(
                    'success_rate',
                    languageProvider.currentLocale.languageCode,
                  ),
                  Icons.trending_up_rounded,
                  isArabic,
                  screenWidth,
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: _buildTrustItem(
                    '500+',
                    AppLocalizations.translate(
                      'satisfied_clients',
                      languageProvider.currentLocale.languageCode,
                    ),
                    Icons.people_rounded,
                    isArabic,
                    screenWidth,
                  ),
                ),
                Container(
                  width: 1,
                  height: 80,
                  color: AppColors.white.withOpacity(0.1),
                ),
                Expanded(
                  child: _buildTrustItem(
                    '15+',
                    AppLocalizations.translate(
                      'years_experience',
                      languageProvider.currentLocale.languageCode,
                    ),
                    Icons.timeline_rounded,
                    isArabic,
                    screenWidth,
                  ),
                ),
                Container(
                  width: 1,
                  height: 80,
                  color: AppColors.white.withOpacity(0.1),
                ),
                Expanded(
                  child: _buildTrustItem(
                    '98%',
                    AppLocalizations.translate(
                      'success_rate',
                      languageProvider.currentLocale.languageCode,
                    ),
                    Icons.trending_up_rounded,
                    isArabic,
                    screenWidth,
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildTrustItem(
    String number,
    String label,
    IconData icon,
    bool isArabic,
    double screenWidth,
  ) {
    return Column(
      children: [
        // Enhanced Icon
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.accent, AppColors.primary],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.accent.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: AppColors.white,
            size: 32,
          ),
        ),

        const SizedBox(height: 16),

        // Enhanced Number
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [AppColors.white, AppColors.accent.withOpacity(0.8)],
          ).createShader(bounds),
          child: Text(
            number,
            style: AppTextStyles.displaySmall.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w800,
              fontSize: ResponsiveHelper.isMobile(screenWidth) ? 32 : 40,
            ),
          ),
        ),

        const SizedBox(height: 8),

        // Enhanced Label
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.white.withOpacity(0.8),
            fontWeight: FontWeight.w600,
            fontSize: ResponsiveHelper.isMobile(screenWidth) ? 14 : 16,
          ),
          textAlign: TextAlign.center,
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        ),
      ],
    );
  }

  List<Map<String, String>> _getTestimonials(LanguageProvider languageProvider) {
    final isArabic = languageProvider.currentLocale.languageCode == 'ar';

    if (isArabic) {
      return [
        {
          'text': 'شركة التخيم القابضة شريك موثوق في رحلة نجاحنا. خدماتهم المتميزة وفريقهم المحترف ساعدونا في تحقيق أهدافنا بكفاءة عالية.',
          'author': 'أحمد محمد',
          'position': 'الرئيس التنفيذي، شركة النور للتجارة',
        },
        {
          'text': 'التعامل مع التخيم القابضة كان تجربة رائعة. الاحترافية والجودة في الخدمة جعلتنا نثق بهم كشريك استراتيجي طويل الأمد.',
          'author': 'فاطمة العلي',
          'position': 'مديرة العمليات، مجموعة الخليج',
        },
        {
          'text': 'نقدر الشفافية والالتزام الذي تتمتع به شركة التخيم القابضة. لقد ساهموا بشكل كبير في نمو أعمالنا وتطويرها.',
          'author': 'خالد السعد',
          'position': 'مؤسس شركة التقنية المتقدمة',
        },
      ];
    } else {
      return [
        {
          'text': 'Altukhaim Holding has been a trusted partner in our success journey. Their exceptional services and professional team helped us achieve our goals with high efficiency.',
          'author': 'Ahmed Mohammed',
          'position': 'CEO, Al-Noor Trading Company',
        },
        {
          'text': 'Working with Altukhaim Holding has been an amazing experience. The professionalism and quality of service made us trust them as a long-term strategic partner.',
          'author': 'Fatima Al-Ali',
          'position': 'Operations Manager, Gulf Group',
        },
        {
          'text': 'We appreciate the transparency and commitment that Altukhaim Holding possesses. They have significantly contributed to the growth and development of our business.',
          'author': 'Khalid Al-Saad',
          'position': 'Founder, Advanced Technology Company',
        },
      ];
    }
  }
}