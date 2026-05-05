import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uday_bharat/utils/size.dart';

class HomeShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const HomeShimmerWidget.rectangular({this.width = double.infinity, this.height = 16, Key? key})
      : shapeBorder = const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        super(key: key);

  const HomeShimmerWidget.circular({this.width = 50, this.height = 50, Key? key})
      : shapeBorder = const CircleBorder(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            width: width,
            height: height,
            decoration: ShapeDecoration(
              color: Colors.grey.shade300,
              shape: shapeBorder,
            ),
          ),
        ),
      ],
    );
  }
}





class HomePageShimmer extends StatelessWidget {
  const HomePageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
MyFontSize fontSize = MyFontSize(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header shimmer
          Container(
            width: double.infinity,
            height: height * 0.27,
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomeShimmerWidget.rectangular(height: 25, width: 150),
                const SizedBox(height: 5),
                const HomeShimmerWidget.rectangular(height: 15, width: 120),
                const SizedBox(height: 15),
                const HomeShimmerWidget.rectangular(height: 40, width: double.infinity),
                const SizedBox(height: 10),
                SizedBox(
                  height: fontSize.h/11,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (_, __) => Column(
                      children: const [
                        HomeShimmerWidget.circular(width: 50, height: 50),
                        SizedBox(height: 5),
                        HomeShimmerWidget.rectangular(height: 10, width: 50),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Bestsellers shimmer
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: const HomeShimmerWidget.rectangular(height: 20, width: 120),
          ),
          const SizedBox(height: 10),
          GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 3 / 5.5,
            ),
            itemBuilder: (_, __) => Column(
              children:  [
                HomeShimmerWidget.rectangular(height:fontSize.h/4.5, width: double.infinity),
                SizedBox(height: 5),
                HomeShimmerWidget.rectangular(height: 10, width: fontSize.w/3.8),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Trending near you shimmer
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: const HomeShimmerWidget.rectangular(height: 20, width: 180),
          ),
          const SizedBox(height: 10),
          GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 3 / 5.5,
            ),
            itemBuilder: (_, __) => Column(
              children:  [
                HomeShimmerWidget.rectangular(height: 150, width: double.infinity),
                SizedBox(height: 5),
                HomeShimmerWidget.rectangular(height: 10, width: fontSize.w/3.8),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Special offers shimmer
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: const HomeShimmerWidget.rectangular(height: 20, width: 150),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: 3,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (_, __) => const HomeShimmerWidget.rectangular(
                width: 200,
                height: 150,
                key: ValueKey('special_offer'),
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
