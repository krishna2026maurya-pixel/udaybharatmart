import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uday_bharat/utils/color.dart';
import 'package:uday_bharat/utils/shadow_container.dart';

class CheckoutProcessShimmer extends StatelessWidget {
  const CheckoutProcessShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🏠 Address Section Shimmer
            ShadowContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _shimmerLine(width: 180, height: 16),
                  const SizedBox(height: 14),
                  Column(
                    children: List.generate(3, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _circleShimmer(20),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _shimmerLine(width: double.infinity, height: 12),
                                  const SizedBox(height: 6),
                                  _shimmerLine(width: 150, height: 12),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _iconShimmer(20, 20),
                      const SizedBox(width: 8),
                      _shimmerLine(width: 120, height: 14),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // 💳 Payment Section Shimmer
            ShadowContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _shimmerLine(width: 160, height: 16),
                  const SizedBox(height: 14),
                  Column(
                    children: List.generate(3, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _circleShimmer(20),
                            const SizedBox(width: 10),
                            _shimmerLine(width: 200, height: 12),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // 📦 Order Summary Shimmer
            ShadowContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _shimmerLine(width: 120, height: 16),
                  const SizedBox(height: 14),
                  ...List.generate(3, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _shimmerLine(width: 100, height: 12),
                          _shimmerLine(width: 60, height: 12),
                        ],
                      ),
                    );
                  }),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _shimmerLine(width: 90, height: 14),
                      _shimmerLine(width: 80, height: 14),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 🧾 Place Order Button Shimmer
            _buttonShimmer(),
          ],
        ),
      ),
    );
  }

  // 🌈 shimmer widgets
  Widget _shimmerLine({required double width, required double height}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.shade400,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }

  Widget _circleShimmer(double size) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _iconShimmer(double width, double height) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.shade400,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  Widget _buttonShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey.shade400,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
