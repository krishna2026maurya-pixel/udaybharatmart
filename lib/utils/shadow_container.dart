import 'package:flutter/material.dart';

class ShadowContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final Color color;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
   ShadowContainer({
    super.key,
    required this.child,
    this.borderRadius = 12,
    this.color = Colors.white,
    this.padding,
     this.width,
     this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding:padding?? EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}
