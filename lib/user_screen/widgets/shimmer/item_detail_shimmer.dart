import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ItemDetailShimmer extends StatelessWidget {
  const ItemDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image shimmer
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: width,
              height: height / 2.5,
              color: Colors.grey.shade300,
            ),
          ),
          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title shimmer
                ShimmerBox(width: width * 0.5, height: 20),
                const SizedBox(height: 10),
                // Price shimmer
                Row(
                  children: [
                    ShimmerBox(width: 80, height: 18),
                    const SizedBox(width: 10),
                    ShimmerBox(width: 60, height: 16),
                  ],
                ),
                const SizedBox(height: 20),

                // Info section title
                ShimmerBox(width: width * 0.4, height: 20),
                const SizedBox(height: 10),
                // Info text shimmer
                Column(
                  children: List.generate(
                    3,
                        (_) => Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: ShimmerBox(width: width * 0.9, height: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Related Products title
                ShimmerBox(width: width * 0.5, height: 20),
                const SizedBox(height: 10),

                // Product grid shimmer
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 6,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3 / 5.1,
                  ),
                  itemBuilder: (context, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerBox(width: double.infinity, height: 90),
                      const SizedBox(height: 5),
                      ShimmerBox(width: width * 0.2, height: 10),
                      const SizedBox(height: 5),
                      ShimmerBox(width: width * 0.25, height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ShimmerBox extends StatelessWidget {
  final double width;
  final double height;

  const ShimmerBox({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
