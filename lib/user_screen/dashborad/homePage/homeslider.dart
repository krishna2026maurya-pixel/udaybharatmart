import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:uday_bharat/user_screen/dashborad/item/category_screen.dart';

import '../../provider/model/home_page_model.dart';

class HomeBannerSlider extends StatelessWidget {
  final List<Banners> banners;

  const HomeBannerSlider({super.key, required this.banners});

  @override
  Widget build(BuildContext context) {
    if (banners.isEmpty) return const SizedBox();

    return CarouselSlider.builder(
      itemCount: banners.length,
      options: CarouselOptions(
        height: 130,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.92,
        autoPlayInterval: const Duration(seconds: 4),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
      ),

      itemBuilder: (context, index, realIndex) {
        final banner = banners[index];

        return InkWell(
          onTap: (){
            print('------------------->${banner.vendor_category_id??''}');
            Navigator.push(context, MaterialPageRoute(builder: (context) =>
              CategoryScreen(catId: banner.vendor_category_id??''),));
            },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  spreadRadius: 2,
                  color: Colors.black.withOpacity(.08),
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: _buildBannerWidget(banner),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBannerWidget(Banners banner) {
    if (banner.bannerType == "gif" || banner.bannerType == "image") {
      return CachedNetworkImage(
        imageUrl: banner.bannerUrl ?? '',
        fit: BoxFit.cover,
        height: 130,
        width: double.infinity,
        placeholder: (c, _) => Container(color: Colors.grey.shade200),
        errorWidget: (c, _, __) => Container(
          color: Colors.grey.shade200,
          child: const Icon(Icons.image_not_supported),
        ),
      );
    }

    if (banner.bannerType == "lottie") {
      return Lottie.network(
        banner.bannerUrl ?? '',
        fit: BoxFit.cover,
      );
    }

    return const SizedBox();
  }
}
