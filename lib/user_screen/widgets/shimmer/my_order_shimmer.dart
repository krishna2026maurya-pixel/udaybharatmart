import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MyOrdersShimmer extends StatelessWidget {
  const MyOrdersShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 6,
                offset: const Offset(0, 2),
              )
            ],
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Order Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _box(width: 120, height: 14),
                    _box(width: 70, height: 14),
                  ],
                ),
                const SizedBox(height: 6),
                _box(width: 150, height: 10),

                const SizedBox(height: 10),
                const Divider(),

                // Product List (3 items)
                Column(
                  children: List.generate(3, (i) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          // Image
                          _circleBox(size: 30),

                          const SizedBox(width: 8),

                          // Product name
                          _box(width: 120, height: 14),

                          const Spacer(),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              _box(width: 40, height: 12),
                              const SizedBox(height: 4),
                              _box(width: 30, height: 10),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ),

                // Total Amount
                _box(width: 100, height: 14),
                const SizedBox(height: 10),

                // Track Your Order Button
                Align(
                  alignment: Alignment.centerLeft,
                  child: _box(width: 120, height: 28, radius: 8),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _box({double width = 100, double height = 10, double radius = 6}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  Widget _circleBox({double size = 40}) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}
