import 'package:flutter/material.dart';
import 'package:uday_bharat/utils/cutom_text.dart';

class AmountProgressBar extends StatelessWidget {
  final double totalAmount;
  final double purchasedAmount;

  const AmountProgressBar({
    super.key,
    required this.totalAmount,
    required this.purchasedAmount,
  });

  @override
  Widget build(BuildContext context) {
    double progress = (purchasedAmount / totalAmount).clamp(0, 1);

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 14,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(20),
          ),
        ),

        // Filled Part (Green)
        LayoutBuilder(
          builder: (context, constraints) {
            return Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 14,
                width: constraints.maxWidth * progress,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            );
          },
        ),

        // Arrow Message
        Positioned(
          top: -28,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: CustomText(
                  "You achieved ${(progress * 100).toInt()}%",
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              // Arrow
              ClipPath(
                clipper: ArrowClipper(),
                child: Container(
                  width: 14,
                  height: 8,
                  color: Colors.green,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

// Arrow Shape Below Message
class ArrowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
