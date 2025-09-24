import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../widgets/header/app_header.dart';
import '../widgets/hero/hero_section.dart';
import '../widgets/about/about_section.dart';
import '../widgets/services/services_section.dart';
import '../widgets/subsidiaries/subsidiaries_section.dart';
import '../widgets/news/news_section.dart';
import '../widgets/cta/cta_section.dart';
import '../widgets/contact/contact_section.dart';
import '../widgets/footer/footer_section.dart';
import '../constants/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
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
      case 'services':
        targetKey = _servicesKey;
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
        return Directionality(
          textDirection: languageProvider.textDirection,
          child: Scaffold(
            backgroundColor: AppColors.white,
            body: Column(
              children: [
                // Header
                AppHeader(onNavigate: _scrollToSection),
                
                // Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: [
                        // Hero Section
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
                        
                        // Services Section
                        Container(
                          key: _servicesKey,
                          child: const ServicesSection(),
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
          ),
        );
      },
    );
  }
}