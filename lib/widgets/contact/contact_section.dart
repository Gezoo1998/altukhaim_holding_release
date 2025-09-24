import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/language_provider.dart';
import '../../utils/app_localizations.dart';
import '../../utils/responsive_helper.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../common/animated_section.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        final isArabic = languageProvider.currentLocale.languageCode == 'ar';
        
        return Container(
          width: double.infinity,
          color: AppColors.lightGray,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
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
                        _buildSectionHeader(context, isArabic, isMobile, isTablet),
                        
                        const SizedBox(height: 60),
                        
                        // Contact Content
                        if (isMobile)
                          _buildMobileLayout(context, isArabic, isMobile)
                        else
                          _buildDesktopLayout(context, isArabic, isTablet),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(BuildContext context, bool isArabic, bool isMobile, bool isTablet) {
    return Column(
      children: [
        Text(
          AppLocalizations.translate('contact_title', isArabic ? 'ar' : 'en'),
          style: AppTextStyles.heading1.copyWith(
            fontSize: isMobile ? 32 : (isTablet ? 40 : 48),
            color: AppColors.darkGray,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        
        const SizedBox(height: 20),
        
        Text(
          AppLocalizations.translate('contact_subtitle', isArabic ? 'ar' : 'en'),
          style: AppTextStyles.bodyLarge.copyWith(
            fontSize: isMobile ? 16 : (isTablet ? 18 : 20),
            color: AppColors.mediumGray,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context, bool isArabic, bool isMobile) {
    return Column(
      children: [
        _buildContactForm(context, isArabic, isMobile, false),
        const SizedBox(height: 40),
        _buildContactInfo(context, isArabic, isMobile, false),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context, bool isArabic, bool isTablet) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Contact Form
        Expanded(
          flex: 2,
          child: _buildContactForm(context, isArabic, false, isTablet),
        ),
        
        const SizedBox(width: 60),
        
        // Contact Information
        Expanded(
          flex: 1,
          child: _buildContactInfo(context, isArabic, false, isTablet),
        ),
      ],
    );
  }

  Widget _buildContactForm(BuildContext context, bool isArabic, bool isMobile, bool isTablet) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkGray.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name Field
            _buildFormField(
              label: AppLocalizations.translate('name', isArabic ? 'ar' : 'en'),
              controller: _nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 20),
            
            // Email Field
            _buildFormField(
              label: AppLocalizations.translate('email', isArabic ? 'ar' : 'en'),
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 20),
            
            // Message Field
            _buildFormField(
              label: AppLocalizations.translate('message', isArabic ? 'ar' : 'en'),
              controller: _messageController,
              maxLines: 5,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your message';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 30),
            
            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: AppColors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  AppLocalizations.translate('send_message', isArabic ? 'ar' : 'en'),
                  style: AppTextStyles.getBody1(false).copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.getBody1(false).copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.darkGray,
          ),
        ),
        
        const SizedBox(height: 8),
        
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          decoration: InputDecoration(
            hintText: 'Enter your $label',
            hintStyle: AppTextStyles.getBody1(false).copyWith(
              color: AppColors.mediumGray,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.lightGray),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.lightGray),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.primaryBlue, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfo(BuildContext context, bool isArabic, bool isMobile, bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.translate('contact_info', isArabic ? 'ar' : 'en'),
          style: AppTextStyles.heading4.copyWith(
            fontSize: isMobile ? 20 : 24,
            fontWeight: FontWeight.bold,
            color: AppColors.darkGray,
          ),
        ),
        
        const SizedBox(height: 30),
        
        // Address
        _buildContactInfoItem(
          icon: Icons.location_on,
          title: AppLocalizations.translate('address', isArabic ? 'ar' : 'en'),
          subtitle: AppLocalizations.translate('address', isArabic ? 'ar' : 'en'),
        ),
        
        const SizedBox(height: 25),
        
        // Phone
        _buildContactInfoItem(
          icon: Icons.phone,
          title: AppLocalizations.translate('phone', isArabic ? 'ar' : 'en'),
          subtitle: AppLocalizations.translate('phone', isArabic ? 'ar' : 'en'),
        ),
        
        const SizedBox(height: 25),
        
        // Email
        _buildContactInfoItem(
          icon: Icons.email,
          title: 'Email',
          subtitle: AppLocalizations.translate('email_address', isArabic ? 'ar' : 'en'),
        ),
      ],
    );
  }

  Widget _buildContactInfoItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primaryBlue.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: AppColors.primaryBlue,
            size: 24,
          ),
        ),
        
        const SizedBox(width: 16),
        
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.getBody1(false).copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkGray,
                ),
              ),
              
              const SizedBox(height: 4),
              
              Text(
                subtitle,
                style: AppTextStyles.getBody1(false).copyWith(
                  color: AppColors.mediumGray,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Message sent successfully!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );
      
      // Clear form
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
  }
}