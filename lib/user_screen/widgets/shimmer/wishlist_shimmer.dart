import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class WishlistShimmer extends StatelessWidget {
  const WishlistShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.72,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (_, index) => shimmerCard(),
    );
  }

  Widget shimmerCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE BOX
            Container(
              height: 130,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
            ),

            const SizedBox(height: 10),

            // TITLE
            Container(
              height: 14,
              width: 120,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 6),

            // PRICE ROW
            Row(
              children: [
                Container(
                  height: 14,
                  width: 60,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(width: 10),
                Container(
                  height: 14,
                  width: 40,
                  color: Colors.grey.shade300,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ADD TO CART BTN
            Container(
              height: 35,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
            )
          ],
        ),
      ),
    );
  }
}
