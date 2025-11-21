import 'package:flutter/material.dart';

class ParallaxWidget extends StatefulWidget {
  final Widget child;
  final double parallaxFactor;
  final ScrollController? scrollController;
  final bool enableParallax;

  const ParallaxWidget({
    Key? key,
    required this.child,
    this.parallaxFactor = 0.5,
    this.scrollController,
    this.enableParallax = true,
  }) : super(key: key);

  @override
  State<ParallaxWidget> createState() => _ParallaxWidgetState();
}

class _ParallaxWidgetState extends State<ParallaxWidget> {
  double _offset = 0.0;

  @override
  void initState() {
    super.initState();
    if (widget.enableParallax && widget.scrollController != null) {
      widget.scrollController!.addListener(_updateOffset);
    }
  }

  @override
  void dispose() {
    if (widget.enableParallax && widget.scrollController != null) {
      widget.scrollController!.removeListener(_updateOffset);
    }
    super.dispose();
  }

  void _updateOffset() {
    if (mounted && widget.scrollController != null) {
      setState(() {
        _offset = widget.scrollController!.offset * widget.parallaxFactor;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enableParallax) {
      return widget.child;
    }

    return Transform.translate(
      offset: Offset(0, _offset),
      child: widget.child,
    );
  }
}

class FloatingParticles extends StatefulWidget {
  final int particleCount;
  final double width;
  final double height;
  final Color particleColor;
  final double minSize;
  final double maxSize;

  const FloatingParticles({
    Key? key,
    this.particleCount = 20,
    required this.width,
    required this.height,
    this.particleColor = Colors.white,
    this.minSize = 2.0,
    this.maxSize = 6.0,
  }) : super(key: key);

  @override
  State<FloatingParticles> createState() => _FloatingParticlesState();
}

class _FloatingParticlesState extends State<FloatingParticles>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
  late List<Particle> _particles;

  @override
  void initState() {
    super.initState();
    _initializeParticles();
  }

  void _initializeParticles() {
    _controllers = [];
    _animations = [];
    _particles = [];

    for (int i = 0; i < widget.particleCount; i++) {
      final controller = AnimationController(
        duration: Duration(milliseconds: 3000 + (i * 100)),
        vsync: this,
      );

      final animation = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ));

      final particle = Particle(
        x: (i / widget.particleCount) * widget.width,
        y: widget.height + 50,
        size: widget.minSize + 
              (widget.maxSize - widget.minSize) * (i / widget.particleCount),
        opacity: 0.3 + (0.4 * (i / widget.particleCount)),
      );

      _controllers.add(controller);
      _animations.add(animation);
      _particles.add(particle);

      controller.repeat();
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: _particles.asMap().entries.map((entry) {
          final index = entry.key;
          final particle = entry.value;

          return AnimatedBuilder(
            animation: _animations[index],
            builder: (context, child) {
              final progress = _animations[index].value;
              final y = widget.height - (progress * (widget.height + 100));
              final x = particle.x + (20 * progress * (index % 2 == 0 ? 1 : -1));

              return Positioned(
                left: x,
                top: y,
                child: Opacity(
                  opacity: particle.opacity * (1 - progress),
                  child: Container(
                    width: particle.size,
                    height: particle.size,
                    decoration: BoxDecoration(
                      color: widget.particleColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: widget.particleColor.withOpacity(0.3),
                          blurRadius: particle.size,
                          spreadRadius: particle.size / 2,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}

class Particle {
  final double x;
  final double y;
  final double size;
  final double opacity;

  Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.opacity,
  });
}

class MicroInteractionButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Duration animationDuration;
  final double scaleOnTap;
  final Color? rippleColor;

  const MicroInteractionButton({
    Key? key,
    required this.child,
    this.onTap,
    this.animationDuration = const Duration(milliseconds: 150),
    this.scaleOnTap = 0.95,
    this.rippleColor,
  }) : super(key: key);

  @override
  State<MicroInteractionButton> createState() => _MicroInteractionButtonState();
}

class _MicroInteractionButtonState extends State<MicroInteractionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.scaleOnTap,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    if (widget.onTap != null) {
      widget.onTap!();
    }
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: widget.child,
          );
        },
      ),
    );
  }
}