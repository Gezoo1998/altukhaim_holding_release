import 'package:flutter/material.dart';
import '../constants/app_text_styles.dart';

class AnimatedText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration duration;
  final Duration delay;
  final AnimationType animationType;
  final TextAlign? textAlign;
  final int? maxLines;

  const AnimatedText({
    Key? key,
    required this.text,
    this.style,
    this.duration = const Duration(milliseconds: 800),
    this.delay = Duration.zero,
    this.animationType = AnimationType.fadeInUp,
    this.textAlign,
    this.maxLines,
  }) : super(key: key);

  @override
  State<AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

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
      curve: Curves.easeOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: _getInitialOffset(),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));

    _startAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() async {
    await Future.delayed(widget.delay);
    if (mounted) {
      _controller.forward();
    }
  }

  Offset _getInitialOffset() {
    switch (widget.animationType) {
      case AnimationType.fadeInUp:
        return const Offset(0, 0.5);
      case AnimationType.fadeInDown:
        return const Offset(0, -0.5);
      case AnimationType.fadeInLeft:
        return const Offset(-0.5, 0);
      case AnimationType.fadeInRight:
        return const Offset(0.5, 0);
      case AnimationType.fadeIn:
      case AnimationType.scaleIn:
        return Offset.zero;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        Widget textWidget = Text(
          widget.text,
          style: widget.style ?? AppTextStyles.bodyMedium,
          textAlign: widget.textAlign,
          maxLines: widget.maxLines,
          overflow: widget.maxLines != null ? TextOverflow.ellipsis : null,
        );

        switch (widget.animationType) {
          case AnimationType.fadeIn:
            return FadeTransition(
              opacity: _fadeAnimation,
              child: textWidget,
            );
          case AnimationType.scaleIn:
            return FadeTransition(
              opacity: _fadeAnimation,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: textWidget,
              ),
            );
          case AnimationType.fadeInUp:
          case AnimationType.fadeInDown:
          case AnimationType.fadeInLeft:
          case AnimationType.fadeInRight:
            return FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: textWidget,
              ),
            );
        }
      },
    );
  }
}

class TypewriterText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration duration;
  final Duration delay;
  final TextAlign? textAlign;

  const TypewriterText({
    Key? key,
    required this.text,
    this.style,
    this.duration = const Duration(milliseconds: 50),
    this.delay = Duration.zero,
    this.textAlign,
  }) : super(key: key);

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  String _displayedText = '';
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _startTypewriter();
  }

  void _startTypewriter() async {
    await Future.delayed(widget.delay);
    
    for (int i = 0; i <= widget.text.length; i++) {
      if (mounted) {
        setState(() {
          _displayedText = widget.text.substring(0, i);
        });
        await Future.delayed(widget.duration);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _displayedText,
      style: widget.style ?? AppTextStyles.bodyMedium,
      textAlign: widget.textAlign,
    );
  }
}

class AnimatedCounter extends StatefulWidget {
  final int value;
  final Duration duration;
  final TextStyle? style;
  final String? suffix;
  final String? prefix;

  const AnimatedCounter({
    Key? key,
    required this.value,
    this.duration = const Duration(milliseconds: 1000),
    this.style,
    this.suffix,
    this.prefix,
  }) : super(key: key);

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
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
      end: widget.value,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
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
          '${widget.prefix ?? ''}${_animation.value}${widget.suffix ?? ''}',
          style: widget.style ?? AppTextStyles.headingMedium,
        );
      },
    );
  }
}

enum AnimationType {
  fadeIn,
  fadeInUp,
  fadeInDown,
  fadeInLeft,
  fadeInRight,
  scaleIn,
}