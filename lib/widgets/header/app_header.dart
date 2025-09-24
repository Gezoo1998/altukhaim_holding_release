import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/language_provider.dart';
import '../../utils/app_localizations.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';

class AppHeader extends StatefulWidget implements PreferredSizeWidget {
  final Function(String)? onNavigate;

  const AppHeader({Key? key, this.onNavigate}) : super(key: key);

  @override
  State<AppHeader> createState() => _AppHeaderState();

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _AppHeaderState extends State<AppHeader> {
  bool _isMenuOpen = false;

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
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : (isTablet ? 24 : 32),
        ),
        child: Row(
          children: [
            // Logo
            _buildLogo(languageProvider, isMobile),
            const Spacer(),

            if (!isMobile) ...[
              // Desktop Navigation
              _buildDesktopNavigation(languageProvider),
              const SizedBox(width: 24),
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
    );
  }

  Widget _buildLogo(LanguageProvider languageProvider, bool isMobile) {
    return Flexible(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: isMobile ? 36 : 40,
            height: isMobile ? 36 : 40,
            decoration: BoxDecoration(
              color: AppColors.saudiGreen,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.business,
              color: Colors.white,
              size: isMobile ? 20 : 24,
            ),
          ),
          SizedBox(width: isMobile ? 8 : 12),
          if (!isMobile) // Hide text on mobile to save space
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.translate(
                      'company_name',
                      languageProvider.currentLocale.languageCode,
                    ),
                    style:
                        AppTextStyles.getHeading3(
                          languageProvider.currentLocale.languageCode == 'ar',
                        ).copyWith(
                          color: AppColors.saudiGreen,
                          fontWeight: FontWeight.bold,
                        ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    AppLocalizations.translate(
                      'company_tagline',
                      languageProvider.currentLocale.languageCode,
                    ),
                    style: AppTextStyles.getCaption(
                      languageProvider.currentLocale.languageCode == 'ar',
                    ).copyWith(color: AppColors.mediumGray),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
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
      },
      {
        'key': 'about',
        'label': AppLocalizations.translate(
          'about_us',
          languageProvider.currentLocale.languageCode,
        ),
      },
      {
        'key': 'services',
        'label': AppLocalizations.translate(
          'services',
          languageProvider.currentLocale.languageCode,
        ),
      },
      {
        'key': 'subsidiaries',
        'label': AppLocalizations.translate(
          'subsidiaries',
          languageProvider.currentLocale.languageCode,
        ),
      },
      {
        'key': 'news',
        'label': AppLocalizations.translate(
          'news',
          languageProvider.currentLocale.languageCode,
        ),
      },
      {
        'key': 'contact',
        'label': AppLocalizations.translate(
          'contact',
          languageProvider.currentLocale.languageCode,
        ),
      },
    ];

    return Flexible(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: navItems.map((item) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextButton(
                onPressed: () {
                  if (widget.onNavigate != null) {
                    widget.onNavigate!(item['key']!);
                  }
                },
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.darkGray,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 8,
                  ),
                ),
                child: Text(
                  item['label']!,
                  style: AppTextStyles.getNavText(
                    languageProvider.currentLocale.languageCode == 'ar',
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildLanguageToggle(LanguageProvider languageProvider) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.saudiGreen),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildLanguageButton('العربية', 'ar', languageProvider),
          _buildLanguageButton('EN', 'en', languageProvider),
        ],
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

    return GestureDetector(
      onTap: () {
        languageProvider.setLanguage(languageCode);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.saudiGreen : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.saudiGreen,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildMobileMenuButton() {
    return IconButton(
      onPressed: () {
        setState(() {
          _isMenuOpen = !_isMenuOpen;
        });
        _showMobileMenu();
      },
      icon: Icon(
        _isMenuOpen ? Icons.close : Icons.menu,
        color: AppColors.saudiGreen,
        size: 24,
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
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        final navItems = [
          {
            'key': 'home',
            'label': AppLocalizations.translate(
              'home',
              languageProvider.currentLocale.languageCode,
            ),
          },
          {
            'key': 'about',
            'label': AppLocalizations.translate(
              'about_us',
              languageProvider.currentLocale.languageCode,
            ),
          },
          {
            'key': 'services',
            'label': AppLocalizations.translate(
              'services',
              languageProvider.currentLocale.languageCode,
            ),
          },
          {
            'key': 'subsidiaries',
            'label': AppLocalizations.translate(
              'subsidiaries',
              languageProvider.currentLocale.languageCode,
            ),
          },
          {
            'key': 'news',
            'label': AppLocalizations.translate(
              'news',
              languageProvider.currentLocale.languageCode,
            ),
          },
          {
            'key': 'contact',
            'label': AppLocalizations.translate(
              'contact',
              languageProvider.currentLocale.languageCode,
            ),
          },
        ];

        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.lightGray,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              ...navItems.map((item) {
                return ListTile(
                  title: Text(
                    item['label']!,
                    style: AppTextStyles.getNavText(isArabic),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    if (widget.onNavigate != null) {
                      widget.onNavigate!(item['key']!);
                    }
                  },
                );
              }).toList(),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
