import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uday_bharat/user_screen/dashborad/homePage/home_page.dart';
import 'package:uday_bharat/user_screen/provider/view_model/cart_view_model.dart';
import 'package:uday_bharat/utils/color.dart';
import 'package:uday_bharat/utils/cutom_text.dart';
import '../../widgets/image_slider.dart';
import '../../widgets/product_card.dart';
import '../../widgets/shimmer/wishlist_shimmer.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});
  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  bool isFirst = true;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() {
    Future.microtask(
      () => Provider.of<CartViewModel>(
        context,
        listen: false,
      ).getUserWishlistApi(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        centerTitle: true,
        title: const CustomText("My Wishlist"),
        backgroundColor: AppColors.appColor,
      ),
      body: Consumer<CartViewModel>(
        builder: (context, getWishlist, child) {
          if (isFirst == true) {
            if (getWishlist.isLoading) {
              isFirst = false;
              return WishlistShimmer();
            }
          }
          if (getWishlist.getWishListRes.wishlist == null ||
              getWishlist.getWishListRes.wishlist!.isEmpty) {
            return buildEmptyWishlist();
          }
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: getWishlist.getWishListRes.wishlist?.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 10,
                childAspectRatio: 3 / 5.8,
              ),
              itemBuilder: (_, index) {
                final getProduct = getWishlist.getWishListRes.wishlist?[index];
                return Stack(
                  children: [
                    ProductCard1(
                      status: 'wish_list',
                      index: index,
                      itemById: '',
                      stockStatus: getProduct?.stockStatus ?? '0',
                      cartCount: getProduct?.cartQty,
                      productId: getProduct?.productId.toString(),
                      imageUrl: getProduct?.productImage ?? '',
                      unitText:
                          '${getProduct?.quantity ?? ''}${getProduct?.volume ?? ''}',
                      title: getProduct?.productName ?? '',
                      time: getProduct?.deliveryTimeTaken ?? '',
                      discountText: "${getProduct?.offerPercent}% OFF",
                      price: "₹${getProduct?.sellingPrice}",
                      mrp: "MRP ₹${getProduct?.mrp}",
                      isBestSeller: true,
                      onCartChanged: (image) {},
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          getWishlist.toggleWishlist(context, getProduct!);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Icon(
                            getProduct?.isWishlist == '1'
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: getProduct?.isWishlist == '1'
                                ? Colors.pink
                                : Colors.grey,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  // -------------------- EMPTY UI --------------------
  Widget buildEmptyWishlist() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 120, color: Colors.grey.shade400),
          const SizedBox(height: 10),
          const CustomText(
            "Your Wishlist is Empty",
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          CustomText(
            "Add items you love to see them here.",
            color: Colors.grey.shade600,
          ),
        ],
      ),
    );
  }
  // -------------------- GRID VIEW --------------------
}
