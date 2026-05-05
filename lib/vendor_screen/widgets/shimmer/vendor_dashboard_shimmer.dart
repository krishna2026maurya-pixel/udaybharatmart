import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uday_bharat/utils/color.dart';
import 'package:uday_bharat/utils/size.dart';

class VendorDashboardShimmer extends StatelessWidget {
  const VendorDashboardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    MyFontSize fontSize = MyFontSize(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // 🔵 Profile section shimmer
          shimmerBox(height: 70, width: double.infinity, radius: 12),

          const SizedBox(height: 20),

          // 🔵 New order animation shimmer
          shimmerBox(height: 70, width: double.infinity, radius: 12),

          const SizedBox(height: 20),

          // 🔵 Dashboard big cards shimmer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              shimmerBox(
                height: fontSize.h / 6.8,
                width: fontSize.w / 2.2,
                radius: 12,
              ),
              shimmerBox(
                height: fontSize.h / 6.8,
                width: fontSize.w / 2.2,
                radius: 12,
              ),
            ],
          ),

          const SizedBox(height: 20),
          shimmerLine(width: 150, height: 18),

          const SizedBox(height: 10),

          // 🔵 Order status small cards shimmer (3 in one row)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              shimmerBox(
                height: fontSize.h / 6.8,
                width: fontSize.w / 3.3,
                radius: 12,
              ),
              shimmerBox(
                height: fontSize.h / 6.8,
                width: fontSize.w / 3.3,
                radius: 12,
              ),
              shimmerBox(
                height: fontSize.h / 6.8,
                width: fontSize.w / 3.3,
                radius: 12,
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              shimmerBox(
                height: fontSize.h / 6.8,
                width: fontSize.w / 3.3,
                radius: 12,
              ),
              shimmerBox(
                height: fontSize.h / 6.8,
                width: fontSize.w / 3.3,
                radius: 12,
              ),
              shimmerBox(
                height: fontSize.h / 6.8,
                width: fontSize.w / 3.3,
                radius: 12,
              ),
            ],
          ),

          const SizedBox(height: 25),
          shimmerLine(width: 150, height: 18),

          const SizedBox(height: 10),

          // 🔵 Recent orders list shimmer
          Column(
            children: List.generate(
              4,
                  (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: shimmerBox(
                  height: 90,
                  width: double.infinity,
                  radius: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget shimmerBox({double? height, double? width, double radius = 10}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }

  Widget shimmerLine({double? height, double? width}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
