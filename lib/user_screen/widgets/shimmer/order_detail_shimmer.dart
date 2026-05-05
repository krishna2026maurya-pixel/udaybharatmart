import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget buildOrderDetailShimmer() {
  return SingleChildScrollView(
    child: Column(
      children: [
        // MAP SHIMMER
        _shimmerBox(height: 200, margin: const EdgeInsets.all(16)),
        // STATUS TIMELINE SHIMMER
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: List.generate(5, (index) {
              return Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Column(
                  children: [
                    _shimmerCircle(size: 40),
                    const SizedBox(height: 10),
                    _shimmerBox(height: 14, width: 60),
                  ],
                ),
              );
            }),
          ),
        ),

        // CUSTOMER DETAILS
        _shimmerCard(),

        // PAYMENT SUMMARY
        _shimmerCard(),

        const SizedBox(height: 20),
      ],
    ),
  );
}

Widget _shimmerCard() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12), color: Colors.white),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _shimmerBox(height: 18, width: 130),
        const SizedBox(height: 12),
        ...List.generate(
          3,
              (index) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _shimmerBox(height: 16, width: double.infinity),
          ),
        ),
      ],
    ),
  );
}

Widget _shimmerBox({
  double height = 16,
  double width = double.infinity,
  EdgeInsetsGeometry? margin,
}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: Container(
      height: height,
      width: width,
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}

Widget _shimmerCircle({double size = 40}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: Container(
      height: size,
      width: size,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    ),
  );
}
