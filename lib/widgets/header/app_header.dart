import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/language_provider.dart';
import '../../utils/app_localizations.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../common/animated_section.dart';

class AppHeader extends StatefulWidget implements PreferredSizeWidget {
  final Function(String)? onNavigate;

  const AppHeader({Key? key, this.onNavigate}) : super(key: key);

  @override
  State<AppHeader> createState() => _AppHeaderState();

  @override
  Size get preferredSize => const Size.fromHeight(90);
}

class _AppHeaderState extends State<AppHeader> with TickerProviderStateMixin {
  bool _isMenuOpen = false;
  late AnimationController _menuController;
  late Animation<double> _menuAnimation;
  late AnimationController _logoController;
  late Animation<double> _logoAnimation;

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
    
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _logoAnimation = CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    );
    
    // Start logo animation
    _logoController.forward();
  }

  @override
  void dispose() {
    _menuController.dispose();
    _logoController.dispose();
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
      height: 90,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: AppColors.primary.withOpacity(0.08),
            width: 1,
          ),
        ),
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 24 : (isTablet ? 40 : 56),
              vertical: 8,
            ),
            child: Row(
              children: [
                // Logo
                _buildModernLogo(languageProvider, isMobile, screenWidth),
                const Spacer(),

                if (!isMobile) ...[
                  // Desktop Navigation
                  _buildDesktopNavigation(languageProvider),
                  const SizedBox(width: 40),
                  _buildLanguageToggle(languageProvider),
                ] else ...[
                  // Mobile Language Toggle
                  _buildLanguageToggle(languageProvider),
                  const SizedBox(width: 20),
                  // Mobile Menu Button
                  _buildMobileMenuButton(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModernLogo(LanguageProvider languageProvider, bool isMobile, double screenWidth) {
    return AnimatedBuilder(
      animation: _logoAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _logoAnimation.value,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                if (widget.onNavigate != null) {
                  widget.onNavigate!('home');
                }
              },
              child: TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 200),
                tween: Tween(begin: 0.0, end: 1.0),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: 1.0 + (value * 0.02),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Official Logo
                          Container(
                            width: isMobile ? 48 : 56,
                            height: isMobile ? 48 : 56,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.15),
                                  blurRadius: 12,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                'assets/images/nawaf_logo.png',
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      gradient: AppColors.primaryGradient,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      Icons.business_center_rounded,
                                      color: Colors.white,
                                      size: isMobile ? 24 : 28,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          
                          if (screenWidth > 600) ...[
                            const SizedBox(width: 16),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.translate(
                                    'hero_title',
                                    languageProvider.currentLocale.languageCode,
                                  ),
                                  style: AppTextStyles.headingSmall.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -0.8,
                                    fontSize: screenWidth > 768 ? 20 : 18,
                                    shadows: [
                                      Shadow(
                                        color: AppColors.primary.withOpacity(0.3),
                                        blurRadius: 4,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                const SizedBox(height: 2),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    AppLocalizations.translate(
                                      'company_tagline',
                                      languageProvider.currentLocale.languageCode,
                                    ),
                                    style: AppTextStyles.caption.copyWith(
                                      color: Colors.white.withOpacity(0.8),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
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
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  onEnter: (_) {},
                  onExit: (_) {},
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          AppColors.primary.withOpacity(0.05),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 200),
                      tween: Tween(begin: 0.0, end: 1.0),
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: 1.0 + (value * 0.02),
                          child: TextButton(
                            onPressed: () {
                              if (widget.onNavigate != null) {
                                widget.onNavigate!(item['key']! as String);
                              }
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.textPrimary,
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              overlayColor: AppColors.primary.withOpacity(0.1),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TweenAnimationBuilder<double>(
                                  duration: const Duration(milliseconds: 300),
                                  tween: Tween(begin: 0.0, end: 1.0),
                                  builder: (context, iconValue, child) {
                                    return Transform.rotate(
                                      angle: iconValue * 0.1,
                                      child: Icon(
                                        item['icon'] as IconData,
                                        size: 18,
                                        color: AppColors.textSecondary,
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  item['label']! as String,
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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
          minWidth: 120,
          maxWidth: 160,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface.withOpacity(0.8),
          border: Border.all(
            color: AppColors.primary.withOpacity(0.2),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: _buildLanguageButton('العربية', 'ar', languageProvider),
            ),
            Flexible(
              child: _buildLanguageButton('EN', 'en', languageProvider),
            ),
          ],
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
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 200),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Transform.scale(
              scale: 1.0 + (value * 0.05),
              child: GestureDetector(
                onTap: () {
                  languageProvider.setLanguage(languageCode);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  constraints: const BoxConstraints(
                    minWidth: 50,
                    maxWidth: 70,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: isSelected ? AppColors.primaryGradient : null,
                    color: isSelected ? null : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    style: AppTextStyles.labelMedium.copyWith(
                      color: isSelected ? AppColors.surface : AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            );
          },
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
            color: AppColors.surface.withOpacity(0.8),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.2),
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
                    color: AppColors.primary,
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
                    color: AppColors.textSecondary.withOpacity(0.3),
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
                            color: AppColors.textPrimary,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: AppColors.textSecondary,
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
