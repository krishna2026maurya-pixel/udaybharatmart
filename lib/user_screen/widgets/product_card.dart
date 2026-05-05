import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uday_bharat/user_screen/dashborad/item/item_detail_screen.dart';
import 'package:uday_bharat/user_screen/provider/model/home_page_model.dart';
import 'package:uday_bharat/user_screen/provider/model/product_detail_model.dart';
import 'package:uday_bharat/user_screen/provider/view_model/cart_view_model.dart';
import 'package:uday_bharat/user_screen/provider/view_model/category_view_model.dart';
import 'package:uday_bharat/user_screen/provider/view_model/home_provider.dart';
import 'package:uday_bharat/utils/cache_image.dart';
import 'package:uday_bharat/utils/cutom_text.dart';
import 'package:uday_bharat/utils/size.dart';
import '../../utils/color.dart';
import 'cart_button_widget.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String unitText;
  final String title;
  final String time;
  final String discountText;
  final String price;
  final String mrp;
  final String stockStatus;
  int? index;
  int? productIndex;
  final String? productId;
  final String? cartCount;
  final String? status;
  final bool isBestSeller;
  final String? heroTag;
  final Function(String image)? onCartChanged;

  ProductCard({
    required this.imageUrl,
    required this.unitText,
    required this.title,
    required this.time,
    required this.discountText,
    required this.price,
    required this.mrp,
    required this.status,
    required this.stockStatus,
    this.index,
    this.productIndex,
    this.productId,
    this.cartCount,
    this.isBestSeller = false,
    this.heroTag,
    this.onCartChanged,
  });

  @override
  Widget build(BuildContext context) {
    MyFontSize fontSize = MyFontSize(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (productId != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ItemDetailPage(
                  itemId: productId,
                  itemImage: imageUrl,
                  heroTag: heroTag ?? "product_$productId",
                ),
              ),
            );
          }
        },
        child: Hero(
          tag: heroTag ?? "product_$productId",
          child: Stack(
            children: [
              Container(
                width: fontSize.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomNetworkImage(
                      imageUrl: imageUrl,
                      height: fontSize.h / 8,
                      width: fontSize.w,
                      borderRadius: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 5,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 2,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: AppColors.priceValueBgColor,
                            ),
                            child: CustomText(
                              unitText,
                              color: AppColors.black.withOpacity(0.7),
                              fontSize: 10,
                              maxLines: 1,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 2),
                          CustomText(
                            title,
                            fontSize: 10,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w600,
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_rounded,
                                color: Colors.green,
                                size: 12,
                              ),
                              CustomText(
                                " ${time == '0 min' ? '5 min' : time}",
                                fontSize: 8,
                                fontWeight: FontWeight.w600,
                                color: AppColors.black.withOpacity(0.7),
                              ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          if (discountText != '0% OFF' &&
                              discountText != 'null% OFF' &&
                              discountText != '% OFF' &&
                              mrp.replaceAll(RegExp(r'[^0-9]'), '') !=
                                  price.replaceAll(RegExp(r'[^0-9]'), ''))
                            CustomText(
                              discountText,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.appColor,
                            ),
                          const SizedBox(height: 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                price,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                              if (mrp.replaceAll(RegExp(r'[^0-9]'), '') !=
                                  price.replaceAll(RegExp(r'[^0-9]'), ''))
                                CustomText(
                                  mrp,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Positioned(
                top: fontSize.h / 8.6,
                right: 5,
                child: AddToCartWidget(
                  itemImage: imageUrl,
                  status: status,
                  stockStatus: stockStatus,
                  value: int.tryParse(cartCount ?? '0') ?? 0,
                  productId: productId ?? '',
                  mrp:
                      double.tryParse(
                        (mrp ?? '').replaceAll(RegExp(r'[^0-9.]'), ''),
                      )?.toInt() ??
                      0,

                  sellingPrice:
                      double.tryParse(
                        (price ?? '').replaceAll(RegExp(r'[^0-9.]'), ''),
                      )?.toInt() ??
                      0,

                  onCartChanged: (image) {
                    if (onCartChanged != null) {}
                  },
                ),
              ),
              Consumer<HomeProvider>(
                builder: (context, provider, child) {
                  final categories =
                      provider.userHomeRes.data?.categoriesWithProducts;
                  if (categories == null ||
                      categories.isEmpty ||
                      index == null ||
                      index! >= categories.length ||
                      categories[index!].products == null ||
                      productIndex == null ||
                      productIndex! >= categories[index!].products!.length) {
                    return const SizedBox(); // return empty widget
                  }
                  final product = categories[index!].products![productIndex!];
                  return Positioned(
                    top: 0,
                    right: 0,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          provider.toggleWishlist(context, product);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Icon(
                            product.wishlistStatus == '1'
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: product.wishlistStatus == '1'
                                ? Colors.pink
                                : Colors.grey,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductCard1 extends StatelessWidget {
  final String imageUrl;
  final String unitText;
  final String title;
  final String time;
  final String discountText;
  final String price;
  final String mrp;
  final String itemById;
  final String stockStatus;

  int? index;
  final String? productId;
  final String? cartCount;
  final String? status;

  final bool isBestSeller;
  final String? heroTag;
  final Function(String image)? onCartChanged;
  ProductCard1({
    required this.imageUrl,
    required this.unitText,
    required this.title,
    required this.time,
    required this.discountText,
    required this.stockStatus,
    required this.price,
    required this.mrp,
    required this.status,
    required this.itemById,
    this.index,
    this.productId,
    this.cartCount,
    this.isBestSeller = false,
    this.heroTag,
    this.onCartChanged,
  });

  @override
  Widget build(BuildContext context) {
    MyFontSize fontSize = MyFontSize(context);
    return Stack(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              final String finalHeroTag =
                  heroTag ?? "product_${productId}_${index}_${status}";
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 350),
                  pageBuilder: (_, __, ___) => ItemDetailPage(
                    itemId: productId,
                    itemImage: imageUrl,
                    heroTag: finalHeroTag,
                    key: ValueKey(productId),
                  ),
                ),
              );
            },
            child: Hero(
              tag: heroTag ?? "product_${productId}_${index}_${status}",
              child: Container(
                width: fontSize.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomNetworkImage(
                      imageUrl: imageUrl,
                      height: fontSize.h / 8,
                      width: fontSize.w,
                      borderRadius: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 5,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 2,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: AppColors.priceValueBgColor,
                            ),
                            child: CustomText(
                              unitText,
                              color: AppColors.black.withOpacity(0.7),
                              fontSize: 10,
                              maxLines: 1,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 2),
                          CustomText(
                            title,
                            fontSize: 10,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w600,
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_rounded,
                                color: Colors.green,
                                size: 12,
                              ),
                              CustomText(
                                " ${time == '0 min' ? '5 min' : time}",
                                fontSize: 8,
                                fontWeight: FontWeight.w600,
                                color: AppColors.black.withOpacity(0.7),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          if (discountText != '0% OFF' &&
                              discountText != 'null% OFF' &&
                              discountText != '% OFF' &&
                              mrp.replaceAll(RegExp(r'[^0-9]'), '') !=
                                  price.replaceAll(RegExp(r'[^0-9]'), ''))
                            CustomText(
                              discountText,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.appColor,
                            ),
                          const SizedBox(height: 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                price,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                              if (mrp.replaceAll(RegExp(r'[^0-9]'), '') !=
                                  price.replaceAll(RegExp(r'[^0-9]'), ''))
                                CustomText(
                                  mrp,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: fontSize.h / 8.6,
          right: 5,
          child: AddToCartWidget(
            itemImage: imageUrl,
            status: status,
            stockStatus: stockStatus,
            value: int.tryParse(cartCount ?? '0') ?? 0,
            productId: productId ?? '',
            mrp:
                double.tryParse(
                  (mrp ?? '').replaceAll(RegExp(r'[^0-9.]'), ''),
                )?.toInt() ??
                0,
            sellingPrice:
                double.tryParse(
                  (price ?? '').replaceAll(RegExp(r'[^0-9.]'), ''),
                )?.toInt() ??
                0,
            onCartChanged: (image) {},
          ),
        ),
      ],
    );
  }
}
