import 'package:flutter/material.dart';

class BouncingImage extends StatefulWidget {
  const BouncingImage({super.key});

  @override
  State<BouncingImage> createState() => _BouncingImageState();
}

class _BouncingImageState extends State<BouncingImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // duration of one bounce
    );

    // Tween to move the image up and down smoothly
    _animation = Tween<double>(
      begin: 0,
      end: 20,
    ).chain(CurveTween(curve: Curves.easeInOut)).animate(_controller);

    _controller.forward(); // play animation once
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse(); // bounce back once
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
        return Transform.translate(
          offset: Offset(0, -_animation.value), // move up by animation
          child: Image.asset(
            'assets/appstore-modified.png',
            height: 200,
            width: 200,
          ),
        );
      },
    );
  }
}
