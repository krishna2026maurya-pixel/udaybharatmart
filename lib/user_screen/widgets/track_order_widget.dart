import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:uday_bharat/utils/cutom_text.dart';

class OrderTrackingCard extends StatelessWidget {
  final String orderId;
  final String eta;
  final int currentStep;
  final VoidCallback onTrackTap;

  const OrderTrackingCard({
    super.key,
    required this.orderId,
    required this.eta,
    required this.currentStep,
    required this.onTrackTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 4),
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: const Color(0xffFFF6E6),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// HEADER
          Row(
            children: [
              Lottie.asset('assets/Delivery.json', height: 35),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "arrive in $eta",
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              AnimatedGradientButton(onTap: onTrackTap)

            ],
          ),
        ],
      ),
    );
  }

}


class AnimatedGradientButton extends StatefulWidget {
  final VoidCallback onTap;
  const AnimatedGradientButton({super.key, required this.onTap});
  @override
  State<AnimatedGradientButton> createState() =>
      _AnimatedGradientButtonState();
}
class _AnimatedGradientButtonState extends State<AnimatedGradientButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: LinearGradient(
                begin: Alignment(-1 + _controller.value * 2, 0),
                end: Alignment(1 + _controller.value * 2, 0),
                colors: const [
                  Color(0xffFF9F1C),
                  Color(0xffFF3D00),
                  Color(0xffFF9F1C),
                ],
              ),
            ),
            child: const CustomText(
              'Track Now',
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          );
        },
      ),
    );
  }
}
