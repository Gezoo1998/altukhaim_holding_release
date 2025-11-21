import 'package:flutter/material.dart';
import 'dart:ui';
import '../constants/app_colors.dart';

class ModernCard extends StatefulWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final bool enableGlass;
  final bool enableHover;
  final double borderRadius;
  final List<BoxShadow>? customShadows;

  const ModernCard({
    Key? key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.onTap,
    this.enableGlass = false,
    this.enableHover = true,
    this.borderRadius = 20,
    this.customShadows,
  }) : super(key: key);

  @override
  State<ModernCard> createState() => _ModernCardState();
}

class _ModernCardState extends State<ModernCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  late Animation<double> _glowAnimation;

  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));

    _elevationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));

    _glowAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  void _onHover(bool isHovered) {
    if (!widget.enableHover) return;
    
    setState(() {
      _isHovered = isHovered;
    });

    if (isHovered) {
      _hoverController.forward();
    } else {
      _hoverController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _hoverController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            width: widget.width,
            height: widget.height,
            margin: widget.margin,
            child: MouseRegion(
              onEnter: (_) => _onHover(true),
              onExit: (_) => _onHover(false),
              child: GestureDetector(
                onTap: widget.onTap,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    boxShadow: widget.customShadows ?? _buildShadows(),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    child: widget.enableGlass
                        ? _buildGlassCard()
                        : _buildRegularCard(),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGlassCard() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
      child: Container(
        decoration: BoxDecoration(
          gradient: AppColors.enhancedGlassGradient,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 25,
              offset: const Offset(0, 10),
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        padding: widget.padding ?? const EdgeInsets.all(24),
        child: widget.child,
      ),
    );
  }

  Widget _buildRegularCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.modernCardGradient,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      padding: widget.padding ?? const EdgeInsets.all(24),
      child: widget.child,
    );
  }

  List<BoxShadow> _buildShadows() {
    final baseElevation = 8.0;
    final hoverElevation = 24.0;
    final currentElevation = baseElevation + (_elevationAnimation.value * (hoverElevation - baseElevation));
    
    return [
      BoxShadow(
        color: AppColors.shadowMedium.withOpacity(0.1 + (_glowAnimation.value * 0.1)),
        blurRadius: currentElevation,
        offset: Offset(0, currentElevation / 2),
      ),
      BoxShadow(
        color: AppColors.shadowLight.withOpacity(0.05),
        blurRadius: 4,
        offset: const Offset(0, 2),
      ),
      if (_isHovered)
        BoxShadow(
          color: AppColors.accent.withOpacity(0.1 * _glowAnimation.value),
          blurRadius: 40 * _glowAnimation.value,
          offset: const Offset(0, 0),
        ),
    ];
  }
}

class ModernGlassCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final double borderRadius;
  final double blurIntensity;

  const ModernGlassCard({
    Key? key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.onTap,
    this.borderRadius = 20,
    this.blurIntensity = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blurIntensity, sigmaY: blurIntensity),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.25),
                    Colors.white.withOpacity(0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1.5,
                ),
              ),
              padding: padding ?? const EdgeInsets.all(24),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}