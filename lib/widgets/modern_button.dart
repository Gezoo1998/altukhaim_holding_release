import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class ModernButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final ModernButtonStyle style;
  final IconData? icon;
  final bool isLoading;
  final double? width;
  final double? height;

  const ModernButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.style = ModernButtonStyle.primary,
    this.icon,
    this.isLoading = false,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  State<ModernButton> createState() => _ModernButtonState();
}

class _ModernButtonState extends State<ModernButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _glowAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  void _onTapCancel() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.onPressed,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: widget.width,
              height: widget.height ?? 56,
              decoration: BoxDecoration(
                gradient: _getGradient(),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: _getShadowColor().withOpacity(0.3 + (_glowAnimation.value * 0.2)),
                    blurRadius: 20 + (_glowAnimation.value * 10),
                    offset: const Offset(0, 8),
                  ),
                  BoxShadow(
                    color: _getShadowColor().withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: widget.onPressed,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.isLoading)
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                _getTextColor(),
                              ),
                            ),
                          )
                        else if (widget.icon != null)
                          Icon(
                            widget.icon,
                            color: _getTextColor(),
                            size: 20,
                          ),
                        if ((widget.icon != null || widget.isLoading) && widget.text.isNotEmpty)
                          const SizedBox(width: 12),
                        if (widget.text.isNotEmpty)
                          Text(
                            widget.text,
                            style: AppTextStyles.labelLarge.copyWith(
                              color: _getTextColor(),
                              fontWeight: FontWeight.w600,
                            ),
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

  LinearGradient _getGradient() {
    switch (widget.style) {
      case ModernButtonStyle.primary:
        return AppColors.primaryGradient;
      case ModernButtonStyle.accent:
        return AppColors.accentGradient;
      case ModernButtonStyle.gold:
        return AppColors.goldGradient;
      case ModernButtonStyle.glass:
        return AppColors.glassGradient;
      case ModernButtonStyle.outline:
        return const LinearGradient(
          colors: [Colors.transparent, Colors.transparent],
        );
    }
  }

  Color _getShadowColor() {
    switch (widget.style) {
      case ModernButtonStyle.primary:
        return AppColors.primary;
      case ModernButtonStyle.accent:
        return AppColors.accent;
      case ModernButtonStyle.gold:
        return AppColors.gold;
      case ModernButtonStyle.glass:
        return AppColors.primary.withOpacity(0.3);
      case ModernButtonStyle.outline:
        return AppColors.primary;
    }
  }

  Color _getTextColor() {
    switch (widget.style) {
      case ModernButtonStyle.primary:
      case ModernButtonStyle.accent:
      case ModernButtonStyle.gold:
        return AppColors.white;
      case ModernButtonStyle.glass:
        return AppColors.textPrimary;
      case ModernButtonStyle.outline:
        return AppColors.primary;
    }
  }
}

enum ModernButtonStyle {
  primary,
  accent,
  gold,
  glass,
  outline,
}