import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../widgets/header/app_header.dart';
import '../widgets/hero/hero_section.dart';
import '../widgets/about/about_section.dart';

import '../widgets/subsidiaries/subsidiaries_section.dart';
import '../widgets/news/news_section.dart';
import '../widgets/cta/cta_section.dart';
import '../widgets/contact/contact_section.dart';
import '../widgets/footer/footer_section.dart';
import '../widgets/testimonials/testimonials_section.dart';
import '../constants/app_colors.dart';
import '../widgets/common/animated_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _subsidiariesKey = GlobalKey();
  final GlobalKey _newsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(String section) {
    GlobalKey? targetKey;
    
    switch (section) {
      case 'home':
        targetKey = _homeKey;
        break;
      case 'about':
        targetKey = _aboutKey;
        break;
      case 'subsidiaries':
        targetKey = _subsidiariesKey;
        break;
      case 'news':
        targetKey = _newsKey;
        break;
      case 'contact':
        targetKey = _contactKey;
        break;
    }

    if (targetKey?.currentContext != null) {
      Scrollable.ensureVisible(
        targetKey!.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  void _handleGetInTouch() {
    _scrollToSection('contact');
  }

  void _handleLearnMore() {
    _scrollToSection('about');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;
        
        return Directionality(
          textDirection: languageProvider.textDirection,
          child: Scaffold(
            backgroundColor: AppColors.white,
            body: Container(
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
              ),
              child: Stack(
                children: [
                  // Global background elements
                  _buildGlobalBackgroundElements(screenWidth, screenHeight),
                  
                  // Main content
                  Column(
                    children: [
                      // Header
                      AppHeader(onNavigate: _scrollToSection),
                      
                      // Scrollable Content
                      Expanded(
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: Column(
                            children: [
                              // Hero Section (without its own background now)
                              Container(
                                key: _homeKey,
                                child: HeroSection(
                                  onGetInTouch: _handleGetInTouch,
                                  onLearnMore: _handleLearnMore,
                                ),
                              ),
                              
                              // About Section
                              Container(
                                key: _aboutKey,
                                child: const AboutSection(),
                              ),
                              
                              // Subsidiaries Section
                              Container(
                                key: _subsidiariesKey,
                                child: const SubsidiariesSection(),
                              ),
                              
                              // News Section
                              Container(
                                key: _newsKey,
                                child: const NewsSection(),
                              ),
                              
                              // Testimonials Section
                              const TestimonialsSection(),
                              
                              // CTA Section
                              const CTASection(),
                              
                              // Contact Section
                              Container(
                                key: _contactKey,
                                child: const ContactSection(),
                              ),
                              
                              // Footer Section
                              const FooterSection(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGlobalBackgroundElements(double screenWidth, double screenHeight) {
    return Stack(
      children: [
        // Gradient overlay for better text readability
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.1),
                Colors.black.withOpacity(0.05),
                Colors.black.withOpacity(0.1),
                Colors.black.withOpacity(0.05),
              ],
              stops: const [0.0, 0.3, 0.7, 1.0],
            ),
          ),
        ),
        
        // Modern geometric shapes - positioned throughout the page
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
                    AppColors.accent.withOpacity(0.15),
                    AppColors.accent.withOpacity(0.03),
                  ],
                ),
                border: Border.all(
                  color: AppColors.accent.withOpacity(0.2),
                  width: 1,
                ),
              ),
            ),
          ),
        ),
        
        Positioned(
          top: screenHeight * 0.4,
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
                    AppColors.secondary.withOpacity(0.2),
                    AppColors.secondary.withOpacity(0.05),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ),
        
        Positioned(
          top: screenHeight * 0.7,
          right: screenWidth * 0.15,
          child: AnimatedSection(
            duration: const Duration(milliseconds: 2400),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withOpacity(0.1),
                    AppColors.primary.withOpacity(0.02),
                  ],
                ),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.15),
                  width: 1,
                ),
              ),
            ),
          ),
        ),
        
        // Floating particles effect throughout the page
        ...List.generate(8, (index) => Positioned(
          top: (screenHeight * 0.15) + (index * 120),
          right: (screenWidth * 0.85) + ((index % 3) * 30),
          child: AnimatedSection(
            duration: Duration(milliseconds: 1500 + (index * 200)),
            child: Container(
              width: 6 + (index % 3) * 2,
              height: 6 + (index % 3) * 2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accent.withOpacity(0.3 - (index * 0.02)),
              ),
            ),
          ),
        )),
        
        // Additional geometric elements for visual interest
        Positioned(
          top: screenHeight * 1.2,
          left: screenWidth * 0.1,
          child: AnimatedSection(
            duration: const Duration(milliseconds: 2600),
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  colors: [
                    AppColors.accent.withOpacity(0.12),
                    AppColors.accent.withOpacity(0.02),
                  ],
                ),
              ),
            ),
          ),
        ),
        
        Positioned(
          top: screenHeight * 1.5,
          right: screenWidth * 0.08,
          child: AnimatedSection(
            duration: const Duration(milliseconds: 2800),
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withOpacity(0.15),
                    AppColors.primary.withOpacity(0.03),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}