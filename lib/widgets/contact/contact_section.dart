import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import '../../providers/language_provider.dart';
import '../../utils/app_localizations.dart';
import '../../utils/responsive_helper.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../common/animated_section.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        final isArabic = languageProvider.currentLocale.languageCode == 'ar';
        
        return Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.transparent,
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
        // Modern Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.accent],
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                AppLocalizations.translate('contact_badge', isArabic ? 'ar' : 'en'),
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Enhanced Main Title
        Container(
          constraints: BoxConstraints(maxWidth: isMobile ? double.infinity : 800),
          child: ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [AppColors.primary, AppColors.accent],
            ).createShader(bounds),
            child: Text(
              AppLocalizations.translate('contact_title', isArabic ? 'ar' : 'en'),
              style: AppTextStyles.displayLarge.copyWith(
                fontSize: isMobile ? 32 : isTablet ? 40 : 48,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                height: 1.2,
                letterSpacing: -0.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        
        const SizedBox(height: 20),
        
        // Enhanced Subtitle with decorative elements
        Container(
          constraints: BoxConstraints(maxWidth: isMobile ? double.infinity : 700),
          child: Column(
            children: [
              // Decorative line
              Container(
                width: 60,
                height: 3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.accent],
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              
              const SizedBox(height: 20),
              
              Text(
                AppLocalizations.translate('contact_subtitle', isArabic ? 'ar' : 'en'),
                style: AppTextStyles.bodyLarge.copyWith(
                  fontSize: isMobile ? 16 : 18,
                  color: AppColors.textSecondary,
                  height: 1.6,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ],
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
             child: _buildContactInfo(context, isArabic, isMobile, isTablet),
           ),
         ),
         
         const SizedBox(width: 60),
         
         // Contact Form
         Expanded(
           flex: 1,
           child: AnimatedSection(
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
           child: _buildContactInfo(context, isArabic, isMobile, false),
         ),
         
         const SizedBox(height: 60),
         
         // Contact Form
         AnimatedSection(
           child: _buildContactForm(context, isArabic, isMobile, false),
         ),
       ],
    );
  }

  Widget _buildContactInfo(BuildContext context, bool isArabic, bool isMobile, bool isTablet) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 32),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.08),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Enhanced Section title with icon
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.accent],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.contact_support_outlined,
                  color: AppColors.surface,
                  size: 20,
                ),
              ),
              
              const SizedBox(width: 16),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.translate('contact_info', isArabic ? 'ar' : 'en'),
                      style: AppTextStyles.headingMedium.copyWith(
                        fontSize: isMobile ? 20 : 24,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        height: 1.2,
                      ),
                    ),
                    
                    const SizedBox(height: 4),
                    
                    Text(
                      AppLocalizations.translate('contact_info_subtitle', isArabic ? 'ar' : 'en'),
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 32),
          
          // Contact items with enhanced styling
          _buildModernContactInfoItem(
            icon: Icons.location_on_outlined,
            title: AppLocalizations.translate('address_title', isArabic ? 'ar' : 'en'),
            subtitle: AppLocalizations.translate('address', isArabic ? 'ar' : 'en'),
            onTap: () {
              // Handle address tap - could open maps
            },
          ),
          
          _buildModernContactInfoItem(
            icon: Icons.phone_outlined,
            title: AppLocalizations.translate('phone_title', isArabic ? 'ar' : 'en'),
            subtitle: AppLocalizations.translate('phone', isArabic ? 'ar' : 'en'),
            onTap: () {
              // Handle phone tap - could make call
            },
          ),
          
          _buildModernContactInfoItem(
            icon: Icons.email_outlined,
            title: AppLocalizations.translate('email_title', isArabic ? 'ar' : 'en'),
            subtitle: AppLocalizations.translate('email_address', isArabic ? 'ar' : 'en'),
            onTap: () {
              // Handle email tap - could open email client
            },
          ),
          
          const SizedBox(height: 32),
          
          // Enhanced Business hours
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.15),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary.withValues(alpha: 0.2),
                        AppColors.accent.withValues(alpha: 0.2),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.access_time_outlined,
                    color: AppColors.primary,
                    size: 18,
                  ),
                ),
                
                const SizedBox(width: 16),
                
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.translate('business_hours', isArabic ? 'ar' : 'en'),
                        style: AppTextStyles.labelLarge.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                          fontSize: 16,
                        ),
                      ),
                      
                      const SizedBox(height: 4),
                      
                      Text(
                        AppLocalizations.translate('business_hours_details', isArabic ? 'ar' : 'en'),
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.4,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernContactInfoItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 800),
        tween: Tween(begin: 0.0, end: 1.0),
        builder: (context, value, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            child: Transform.translate(
              offset: Offset(0, 20 * (1 - value)),
              child: Opacity(
                opacity: value,
                child: GestureDetector(
                  onTap: onTap,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.white.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        TweenAnimationBuilder<double>(
                          duration: Duration(milliseconds: 600 + (value * 200).round()),
                          tween: Tween(begin: 0.0, end: 1.0),
                          builder: (context, iconValue, child) {
                            return Transform.scale(
                              scale: 0.8 + (iconValue * 0.2),
                              child: Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      AppColors.primary,
                                      AppColors.accent,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primary.withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  icon,
                                  color: AppColors.white,
                                  size: 24,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TweenAnimationBuilder<double>(
                                duration: Duration(milliseconds: 700 + (value * 300).round()),
                                tween: Tween(begin: 0.0, end: 1.0),
                                builder: (context, titleValue, child) {
                                  return Transform.translate(
                                    offset: Offset(20 * (1 - titleValue), 0),
                                    child: Opacity(
                                      opacity: titleValue,
                                      child: Text(
                                        title,
                                        style: AppTextStyles.bodyLarge.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 4),
                              TweenAnimationBuilder<double>(
                                duration: Duration(milliseconds: 800 + (value * 400).round()),
                                tween: Tween(begin: 0.0, end: 1.0),
                                builder: (context, subtitleValue, child) {
                                  return Transform.translate(
                                    offset: Offset(20 * (1 - subtitleValue), 0),
                                    child: Opacity(
                                      opacity: subtitleValue,
                                      child: Text(
                                        subtitle,
                                        style: AppTextStyles.bodyMedium.copyWith(
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        TweenAnimationBuilder<double>(
                          duration: Duration(milliseconds: 900 + (value * 500).round()),
                          tween: Tween(begin: 0.0, end: 1.0),
                          builder: (context, arrowValue, child) {
                            return Transform.scale(
                              scale: arrowValue,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: AppColors.textSecondary,
                                size: 16,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildModernFormField({
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
  }) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 800),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TweenAnimationBuilder<double>(
                  duration: Duration(milliseconds: 600 + (value * 200).round()),
                  tween: Tween(begin: 0.0, end: 1.0),
                  builder: (context, labelValue, child) {
                    return Transform.translate(
                      offset: Offset(10 * (1 - labelValue), 0),
                      child: Opacity(
                        opacity: labelValue,
                        child: Text(
                          label,
                          style: AppTextStyles.labelMedium.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                TweenAnimationBuilder<double>(
                  duration: Duration(milliseconds: 700 + (value * 300).round()),
                  tween: Tween(begin: 0.0, end: 1.0),
                  builder: (context, fieldValue, child) {
                    return Transform.scale(
                      scale: 0.95 + (fieldValue * 0.05),
                      child: Opacity(
                        opacity: fieldValue,
                        child: MouseRegion(
                          cursor: SystemMouseCursors.text,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            child: TextFormField(
                              maxLines: maxLines,
                              decoration: InputDecoration(
                                hintText: hint,
                                prefixIcon: TweenAnimationBuilder<double>(
                                  duration: Duration(milliseconds: 800 + (value * 400).round()),
                                  tween: Tween(begin: 0.0, end: 1.0),
                                  builder: (context, iconValue, child) {
                                    return Transform.scale(
                                      scale: 0.8 + (iconValue * 0.2),
                                      child: Container(
                                        margin: const EdgeInsets.all(12),
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              AppColors.primary.withOpacity(0.1),
                                              AppColors.accent.withOpacity(0.1),
                                            ],
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Icon(
                                          icon,
                                          color: AppColors.primary,
                                          size: 20,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                filled: true,
                                fillColor: Colors.transparent,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    color: AppColors.lightGray.withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    color: AppColors.lightGray.withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    color: AppColors.primary,
                                    width: 2,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: maxLines > 1 ? 20 : 18,
                                ),
                                hintStyle: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.textSecondary.withOpacity(0.6),
                                ),
                              ),
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildContactForm(BuildContext context, bool isArabic, bool isMobile, bool isTablet) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 1000),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Container(
              padding: EdgeInsets.all(isMobile ? 24 : 32),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: AppColors.accent.withOpacity(0.08),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Enhanced Form title with icon
                  TweenAnimationBuilder<double>(
                    duration: Duration(milliseconds: 600 + (value * 200).round()),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, titleValue, child) {
                      return Transform.translate(
                        offset: Offset(30 * (1 - titleValue), 0),
                        child: Opacity(
                          opacity: titleValue,
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [AppColors.accent, AppColors.primary],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.accent.withOpacity(0.3),
                                      blurRadius: 12,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.send_outlined,
                                  color: AppColors.surface,
                                  size: 20,
                                ),
                              ),
                              
                              const SizedBox(width: 16),
                              
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.translate('send_message', isArabic ? 'ar' : 'en'),
                                      style: AppTextStyles.headingMedium.copyWith(
                                        fontSize: isMobile ? 20 : 24,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.textPrimary,
                                        height: 1.2,
                                      ),
                                    ),
                                    
                                    const SizedBox(height: 4),
                                    
                                    Text(
                                      AppLocalizations.translate('send_message_subtitle', isArabic ? 'ar' : 'en'),
                                      style: AppTextStyles.bodyMedium.copyWith(
                                        color: AppColors.textSecondary,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Enhanced Form fields with staggered animations
                  TweenAnimationBuilder<double>(
                    duration: Duration(milliseconds: 800 + (value * 300).round()),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, fieldValue, child) {
                      return Column(
                        children: [
                          _buildModernFormField(
                            label: AppLocalizations.translate('full_name', isArabic ? 'ar' : 'en'),
                            hint: AppLocalizations.translate('full_name_hint', isArabic ? 'ar' : 'en'),
                            icon: Icons.person_outline,
                          ),
                          
                          const SizedBox(height: 20),
                          
                          _buildModernFormField(
                            label: AppLocalizations.translate('email_label', isArabic ? 'ar' : 'en'),
                            hint: AppLocalizations.translate('email_hint', isArabic ? 'ar' : 'en'),
                            icon: Icons.email_outlined,
                          ),
                          
                          const SizedBox(height: 20),
                          
                          _buildModernFormField(
                            label: AppLocalizations.translate('phone_label', isArabic ? 'ar' : 'en'),
                            hint: AppLocalizations.translate('phone_hint', isArabic ? 'ar' : 'en'),
                            icon: Icons.phone_outlined,
                          ),
                          
                          const SizedBox(height: 20),
                          
                          _buildModernFormField(
                            label: AppLocalizations.translate('message_label', isArabic ? 'ar' : 'en'),
                            hint: AppLocalizations.translate('message_hint', isArabic ? 'ar' : 'en'),
                            icon: Icons.message_outlined,
                            maxLines: 4,
                          ),
                        ],
                      );
                    },
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Enhanced Submit button with animation
                  TweenAnimationBuilder<double>(
                    duration: Duration(milliseconds: 1000 + (value * 400).round()),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, buttonValue, child) {
                      return Transform.scale(
                        scale: 0.9 + (buttonValue * 0.1),
                        child: Opacity(
                          opacity: buttonValue,
                          child: SizedBox(
                            width: double.infinity,
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [AppColors.primary, AppColors.accent],
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primary.withOpacity(0.4),
                                      blurRadius: 20,
                                      offset: const Offset(0, 10),
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(16),
                                    onTap: () {
                                      // Handle form submission
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          TweenAnimationBuilder<double>(
                                            duration: Duration(milliseconds: 1200 + (value * 500).round()),
                                            tween: Tween(begin: 0.0, end: 1.0),
                                            builder: (context, iconValue, child) {
                                              return Transform.scale(
                                                scale: 0.8 + (iconValue * 0.2),
                                                child: Container(
                                                  padding: const EdgeInsets.all(6),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.surface.withOpacity(0.2),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  child: Icon(
                                                    Icons.send_outlined,
                                                    color: AppColors.surface,
                                                    size: 18,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          const SizedBox(width: 12),
                                          TweenAnimationBuilder<double>(
                                            duration: Duration(milliseconds: 1300 + (value * 600).round()),
                                            tween: Tween(begin: 0.0, end: 1.0),
                                            builder: (context, textValue, child) {
                                              return Transform.translate(
                                                offset: Offset(10 * (1 - textValue), 0),
                                                child: Opacity(
                                                  opacity: textValue,
                                                  child: Text(
                                                    AppLocalizations.translate('send_message_button', isArabic ? 'ar' : 'en'),
                                                    style: AppTextStyles.buttonLarge.copyWith(
                                                      color: AppColors.surface,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 16,
                                                    ),
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
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}