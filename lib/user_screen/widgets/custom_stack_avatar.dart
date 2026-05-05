import 'package:flutter/material.dart';
import 'package:uday_bharat/utils/cache_image.dart';
class CustomAvatarStack extends StatelessWidget {
  final List<String> imageUrls;
  final double size;
  final double overlap;

  const CustomAvatarStack({
    super.key,
    required this.imageUrls,
    this.size = 45,
    this.overlap = 15,
  });

  @override
  Widget build(BuildContext context) {
    final width = (imageUrls.length * (size - overlap)) + overlap;
    return SizedBox(
      width: width,
      height: size,
      child: Stack(
        children: List.generate(imageUrls.length, (index) {
          return Positioned(
            left: index * (size - overlap),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(size),
              child:
              Image.network(
                imageUrls[index],
                height: size,
                width: size,
                fit: BoxFit.cover,
              ),
            ),
          );
        }),
      ),
    );
  }
}



class CustomAvatarStack1 extends StatelessWidget {
  final List<String> imageUrls;
  final double size;
  final double overlap;

  const CustomAvatarStack1({
    super.key,
    required this.imageUrls,
    this.size = 45,
    this.overlap = 15,
  });

  @override
  Widget build(BuildContext context) {
    final width = (imageUrls.length * (size - overlap)) + overlap;
    return SizedBox(
      width: width,
      height: size,
      child: Stack(
        children: List.generate(imageUrls.length, (index) {
          return Positioned(
            left: index * (size - overlap),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(size),
              child: CustomNetworkImage(
                  height: size,
                  width: size,
                  borderRadius: 100,
                  imageUrl: imageUrls[index]),
            ),
          );
        }),
      ),
    );
  }
}



