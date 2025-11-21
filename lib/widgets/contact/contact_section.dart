import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../utils/app_localizations.dart';
import '../../providers/language_provider.dart';
import '../common/animated_section.dart';
import '../common/animated_background.dart';
import '../modern_card.dart';
import '../animated_text.dart';
import '../animations/scroll_animations.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        final isArabic = languageProvider.currentLocale.languageCode == 'ar';
        
        return AnimatedBackground(
          enableParticles: true,
          enableGeometricShapes: true,
          opacity: 0.4,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  AppColors.primary.withValues(alpha: 0.02),
                  AppColors.primary.withValues(alpha: 0.05),
                ],
              ),
            ),
            child: Stack(
              children: [
                // Background geometric shapes
                _buildBackgroundShapes(),
                
                // Main content
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final isMobile = constraints.maxWidth < 768;
                      final isTablet = constraints.maxWidth < 1024;
                      
                      return Center(
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 1200),
                        child: Column(
                          children: [
                            // Section Header
                             AnimatedSection(
                               child: _buildSectionHeader(context, isArabic, isMobile, isTablet),
                             ),
                            
                            const SizedBox(height: 80),
                            
                            // Contact Content
                            if (isMobile)
                              _buildMobileLayout(context, isArabic, isMobile)
                            else
                              _buildDesktopLayout(context, isArabic, isMobile, isTablet),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBackgroundShapes() {
    return Positioned.fill(
      child: Stack(
        children: [
          // Top right circle
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.accent.withValues(alpha: 0.1),
                    AppColors.accent.withValues(alpha: 0.05),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          
          // Bottom left triangle
          Positioned(
            bottom: -50,
            left: -50,
            child: Transform.rotate(
              angle: 0.5,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.accent.withValues(alpha: 0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, bool isArabic, bool isMobile, bool isTablet) {
    return Column(
      children: [
        // Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary.withValues(alpha: 0.1),
                AppColors.accent.withValues(alpha: 0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Text(
            AppLocalizations.translate('contact_badge', isArabic ? 'ar' : 'en'),
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Title
        AnimatedText(
          text: AppLocalizations.translate('contact_title', isArabic ? 'ar' : 'en'),
          style: AppTextStyles.displayMedium.copyWith(
            fontSize: isMobile ? 32 : (isTablet ? 40 : 48),
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
          animationType: AnimationType.fadeInUp,
        ),
        
        const SizedBox(height: 16),
        
        // Subtitle
        Container(
          constraints: BoxConstraints(maxWidth: isMobile ? double.infinity : 600),
          child: AnimatedText(
            text: AppLocalizations.translate('contact_subtitle', isArabic ? 'ar' : 'en'),
            style: AppTextStyles.bodyLarge.copyWith(
              fontSize: isMobile ? 16 : 18,
              color: AppColors.white.withOpacity(0.9),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
            animationType: AnimationType.fadeIn,
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context, bool isArabic, bool isMobile, bool isTablet) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         // Contact Information
         Expanded(
           flex: 1,
           child: AnimatedSection(
             duration: const Duration(milliseconds: 800),
             child: _buildContactInfo(context, isArabic, isMobile, isTablet),
           ),
         ),
         
         const SizedBox(width: 60),
         
         // Contact Form
         Expanded(
           flex: 1,
           child: AnimatedSection(
             duration: const Duration(milliseconds: 1000),
             child: _buildContactForm(context, isArabic, isMobile, isTablet),
           ),
         ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context, bool isArabic, bool isMobile) {
    return Column(
      children: [
         // Contact Information
         AnimatedSection(
           duration: const Duration(milliseconds: 800),
           child: _buildContactInfo(context, isArabic, isMobile, false),
         ),
         
         const SizedBox(height: 60),
         
         // Contact Form
         AnimatedSection(
           duration: const Duration(milliseconds: 1000),
           child: _buildContactForm(context, isArabic, isMobile, false),
         ),
       ],
    );
  }

  Widget _buildContactInfo(BuildContext context, bool isArabic, bool isMobile, bool isTablet) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.white.withOpacity(0.15),
            AppColors.white.withOpacity(0.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          AnimatedText(
            text: AppLocalizations.translate('contact_info', isArabic ? 'ar' : 'en'),
            style: AppTextStyles.headingMedium.copyWith(
              fontSize: isMobile ? 20 : 24,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
            animationType: AnimationType.fadeInUp,
          ),
          
          const SizedBox(height: 8),
          
          AnimatedText(
            text: AppLocalizations.translate('contact_info_subtitle', isArabic ? 'ar' : 'en'),
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.white.withOpacity(0.8),
            ),
            animationType: AnimationType.fadeIn,
          ),
          
          const SizedBox(height: 32),
          
          // Contact items
          _buildContactInfoItem(
            icon: Icons.location_on_outlined,
            title: AppLocalizations.translate('address_title', isArabic ? 'ar' : 'en'),
            subtitle: AppLocalizations.translate('address', isArabic ? 'ar' : 'en'),
            isArabic: isArabic,
          ),
          
          const SizedBox(height: 24),
          
          _buildContactInfoItem(
            icon: Icons.phone_outlined,
            title: AppLocalizations.translate('phone_title', isArabic ? 'ar' : 'en'),
            subtitle: AppLocalizations.translate('phone', isArabic ? 'ar' : 'en'),
            isArabic: isArabic,
          ),
          
          const SizedBox(height: 24),
          
          _buildContactInfoItem(
            icon: Icons.email_outlined,
            title: AppLocalizations.translate('email_title', isArabic ? 'ar' : 'en'),
            subtitle: AppLocalizations.translate('email_address', isArabic ? 'ar' : 'en'),
            isArabic: isArabic,
          ),
          
          const SizedBox(height: 32),
          
          // Business hours
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.white.withOpacity(0.1),
                  AppColors.white.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.access_time_outlined,
                      color: AppColors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    AnimatedText(
                      text: AppLocalizations.translate('business_hours', isArabic ? 'ar' : 'en'),
                      style: AppTextStyles.labelLarge.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      ),
                      animationType: AnimationType.fadeInUp,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                AnimatedText(
                  text: AppLocalizations.translate('business_hours_details', isArabic ? 'ar' : 'en'),
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.white.withOpacity(0.8),
                  ),
                  animationType: AnimationType.fadeIn,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactForm(BuildContext context, bool isArabic, bool isMobile, bool isTablet) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.white.withOpacity(0.15),
            AppColors.white.withOpacity(0.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Form title
          AnimatedText(
            text: AppLocalizations.translate('send_message', isArabic ? 'ar' : 'en'),
            style: AppTextStyles.headingMedium.copyWith(
              fontSize: isMobile ? 20 : 24,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
            animationType: AnimationType.fadeInUp,
          ),
          
          const SizedBox(height: 8),
          
          AnimatedText(
            text: AppLocalizations.translate('send_message_subtitle', isArabic ? 'ar' : 'en'),
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.white.withOpacity(0.8),
            ),
            animationType: AnimationType.fadeIn,
          ),
          
          const SizedBox(height: 32),
          
          // Form fields
          _buildFormField(
            label: AppLocalizations.translate('full_name', isArabic ? 'ar' : 'en'),
            hint: AppLocalizations.translate('full_name_hint', isArabic ? 'ar' : 'en'),
            icon: Icons.person_outline,
          ),
          
          const SizedBox(height: 20),
          
          _buildFormField(
            label: AppLocalizations.translate('email_label', isArabic ? 'ar' : 'en'),
            hint: AppLocalizations.translate('email_hint', isArabic ? 'ar' : 'en'),
            icon: Icons.email_outlined,
          ),
          
          const SizedBox(height: 20),
          
          _buildFormField(
            label: AppLocalizations.translate('phone_label', isArabic ? 'ar' : 'en'),
            hint: AppLocalizations.translate('phone_hint', isArabic ? 'ar' : 'en'),
            icon: Icons.phone_outlined,
          ),
          
          const SizedBox(height: 20),
          
          _buildFormField(
            label: AppLocalizations.translate('message_label', isArabic ? 'ar' : 'en'),
            hint: AppLocalizations.translate('message_hint', isArabic ? 'ar' : 'en'),
            icon: Icons.message_outlined,
            maxLines: 4,
          ),
          
          const SizedBox(height: 32),
          
          // Submit button
          SizedBox(
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.accent,
                    AppColors.accent.withOpacity(0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle form submission
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      overlayColor: AppColors.white.withOpacity(0.1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.send_outlined,
                          color: AppColors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          AppLocalizations.translate('send_message_button', isArabic ? 'ar' : 'en'),
                          style: AppTextStyles.buttonLarge.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
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

  Widget _buildContactInfoItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isArabic,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.white.withOpacity(0.15),
                AppColors.white.withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.white.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Icon(
            icon,
            color: AppColors.white,
            size: 20,
          ),
        ),
        
        const SizedBox(width: 16),
        
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedText(
                text: title,
                style: AppTextStyles.labelLarge.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
                animationType: AnimationType.fadeInUp,
              ),
              
              const SizedBox(height: 4),
              
              AnimatedText(
                text: subtitle,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.white.withOpacity(0.8),
                  height: 1.4,
                ),
                animationType: AnimationType.fadeIn,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFormField({
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedText(
          text: label,
          style: AppTextStyles.labelMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
          animationType: AnimationType.fadeInUp,
        ),
        
        const SizedBox(height: 8),
        
        MouseRegion(
          cursor: SystemMouseCursors.text,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            child: TextFormField(
              maxLines: maxLines,
              decoration: InputDecoration(
                hintText: hint,
                prefixIcon: Icon(
                  icon,
                  color: AppColors.white.withOpacity(0.7),
                  size: 20,
                ),
                filled: true,
                fillColor: AppColors.white.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: AppColors.white.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: AppColors.white.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: AppColors.accent,
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                hintStyle: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.white.withOpacity(0.6),
                ),
              ),
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}