import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uday_bharat/utils/cache_image.dart';

class ProductImageSlider extends StatefulWidget {
  final List<String> images;
  const ProductImageSlider({super.key, required this.images});
  @override
  State<ProductImageSlider> createState() => _ProductImageSliderState();
}
class _ProductImageSliderState extends State<ProductImageSlider> {
  PageController _controller = PageController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // -------------------- IMAGE SLIDER --------------------
        SizedBox(
          height: 280,
          width: double.infinity,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() => currentIndex = index);
            },
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                ),
                child:CustomNetworkImage(imageUrl: widget.images[index])
              );
            },
          ),
        ),
        // -------------------- DOT INDICATOR ON IMAGE --------------------
        Positioned(
          bottom: 10,
          right: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.images.length,
                  (index) => AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 4),
                width: currentIndex == index ? 12 : 8,
                height: currentIndex == index ? 12 : 8,
                decoration: BoxDecoration(
                  color: currentIndex == index
                      ? Colors.white
                      : Colors.white54,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}



String getImageUrl(String raw) {
  if (raw.trim().isEmpty) return '';

  try {
    // 🔹 Detect JSON array
    if (raw.contains('[') && raw.contains(']')) {
      final jsonPart = raw.substring(raw.indexOf('['));
      final List images = jsonDecode(jsonPart);

      if (images.isNotEmpty) {
        return images.first.toString(); // ✅ DIRECT FIRST IMAGE
      }
    }

    // 🔹 Comma separated fallback
    if (raw.contains(',')) {
      return raw.split(',').first.trim();
    }

    // 🔹 Already single image
    return raw.trim();
  } catch (e) {
    debugPrint("getImageUrl error: $e");
    return '';
  }
}

