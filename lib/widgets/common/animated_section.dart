import 'package:flutter/material.dart';

class AnimatedSection extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final double slideOffset;
  final bool fadeIn;
  final bool slideUp;

  const AnimatedSection({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.curve = Curves.easeOutCubic,
    this.slideOffset = 50.0,
    this.fadeIn = true,
    this.slideUp = true,
  });

  @override
  State<AnimatedSection> createState() => _AnimatedSectionState();
}

class _AnimatedSectionState extends State<AnimatedSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, widget.slideUp ? widget.slideOffset / 100 : 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));

    // Start animation after a short delay
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Future.delayed(const Duration(milliseconds: 100), () {
          if (mounted) {
            setState(() {
              _isVisible = true;
            });
            _controller.forward();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: widget.slideUp
              ? Offset(0, _slideAnimation.value.dy * 100)
              : Offset.zero,
          child: Opacity(
            opacity: widget.fadeIn ? _fadeAnimation.value : 1.0,
            child: widget.child,
          ),
        );
      },
    );
  }
}

class StaggeredAnimationWrapper extends StatefulWidget {
  final List<Widget> children;
  final Duration staggerDelay;
  final Duration animationDuration;
  final Axis direction;

  const StaggeredAnimationWrapper({
    super.key,
    required this.children,
    this.staggerDelay = const Duration(milliseconds: 200),
    this.animationDuration = const Duration(milliseconds: 600),
    this.direction = Axis.vertical,
  });

  @override
  State<StaggeredAnimationWrapper> createState() => _StaggeredAnimationWrapperState();
}

class _StaggeredAnimationWrapperState extends State<StaggeredAnimationWrapper> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.children.asMap().entries.map((entry) {
        final index = entry.key;
        final child = entry.value;
        
        return AnimatedSection(
          duration: widget.animationDuration,
          child: child,
        );
      }).toList(),
    );
  }
}

class HoverAnimationWrapper extends StatefulWidget {
  final Widget child;
  final double hoverScale;
  final Duration duration;
  final Color? hoverColor;
  final double elevation;

  const HoverAnimationWrapper({
    super.key,
    required this.child,
    this.hoverScale = 1.05,
    this.duration = const Duration(milliseconds: 200),
    this.hoverColor,
    this.elevation = 0,
  });

  @override
  State<HoverAnimationWrapper> createState() => _HoverAnimationWrapperState();
}

class _HoverAnimationWrapperState extends State<HoverAnimationWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.hoverScale,
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

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
        _controller.forward();
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
        _controller.reverse();
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: AnimatedContainer(
              duration: widget.duration,
              decoration: BoxDecoration(
                boxShadow: _isHovered && widget.elevation > 0
                    ? [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: widget.elevation,
                          offset: Offset(0, widget.elevation / 2),
                        ),
                      ]
                    : null,
              ),
              child: widget.child,
            ),
          );
        },
      ),
    );
  }
}

class CountUpAnimation extends StatefulWidget {
  final int targetNumber;
  final Duration duration;
  final TextStyle? textStyle;
  final String suffix;

  const CountUpAnimation({
    super.key,
    required this.targetNumber,
    this.duration = const Duration(seconds: 2),
    this.textStyle,
    this.suffix = '',
  });

  @override
  State<CountUpAnimation> createState() => _CountUpAnimationState();
}

class _CountUpAnimationState extends State<CountUpAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = IntTween(
      begin: 0,
      end: widget.targetNumber,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    // Start animation after a delay
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Text(
          '${_animation.value}${widget.suffix}',
          style: widget.textStyle,
        );
      },
    );
  }
}