import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uday_bharat/utils/color.dart';

class CartCheckoutShimmer extends StatelessWidget {
  const CartCheckoutShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Delivery info shimmer
            _shadowContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _shimmerRow(height: 18, width: 150),
                  const SizedBox(height: 6),
                  _shimmerRow(height: 14, width: 120),
                  const SizedBox(height: 16),
                  Column(
                    children: List.generate(3, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            _shimmerBox(width: 60, height: 60, radius: 8),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _shimmerRow(height: 12, width: double.infinity),
                                  const SizedBox(height: 8),
                                  _shimmerRow(height: 12, width: 100),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                _shimmerBox(width: 60, height: 25, radius: 8),
                                const SizedBox(height: 8),
                                _shimmerRow(height: 12, width: 50),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                  )
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Coupon shimmer
            _shadowContainer(
              child: Row(
                children: [
                  _shimmerBox(width: 24, height: 24, radius: 6),
                  const SizedBox(width: 12),
                  Expanded(child: _shimmerRow(height: 14, width: double.infinity)),
                  const SizedBox(width: 12),
                  _shimmerBox(width: 20, height: 20, radius: 5),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Bill details shimmer
            _shadowContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _shimmerRow(height: 16, width: 100),
                  const SizedBox(height: 16),
                  ...List.generate(
                    3,
                        (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _shimmerRow(height: 12, width: 100),
                          _shimmerRow(height: 12, width: 60),
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _shimmerRow(height: 14, width: 80),
                      _shimmerRow(height: 14, width: 80),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Add GST shimmer
            _shadowContainer(
              child: Row(
                children: [
                  _shimmerBox(width: 24, height: 24, radius: 6),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _shimmerRow(height: 14, width: 150),
                        const SizedBox(height: 6),
                        _shimmerRow(height: 12, width: 200),
                      ],
                    ),
                  ),
                  _shimmerBox(width: 20, height: 20, radius: 5),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Cancellation policy shimmer
            _shadowContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _shimmerRow(height: 14, width: 120),
                  const SizedBox(height: 8),
                  _shimmerRow(height: 12, width: double.infinity),
                  const SizedBox(height: 6),
                  _shimmerRow(height: 12, width: double.infinity),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // shimmer base widget
  Widget _shimmerBox({required double width, required double height, double radius = 8}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.shade400,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }

  Widget _shimmerRow({required double height, required double width}) {
    return _shimmerBox(width: width, height: height);
  }

  Widget _shadowContainer({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(1, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}
