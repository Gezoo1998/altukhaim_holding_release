import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../providers/language_provider.dart';
import '../../utils/app_localizations.dart';
import '../../utils/responsive_helper.dart';
import '../common/animated_section.dart';
import '../modern_button.dart';
import '../modern_card.dart';
import '../animated_text.dart';
import '../animations/parallax_widget.dart';

class GridPatternPainter extends CustomPainter {
  final Color color;
  
  GridPatternPainter({required this.color});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    
    const gridSize = 20.0;
    
    // Draw vertical lines
    for (double x = 0; x <= size.width; x += gridSize) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }
    
    // Draw horizontal lines
    for (double y = 0; y <= size.height; y += gridSize) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class HoverAnimationWrapper extends StatefulWidget {
  final Widget child;
  final double hoverScale;
  final double elevation;
  
  const HoverAnimationWrapper({
    Key? key,
    required this.child,
    this.hoverScale = 1.05,
    this.elevation = 8,
  }) : super(key: key);
  
  @override
  State<HoverAnimationWrapper> createState() => _HoverAnimationWrapperState();
}

class _HoverAnimationWrapperState extends State<HoverAnimationWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.hoverScale,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _controller.reverse();
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: widget.child,
          );
        },
      ),
    );
  }
}

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
        gradient: AppColors.modernHeroGradient,
      ),
      child: Stack(
        children: [
          // Enhanced background elements with parallax
          _buildModernBackgroundElements(screenWidth, screenHeight),
          
          // Glassmorphism overlay
          _buildGlassmorphismOverlay(),
          
          // Main content with enhanced animations
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
                      // Modern badge with glassmorphism
                      AnimatedText(
                        text: '',
                        animationType: AnimationType.fadeInUp,
                        delay: const Duration(milliseconds: 200),
                        style: AppTextStyles.labelMedium,
                      ),
                      _buildModernHeroBadge(context, languageProvider),
                      
                      const SizedBox(height: 40),
                      
                      // Main headline with typewriter effect
                      AnimatedText(
                        text: AppLocalizations.translate('hero_title', languageProvider.currentLocale.languageCode),
                        animationType: AnimationType.fadeInUp,
                        delay: const Duration(milliseconds: 400),
                        style: AppTextStyles.responsiveDisplay(context).copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w900,
                          height: 1.1,
                          letterSpacing: -0.02,
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Enhanced subheadline
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: ResponsiveHelper.isMobile(screenWidth) ? double.infinity : 700,
                        ),
                        child: AnimatedText(
                          text: AppLocalizations.translate('hero_subtitle', languageProvider.currentLocale.languageCode),
                          animationType: AnimationType.fadeInUp,
                          delay: const Duration(milliseconds: 600),
                          style: AppTextStyles.heroSubtitle.copyWith(
                            fontSize: ResponsiveHelper.isMobile(screenWidth) ? 18 : 24,
                            color: AppColors.white.withOpacity(0.9),
                            height: 1.6,
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 56),
                      
                      // Modern CTA Buttons with enhanced animations
                      _buildEnhancedCTAButtons(context, languageProvider, screenWidth),
                      
                      const SizedBox(height: 80),
                      
                      // Modern trust indicators with glassmorphism
                      _buildModernTrustIndicators(context, languageProvider, screenWidth),
                      
                      const SizedBox(height: 60),
                      
                      // Animated scroll indicator
                      _buildAnimatedScrollIndicator(context, languageProvider),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          // Enhanced floating particles with parallax
          FloatingParticles(
            width: screenWidth,
            height: screenHeight,
            particleCount: 25,
            particleColor: AppColors.white.withOpacity(0.6),
            minSize: 2.0,
            maxSize: 8.0,
          ),
        ],
      ),
    );
  }

  Widget _buildModernBackgroundElements(double screenWidth, double screenHeight) {
    return Stack(
      children: [
        // Enhanced gradient overlay
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.4),
                Colors.black.withOpacity(0.1),
                Colors.black.withOpacity(0.3),
              ],
              stops: [0.0, 0.5, 1.0],
            ),
          ),
        ),
        
        // Modern geometric shapes with enhanced animations
        Positioned(
          top: screenHeight * 0.15,
          right: screenWidth * 0.1,
          child: AnimatedSection(
            duration: const Duration(milliseconds: 2000),
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                gradient: LinearGradient(
                  colors: [
                    AppColors.accent.withOpacity(0.3),
                    AppColors.accent.withOpacity(0.1),
                    Colors.transparent,
                  ],
                ),
                border: Border.all(
                  color: AppColors.accent.withOpacity(0.4),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withOpacity(0.2),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
            ),
          ),
        ),
        
        // Large floating circle
        Positioned(
          bottom: screenHeight * 0.25,
          left: -screenWidth * 0.1,
          child: AnimatedSection(
            duration: const Duration(milliseconds: 2500),
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.secondary.withOpacity(0.4),
                    AppColors.secondary.withOpacity(0.2),
                    AppColors.secondary.withOpacity(0.05),
                    Colors.transparent,
                  ],
                  stops: [0.0, 0.3, 0.7, 1.0],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondary.withOpacity(0.3),
                    blurRadius: 50,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
            ),
          ),
        ),
        
        // Modern grid pattern
        Positioned(
          top: screenHeight * 0.3,
          left: screenWidth * 0.7,
          child: AnimatedSection(
            duration: const Duration(milliseconds: 1800),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.gold.withOpacity(0.3),
                  width: 1,
                ),
                gradient: LinearGradient(
                  colors: [
                    AppColors.gold.withOpacity(0.1),
                    Colors.transparent,
                  ],
                ),
              ),
              child: CustomPaint(
                painter: GridPatternPainter(
                  color: AppColors.gold.withOpacity(0.2),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGlassmorphismOverlay() {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.05),
                Colors.white.withOpacity(0.02),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingParticles(double screenWidth, double screenHeight) {
    return Stack(
      children: List.generate(12, (index) {
        final random = (index * 37) % 100;
        return Positioned(
          top: (screenHeight * 0.1) + (random * 3),
          left: (screenWidth * 0.1) + (random * 5),
          child: AnimatedSection(
            duration: Duration(milliseconds: 1500 + (index * 300)),
            child: Container(
              width: 3 + (index % 4),
              height: 3 + (index % 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.white.withOpacity(0.6),
                    AppColors.white.withOpacity(0.2),
                    Colors.transparent,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.white.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildModernHeroBadge(BuildContext context, LanguageProvider languageProvider) {
    return AnimatedSection(
      duration: const Duration(milliseconds: 800),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(50),
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
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    AppColors.accent,
                    AppColors.accent.withOpacity(0.7),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withOpacity(0.5),
                    blurRadius: 8,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Leading Investment Holding Company',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
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
      child: Flexible(
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
            Flexible(
              child: Text(
                'Leading Investment Holding Company',
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEnhancedCTAButtons(BuildContext context, LanguageProvider languageProvider, double screenWidth) {
    return AnimatedSection(
      duration: const Duration(milliseconds: 1000),
      child: Wrap(
        spacing: 20,
        runSpacing: 16,
        alignment: WrapAlignment.center,
        children: [
          // Primary CTA - Enhanced gradient button
          HoverAnimationWrapper(
            hoverScale: 1.05,
            elevation: 16,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.accent,
                    AppColors.accent.withOpacity(0.8),
                    AppColors.secondary,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withOpacity(0.4),
                    blurRadius: 25,
                    offset: const Offset(0, 12),
                  ),
                  BoxShadow(
                    color: AppColors.accent.withOpacity(0.2),
                    blurRadius: 40,
                    offset: const Offset(0, 20),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: onLearnMore,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveHelper.isMobile(screenWidth) ? 32 : 40,
                    vertical: ResponsiveHelper.isMobile(screenWidth) ? 18 : 22,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          AppLocalizations.translate('learn_more', languageProvider.currentLocale.languageCode),
                          style: AppTextStyles.buttonLarge.copyWith(
                            fontSize: ResponsiveHelper.isMobile(screenWidth) ? 16 : 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        size: ResponsiveHelper.isMobile(screenWidth) ? 18 : 20,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
              ),
            ),
          ),
          
          // Secondary CTA - Enhanced glass morphism style
          HoverAnimationWrapper(
            hoverScale: 1.05,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.white.withOpacity(0.4),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 25,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: ElevatedButton(
                    onPressed: onGetInTouch,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveHelper.isMobile(screenWidth) ? 32 : 40,
                        vertical: ResponsiveHelper.isMobile(screenWidth) ? 18 : 22,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      AppLocalizations.translate('contact_us', languageProvider.currentLocale.languageCode),
                      style: AppTextStyles.buttonLarge.copyWith(
                        fontSize: ResponsiveHelper.isMobile(screenWidth) ? 16 : 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
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

  Widget _buildModernTrustIndicators(BuildContext context, LanguageProvider languageProvider, double screenWidth) {
    if (ResponsiveHelper.isMobile(screenWidth)) {
      return const SizedBox.shrink();
    }

    return AnimatedSection(
      duration: const Duration(milliseconds: 1200),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
        decoration: BoxDecoration(
          color: AppColors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: AppColors.white.withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildEnhancedTrustItem('25+', 'Years Experience', AppColors.accent),
                const SizedBox(width: 50),
                Container(
                  width: 2,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        AppColors.white.withOpacity(0.4),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 50),
                _buildEnhancedTrustItem('500+', 'Projects Completed', AppColors.secondary),
                const SizedBox(width: 50),
                Container(
                  width: 2,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        AppColors.white.withOpacity(0.4),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 50),
                _buildEnhancedTrustItem('50+', 'Global Partners', AppColors.gold),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEnhancedTrustItem(String number, String label, Color accentColor) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                accentColor.withOpacity(0.2),
                accentColor.withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: accentColor.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Text(
            number,
            style: AppTextStyles.headingMedium.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w800,
              fontSize: 28,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.white.withOpacity(0.9),
            fontWeight: FontWeight.w500,
            fontSize: 13,
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

  Widget _buildAnimatedScrollIndicator(BuildContext context, LanguageProvider languageProvider) {
    return AnimatedSection(
      duration: const Duration(milliseconds: 1400),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white.withOpacity(0.1),
              border: Border.all(
                color: AppColors.white.withOpacity(0.3),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.white.withOpacity(0.9),
              size: 28,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Text(
              AppLocalizations.translate('scroll_down', languageProvider.currentLocale.languageCode),
              style: AppTextStyles.caption.copyWith(
                color: AppColors.white.withOpacity(0.8),
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
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