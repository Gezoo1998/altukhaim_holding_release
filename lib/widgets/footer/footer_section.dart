import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/language_provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../utils/app_localizations.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        final isArabic = languageProvider.currentLocale.languageCode == 'ar';
        
        return Container(
          width: double.infinity,
          color: AppColors.darkGray,
          child: Column(
            children: [
              // Main Footer Content
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isMobile = constraints.maxWidth < 768;
                    final isTablet = constraints.maxWidth < 1024;
                    
                    return Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        child: isMobile
                            ? _buildMobileLayout(context, isArabic)
                            : _buildDesktopLayout(context, isArabic, isTablet),
                      ),
                    );
                  },
                ),
              ),
              
              // Footer Bottom
              _buildFooterBottom(context, isArabic),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMobileLayout(BuildContext context, bool isArabic) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCompanyInfo(context, isArabic, true),
        const SizedBox(height: 40),
        _buildQuickLinks(context, isArabic, true),
        const SizedBox(height: 40),
        _buildSocialMedia(context, isArabic, true),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context, bool isArabic, bool isTablet) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Company Info
        Expanded(
          flex: 2,
          child: _buildCompanyInfo(context, isArabic, false),
        ),
        
        const SizedBox(width: 60),
        
        // Quick Links
        Expanded(
          flex: 1,
          child: _buildQuickLinks(context, isArabic, false),
        ),
        
        const SizedBox(width: 60),
        
        // Social Media
        Expanded(
          flex: 1,
          child: _buildSocialMedia(context, isArabic, false),
        ),
      ],
    );
  }

  Widget _buildCompanyInfo(BuildContext context, bool isArabic, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Company Logo/Name
        Text(
          isArabic ? 'مجموعة نواف التخيم القابضة' : 'Nawaf Al Tokheim Holding',
          style: AppTextStyles.headingSmall.copyWith(
            fontSize: isMobile ? 20 : 24,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        
        const SizedBox(height: 20),
        
        // Company Description
        Container(
          constraints: BoxConstraints(
            maxWidth: isMobile ? double.infinity : 400,
          ),
          child: Text(
            AppLocalizations.translate('footer_description', isArabic ? 'ar' : 'en'),
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.white.withValues(alpha: 0.8),
              height: 1.6,
            ),
          ),
        ),
        
        const SizedBox(height: 30),
        
        // Contact Info
        _buildContactItem(
          icon: Icons.location_on,
          text: AppLocalizations.translate('address', isArabic ? 'ar' : 'en'),
        ),
        
        const SizedBox(height: 15),
        
        _buildContactItem(
          icon: Icons.phone,
          text: AppLocalizations.translate('phone', isArabic ? 'ar' : 'en'),
        ),
        
        const SizedBox(height: 15),
        
        _buildContactItem(
          icon: Icons.email,
          text: AppLocalizations.translate('email_address', isArabic ? 'ar' : 'en'),
        ),
      ],
    );
  }

  Widget _buildContactItem({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.accent,
          size: 18,
        ),
        
        const SizedBox(width: 12),
        
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.white.withValues(alpha: 0.8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickLinks(BuildContext context, bool isArabic, bool isMobile) {
    final links = [
      {'key': 'home', 'route': '/'},
      {'key': 'about_us', 'route': '/about'},
      {'key': 'services', 'route': '/services'},
      {'key': 'subsidiaries', 'route': '/subsidiaries'},
      {'key': 'news', 'route': '/news'},
      {'key': 'contact', 'route': '/contact'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.translate('quick_links', isArabic ? 'ar' : 'en'),
          style: AppTextStyles.headingSmall.copyWith(
            fontSize: isMobile ? 18 : 20,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        
        const SizedBox(height: 20),
        
        ...links.map((link) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            onTap: () {
              // Navigate to section
              _navigateToSection(context, link['key']!);
            },
            child: Text(
              AppLocalizations.translate(link['key']!, isArabic ? 'ar' : 'en'),
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.white.withValues(alpha: 0.8),
              ),
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildSocialMedia(BuildContext context, bool isArabic, bool isMobile) {
    final socialLinks = [
      {'icon': Icons.facebook, 'name': 'Facebook', 'url': 'https://facebook.com'},
      {'icon': Icons.link, 'name': 'LinkedIn', 'url': 'https://linkedin.com'},
      {'icon': Icons.alternate_email, 'name': 'Twitter', 'url': 'https://twitter.com'},
      {'icon': Icons.camera_alt, 'name': 'Instagram', 'url': 'https://instagram.com'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.translate('follow_us', isArabic ? 'ar' : 'en'),
          style: AppTextStyles.headingSmall.copyWith(
            fontSize: isMobile ? 18 : 20,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        
        const SizedBox(height: 20),
        
        Wrap(
          spacing: 15,
          runSpacing: 15,
          children: socialLinks.map((social) => _buildSocialIcon(
            icon: social['icon'] as IconData,
            onTap: () => _openSocialLink(context, social['url'] as String),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildSocialIcon({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: AppColors.white.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Icon(
          icon,
          color: AppColors.white,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildFooterBottom(BuildContext context, bool isArabic) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 768;
          
          return Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: isMobile
                  ? _buildMobileFooterBottom(context, isArabic)
                  : _buildDesktopFooterBottom(context, isArabic),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMobileFooterBottom(BuildContext context, bool isArabic) {
    return Column(
      children: [
        Text(
          '© ${DateTime.now().year} ${isArabic ? 'مجموعة نواف التخيم القابضة' : 'Nawaf Al Tokheim Holding'}. ${AppLocalizations.translate('all_rights_reserved', isArabic ? 'ar' : 'en')}',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.white.withValues(alpha: 0.6),
          ),
          textAlign: TextAlign.center,
        ),
        
        const SizedBox(height: 15),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => _showPrivacyPolicy(context),
              child: Text(
                AppLocalizations.translate('privacy_policy', isArabic ? 'ar' : 'en'),
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.accent,
                ),
              ),
            ),
            
            Text(
              ' • ',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.white.withValues(alpha: 0.6),
              ),
            ),
            
            InkWell(
              onTap: () => _showTermsConditions(context),
              child: Text(
                AppLocalizations.translate('terms_conditions', isArabic ? 'ar' : 'en'),
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.accent,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopFooterBottom(BuildContext context, bool isArabic) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '© ${DateTime.now().year} ${isArabic ? 'مجموعة نواف التخيم القابضة' : 'Nawaf Al Tokheim Holding'}. ${AppLocalizations.translate('all_rights_reserved', isArabic ? 'ar' : 'en')}',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.white.withValues(alpha: 0.6),
          ),
        ),
        
        Row(
          children: [
            InkWell(
              onTap: () => _showPrivacyPolicy(context),
              child: Text(
                AppLocalizations.translate('privacy_policy', isArabic ? 'ar' : 'en'),
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.accent,
                ),
              ),
            ),
            
            Text(
              ' • ',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.white.withValues(alpha: 0.6),
              ),
            ),
            
            InkWell(
              onTap: () => _showTermsConditions(context),
              child: Text(
                AppLocalizations.translate('terms_conditions', isArabic ? 'ar' : 'en'),
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.accent,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _navigateToSection(BuildContext context, String section) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Navigating to $section section...'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _openSocialLink(BuildContext context, String url) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening $url...'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showPrivacyPolicy(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Privacy Policy'),
        content: const Text('Privacy Policy content would be displayed here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showTermsConditions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Terms & Conditions'),
        content: const Text('Terms & Conditions content would be displayed here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}