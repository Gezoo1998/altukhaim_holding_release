import 'dart:ui';
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'animated_section.dart';

class GridPatternPainter extends CustomPainter {
  final Color color;
  
  GridPatternPainter({required this.color});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    
    const gridSize = 20.0;
    
    // Draw vertical lines
    for (double x = 0; x <= size.width; x += gridSize) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }
    
    // Draw horizontal lines
    for (double y = 0; y <= size.height; y += gridSize) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class FloatingParticles extends StatefulWidget {
  final double width;
  final double height;
  final int particleCount;
  final Color particleColor;
  final double minSize;
  final double maxSize;

  const FloatingParticles({
    Key? key,
    required this.width,
    required this.height,
    this.particleCount = 25,
    this.particleColor = Colors.white,
    this.minSize = 2.0,
    this.maxSize = 8.0,
  }) : super(key: key);

  @override
  State<FloatingParticles> createState() => _FloatingParticlesState();
}

class _FloatingParticlesState extends State<FloatingParticles>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.particleCount,
      (index) => AnimationController(
        duration: Duration(milliseconds: 3000 + (index * 100)),
        vsync: this,
      ),
    );

    _animations = _controllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      );
    }).toList();

    for (var controller in _controllers) {
      controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(widget.particleCount, (index) {
        final random = (index * 37) % 100;
        return AnimatedBuilder(
          animation: _animations[index],
          builder: (context, child) {
            return Positioned(
              top: (widget.height * 0.1) + (random * 3) + (_animations[index].value * 20),
              left: (widget.width * 0.1) + (random * 5) + (_animations[index].value * 10),
              child: Container(
                width: widget.minSize + (index % 4),
                height: widget.minSize + (index % 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      widget.particleColor.withOpacity(0.6),
                      widget.particleColor.withOpacity(0.2),
                      Colors.transparent,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: widget.particleColor.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

class AnimatedBackground extends StatelessWidget {
  final Widget child;
  final bool enableParticles;
  final bool enableGeometricShapes;
  final Color? particleColor;
  final double opacity;

  const AnimatedBackground({
    Key? key,
    required this.child,
    this.enableParticles = true,
    this.enableGeometricShapes = true,
    this.particleColor,
    this.opacity = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        // Background geometric shapes
        if (enableGeometricShapes) _buildGeometricShapes(screenWidth, screenHeight),
        
        // Floating particles
        if (enableParticles)
          FloatingParticles(
            width: screenWidth,
            height: screenHeight,
            particleCount: 15,
            particleColor: (particleColor ?? AppColors.white).withOpacity(opacity * 0.6),
            minSize: 2.0,
            maxSize: 6.0,
          ),
        
        // Main content
        child,
      ],
    );
  }

  Widget _buildGeometricShapes(double screenWidth, double screenHeight) {
    return Stack(
      children: [
        // Floating rounded rectangle
        Positioned(
          top: screenHeight * 0.15,
          right: screenWidth * 0.1,
          child: AnimatedSection(
            duration: const Duration(milliseconds: 2000),
            child: Opacity(
              opacity: opacity * 0.8,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.accent.withOpacity(0.2 * opacity),
                      AppColors.accent.withOpacity(0.1 * opacity),
                      Colors.transparent,
                    ],
                  ),
                  border: Border.all(
                    color: AppColors.accent.withOpacity(0.3 * opacity),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent.withOpacity(0.15 * opacity),
                      blurRadius: 25,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        
        // Large floating circle
        Positioned(
          bottom: screenHeight * 0.25,
          left: -screenWidth * 0.05,
          child: AnimatedSection(
            duration: const Duration(milliseconds: 2500),
            child: Opacity(
              opacity: opacity * 0.7,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.secondary.withOpacity(0.3 * opacity),
                      AppColors.secondary.withOpacity(0.15 * opacity),
                      AppColors.secondary.withOpacity(0.05 * opacity),
                      Colors.transparent,
                    ],
                    stops: [0.0, 0.3, 0.7, 1.0],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.secondary.withOpacity(0.2 * opacity),
                      blurRadius: 40,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        
        // Grid pattern container
        Positioned(
          top: screenHeight * 0.4,
          left: screenWidth * 0.75,
          child: AnimatedSection(
            duration: const Duration(milliseconds: 1800),
            child: Opacity(
              opacity: opacity * 0.6,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: AppColors.gold.withOpacity(0.25 * opacity),
                    width: 1,
                  ),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.gold.withOpacity(0.1 * opacity),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: CustomPaint(
                  painter: GridPatternPainter(
                    color: AppColors.gold.withOpacity(0.15 * opacity),
                  ),
                ),
              ),
            ),
          ),
        ),
        
        // Additional small circle
        Positioned(
          top: screenHeight * 0.6,
          right: screenWidth * 0.2,
          child: AnimatedSection(
            duration: const Duration(milliseconds: 1600),
            child: Opacity(
              opacity: opacity * 0.5,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.accent.withOpacity(0.2 * opacity),
                      AppColors.accent.withOpacity(0.1 * opacity),
                      Colors.transparent,
                    ],
                  ),
                  border: Border.all(
                    color: AppColors.accent.withOpacity(0.2 * opacity),
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}