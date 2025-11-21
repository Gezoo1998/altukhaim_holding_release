import 'dart:ui';
import '../animated_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/language_provider.dart';
import '../../utils/app_localizations.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../common/animated_section.dart';

class AppHeader extends StatefulWidget implements PreferredSizeWidget {
  final Function(String)? onNavigate;

  const AppHeader({super.key, this.onNavigate});

  @override
  State<AppHeader> createState() => _AppHeaderState();

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _AppHeaderState extends State<AppHeader> with TickerProviderStateMixin {
  bool _isMenuOpen = false;
  late AnimationController _menuController;
  late Animation<double> _menuAnimation;

  @override
  void initState() {
    super.initState();
    _menuController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _menuAnimation = CurvedAnimation(
      parent: _menuController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _menuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final isArabic = languageProvider.currentLocale.languageCode == 'ar';
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth < 1024;

    return Container(
      height: 80,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.surface.withOpacity(0.95),
            AppColors.surface.withOpacity(0.85),
            AppColors.primary.withOpacity(0.1),
          ],
          stops: const [0.0, 0.7, 1.0],
        ),
        border: Border(
          bottom: BorderSide(
            color: AppColors.white.withOpacity(0.15),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight.withOpacity(0.3),
            blurRadius: 25,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: AppColors.primary.withOpacity(0.1),
            blurRadius: 40,
            offset: const Offset(0, 4),
            spreadRadius: -5,
          ),
        ],
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.white.withOpacity(0.2),
                  AppColors.white.withOpacity(0.1),
                ],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : (isTablet ? 32 : 48),
              ),
              child: Row(
                children: [
                  // Logo
                  _buildLogo(languageProvider, isMobile),
                  const Spacer(),

                  if (!isMobile) ...[
                    // Desktop Navigation
                    _buildDesktopNavigation(languageProvider),
                    const SizedBox(width: 32),
                    _buildLanguageToggle(languageProvider),
                  ] else ...[
                    // Mobile Language Toggle
                    _buildLanguageToggle(languageProvider),
                    const SizedBox(width: 16),
                    // Mobile Menu Button
                    _buildMobileMenuButton(),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(LanguageProvider languageProvider, bool isMobile) {
    return AnimatedSection(
      duration : const Duration(milliseconds: 100),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: isMobile ? 40 : 48,
            height: isMobile ? 40 : 48,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.business_center_rounded,
              color: AppColors.surface,
              size: isMobile ? 20 : 24,
            ),
          ),
          if (!isMobile) ...[
            const SizedBox(width: 16),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedText(
                  text: AppLocalizations.translate(
                    'hero_title',
                    languageProvider.currentLocale.languageCode,
                  ),
                  style: AppTextStyles.headingSmall.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                  animationType: AnimationType.fadeInUp,
                  duration: const Duration(milliseconds: 600),
                ),
                AnimatedText(
                  text: AppLocalizations.translate(
                    'company_tagline',
                    languageProvider.currentLocale.languageCode,
                  ),
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.white.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                  ),
                  animationType: AnimationType.fadeIn,
                  duration: const Duration(milliseconds: 800),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDesktopNavigation(LanguageProvider languageProvider) {
    final navItems = [
      {
        'key': 'home',
        'label': AppLocalizations.translate(
          'home',
          languageProvider.currentLocale.languageCode,
        ),
        'icon': Icons.home_rounded,
      },
      {
        'key': 'about',
        'label': AppLocalizations.translate(
          'about_us',
          languageProvider.currentLocale.languageCode,
        ),
        'icon': Icons.info_rounded,
      },
      {
        'key': 'services',
        'label': AppLocalizations.translate(
          'services',
          languageProvider.currentLocale.languageCode,
        ),
        'icon': Icons.business_rounded,
      },
      {
        'key': 'subsidiaries',
        'label': AppLocalizations.translate(
          'subsidiaries',
          languageProvider.currentLocale.languageCode,
        ),
        'icon': Icons.account_tree_rounded,
      },
      {
        'key': 'news',
        'label': AppLocalizations.translate(
          'news',
          languageProvider.currentLocale.languageCode,
        ),
        'icon': Icons.article_rounded,
      },
      {
        'key': 'contact',
        'label': AppLocalizations.translate(
          'contact',
          languageProvider.currentLocale.languageCode,
        ),
        'icon': Icons.contact_mail_rounded,
      },
    ];

    return AnimatedSection(
      duration: const Duration(milliseconds: 200),
      child: Row(
        children: navItems.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          
          return AnimatedSection(
            duration: Duration(milliseconds: 300 + (index * 50)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: HoverAnimationWrapper(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextButton(
                    onPressed: () {
                      if (widget.onNavigate != null) {
                        widget.onNavigate!(item['key']! as String);
                      }
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      overlayColor: AppColors.white.withOpacity(0.1),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          item['icon'] as IconData,
                          size: 18,
                          color: AppColors.white.withOpacity(0.8),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          item['label']! as String,
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLanguageToggle(LanguageProvider languageProvider) {
    return AnimatedSection(
      duration: const Duration(milliseconds: 400),
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 140,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.white.withOpacity(0.25),
              AppColors.white.withOpacity(0.15),
            ],
          ),
          border: Border.all(
            color: AppColors.white.withOpacity(0.4),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowLight.withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: AppColors.primary.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 2),
              spreadRadius: -2,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: IntrinsicWidth(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildLanguageButton('العربية', 'ar', languageProvider),
                  _buildLanguageButton('EN', 'en', languageProvider),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageButton(
    String text,
    String languageCode,
    LanguageProvider languageProvider,
  ) {
    final isSelected =
        languageProvider.currentLocale.languageCode == languageCode;

    return HoverAnimationWrapper(
      child: GestureDetector(
        onTap: () {
          languageProvider.setLanguage(languageCode);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOutCubic,
          padding: EdgeInsets.symmetric(
            horizontal: languageCode == 'ar' ? 12 : 14,
            vertical: 10,
          ),
          constraints: BoxConstraints(
            minWidth: languageCode == 'ar' ? 55 : 45,
          ),
          decoration: BoxDecoration(
            gradient: isSelected 
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withOpacity(0.8),
                    ],
                  )
                : null,
            color: isSelected ? null : Colors.transparent,
            borderRadius: BorderRadius.circular(22),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 3),
                      spreadRadius: 0,
                    ),
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                      spreadRadius: -2,
                    ),
                  ]
                : [
                    BoxShadow(
                      color: AppColors.white.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                      spreadRadius: 0,
                    ),
                  ],
          ),
          child: Center(
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: AppTextStyles.labelMedium.copyWith(
                color: isSelected 
                    ? AppColors.surface 
                    : AppColors.white.withOpacity(0.9),
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                fontSize: 13,
                letterSpacing: 0.5,
              ),
              child: Text(
                text,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileMenuButton() {
    return AnimatedSection(
      duration: const Duration(milliseconds: 500),
      child: HoverAnimationWrapper(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.white.withOpacity(0.3),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowLight,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            onPressed: () {
              setState(() {
                _isMenuOpen = !_isMenuOpen;
              });
              if (_isMenuOpen) {
                _menuController.forward();
              } else {
                _menuController.reverse();
              }
              _showMobileMenu();
            },
            icon: AnimatedBuilder(
              animation: _menuAnimation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _menuAnimation.value * 0.5,
                  child: Icon(
                    _isMenuOpen ? Icons.close_rounded : Icons.menu_rounded,
                    color: AppColors.white,
                    size: 24,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _showMobileMenu() {
    final languageProvider = Provider.of<LanguageProvider>(
      context,
      listen: false,
    );
    final isArabic = languageProvider.currentLocale.languageCode == 'ar';

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        final navItems = [
          {
            'key': 'home',
            'label': AppLocalizations.translate(
              'home',
              languageProvider.currentLocale.languageCode,
            ),
            'icon': Icons.home_rounded,
          },
          {
            'key': 'about',
            'label': AppLocalizations.translate(
              'about_us',
              languageProvider.currentLocale.languageCode,
            ),
            'icon': Icons.info_rounded,
          },
          {
            'key': 'services',
            'label': AppLocalizations.translate(
              'services',
              languageProvider.currentLocale.languageCode,
            ),
            'icon': Icons.business_rounded,
          },
          {
            'key': 'subsidiaries',
            'label': AppLocalizations.translate(
              'subsidiaries',
              languageProvider.currentLocale.languageCode,
            ),
            'icon': Icons.account_tree_rounded,
          },
          {
            'key': 'news',
            'label': AppLocalizations.translate(
              'news',
              languageProvider.currentLocale.languageCode,
            ),
            'icon': Icons.article_rounded,
          },
          {
            'key': 'contact',
            'label': AppLocalizations.translate(
              'contact',
              languageProvider.currentLocale.languageCode,
            ),
            'icon': Icons.contact_mail_rounded,
          },
        ];

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.surface,
                AppColors.surface.withOpacity(0.98),
              ],
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowLight,
                blurRadius: 20,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle
                Container(
                  width: 48,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 32),
                
                // Navigation Items
                ...navItems.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  
                  return AnimatedSection(
                    duration: Duration(milliseconds: 100 + (index * 50)),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppColors.surface.withOpacity(0.5),
                        border: Border.all(
                          color: AppColors.primary.withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                      child: ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            item['icon'] as IconData,
                            color: AppColors.surface,
                            size: 20,
                          ),
                        ),
                        title: Text(
                          item['label']! as String,
                          style: AppTextStyles.bodyLarge.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: AppColors.white.withOpacity(0.7),
                          size: 16,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          setState(() {
                            _isMenuOpen = false;
                          });
                          _menuController.reverse();
                          if (widget.onNavigate != null) {
                            widget.onNavigate!(item['key']! as String);
                          }
                        },
                      ),
                    ),
                  );
                }).toList(),
                
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    ).then((_) {
      setState(() {
        _isMenuOpen = false;
      });
      _menuController.reverse();
    });
  }
}
