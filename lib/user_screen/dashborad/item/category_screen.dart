import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:uday_bharat/user_screen/dashborad/homePage/home_page.dart';
import 'package:uday_bharat/user_screen/dashborad/searh_item_screen/search_item_screen.dart';
import 'package:uday_bharat/user_screen/provider/model/home_page_model.dart';
import 'package:uday_bharat/user_screen/provider/view_model/category_view_model.dart';
import 'package:uday_bharat/user_screen/provider/view_model/home_provider.dart';
import 'package:uday_bharat/user_screen/widgets/image_slider.dart';
import 'package:uday_bharat/utils/cache_image.dart';
import 'package:uday_bharat/utils/color.dart';
import 'package:uday_bharat/utils/cutom_text.dart';
import 'package:uday_bharat/utils/size.dart';
import '../../../utils/progress_bar.dart';
import '../../provider/view_model/cart_local_provider.dart';
import '../../widgets/empty_cart.dart';
import '../../widgets/product_card.dart';
import '../../widgets/shimmer/category_shimmer.dart';

class CategoryScreen extends StatefulWidget {
  String catId;
  String? catName;
  CategoryScreen({super.key, required this.catId, this.catName});
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int selectCatIndex = 0;
  bool isFirst = true;
  @override
  void initState() {
    super.initState();
    fetchData();
    Provider.of<CategoryViewModel>(
      context,
      listen: false,
    ).initPagination(context, widget.catId);
  }

  void fetchData() async {
    Future.microtask(
      () => Provider.of<CategoryViewModel>(
        context,
        listen: false,
      ).getCategoryApi(context, widget.catId),
    );
  }

  @override
  Widget build(BuildContext context) {
    MyFontSize fontSize = MyFontSize(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: CustomText(widget.catName ?? "", fontWeight: FontWeight.w600),
        centerTitle: true,
        leading: BackButton(),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchItemScreen()),
              );
            },
            child: Icon(Iconsax.search_normal),
          ),
          SizedBox(width: 15),
        ],
      ),
      body: Consumer<CategoryViewModel>(
        builder: (context, provider, child) {
          if (provider.isLoading && isFirst) {
            isFirst = false;
            return const Center(child: CategoryShimmer());
          }
          // if (provider.isLoading) {
          //   return const Center(child: CategoryShimmer());
          // }
          return Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Stack(
              children: [
                Row(
                  children: [
                    /// Left Category List
                    SizedBox(
                      width: fontSize.w / 4,
                      child: ListView.builder(
                        itemCount: provider
                            .subcategoryRes
                            .data
                            ?.subcategoryList
                            ?.length,
                        itemBuilder: (context, index) {
                          final isSelected = selectCatIndex == index;
                          final getSubcategoryList =
                              provider.subcategoryRes.data?.subcategoryList;
                          return GestureDetector(
                            onTap: () {
                              setState(() => selectCatIndex = index);
                              final subId =
                                  provider
                                      .subcategoryRes
                                      .data
                                      ?.subcategoryList?[index]
                                      .subcategoryId ??
                                  '0';
                              provider.productScrollController.jumpTo(0);
                              provider.getCategoryApi(
                                context,
                                widget.catId,
                                subcategoryId: subId,
                              );
                            },
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      top: 10,
                                      left: 10,
                                      right: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.black.withOpacity(0.09),
                                      // isSelected ? AppColors.black.withOpacity(0.09) : Colors.transparent,
                                      border: isSelected
                                          ? Border.all(
                                              color: Colors.green,
                                              width: 2,
                                            )
                                          : null,
                                    ),
                                    child: CustomNetworkImage(
                                      borderRadius: 30,
                                      imageUrl:
                                          getSubcategoryList?[index]
                                              .subcategoryImage ??
                                          "",
                                      height: 60,
                                      width: 60,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                CustomText(
                                  getSubcategoryList?[index].subcategoryName ??
                                      "",
                                  textAlign: TextAlign.center,
                                  fontSize: 12,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                ),
                                const SizedBox(height: 6),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: fontSize.w * 0.01),

                    /// Right Product Grid
                    Expanded(
                      child:
                          provider
                                  .subcategoryRes
                                  .data
                                  ?.subcategoryList
                                  ?.isEmpty ??
                              true
                          ? Center(
                              child: CustomText(
                                "No Products Found",
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: GridView.builder(
                                controller: provider.productScrollController,
                                physics: BouncingScrollPhysics(),
                                itemCount:
                                    provider
                                        .subcategoryRes
                                        .data
                                        ?.products
                                        ?.length ??
                                    0,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 12,
                                      mainAxisSpacing: 12,
                                      childAspectRatio: 0.57,
                                    ),
                                itemBuilder: (context, index) {
                                  final getProducts = provider
                                      .subcategoryRes
                                      .data
                                      ?.products?[index];
                                  return Stack(
                                    children: [
                                      ProductCard1(
                                        itemById: '',
                                        status: 'category',
                                        index: index,
                                        // itemById: widget.catId,
                                        stockStatus:
                                            getProducts?.stockStatus ?? '',
                                        cartCount:
                                            getProducts?.quantityInCart
                                                .toString() ??
                                            '',
                                        productId: getProducts?.id.toString(),
                                        imageUrl: getImageUrl(
                                          getProducts?.productImages ?? '',
                                        ),
                                        unitText:
                                            '${getProducts?.quantity ?? ""}${getProducts?.volume ?? ""}',
                                        title: getProducts?.productName ?? '',
                                        time: getProducts?.deliveryTime ?? '',
                                        discountText:
                                            "${getProducts?.offerPercent}% OFF",
                                        price: "₹${getProducts?.totalAmt}",
                                        mrp: "MRP ₹${getProducts?.mrp}",
                                        isBestSeller: true,
                                        onCartChanged: (image) {},
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () {
                                              provider.toggleSubcategory(
                                                context,
                                                getProducts!,
                                              );
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Icon(
                                                getProducts?.wishlistStatus ==
                                                        '1'
                                                    ? Icons.favorite
                                                    : Icons.favorite_border,
                                                color:
                                                    getProducts
                                                            ?.wishlistStatus ==
                                                        '1'
                                                    ? Colors.pink
                                                    : Colors.grey,
                                                size: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                    ),
                  ],
                ),
                provider.isLoadMoreLoading
                    ? Center(child: CustomProgressBar())
                    : Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: SafeArea(
                          child: Consumer<CartLocalProvider>(
                            builder: (context, cartLocal, child) {
                              return cartCheckoutButton(
                                showCartBar: cartLocal.totalQty != 0,
                                totalCartQty: cartLocal.totalQty,
                                grandTotalAmount: cartLocal.grandTotalAmount,
                                totalSavedAmount: cartLocal.totalSavedAmount,
                              );
                            },
                          ),
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
