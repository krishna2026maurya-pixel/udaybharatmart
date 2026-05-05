import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uday_bharat/user_screen/provider/view_model/category_view_model.dart';
import 'package:uday_bharat/user_screen/provider/view_model/home_provider.dart';
import 'package:uday_bharat/user_screen/widgets/shimmer/item_detail_shimmer.dart';
import 'package:uday_bharat/utils/color.dart';
import 'package:uday_bharat/utils/cutom_text.dart';
import 'package:uday_bharat/utils/size.dart';

import '../../provider/view_model/cart_local_provider.dart';
import '../../widgets/cart_button_widget.dart';
import '../../widgets/empty_cart.dart';
import '../../widgets/image_slider.dart';
import '../../widgets/product_card.dart';
import '../homePage/home_page.dart';

class ItemDetailPage extends StatefulWidget {
  String? itemImage;
  String? itemId;
  String? heroTag;
  ItemDetailPage({super.key, this.itemImage, required this.itemId, this.heroTag});

  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage>
    with SingleTickerProviderStateMixin {
  bool _isFavorite = false;
  bool _infoExpanded = false;
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;

  bool isFirst = true;
  bool showCartBar = false;
  @override
  void initState() {
    super.initState();
    print('----------widget.itemId>${widget.itemId}');
    Provider.of<CategoryViewModel>(
      context,
      listen: false,
    ).productDetailCache.remove(widget.itemId);
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    Future.microtask(() => fetchData());
  }

  void fetchData() {
    Provider.of<CategoryViewModel>(
      context,
      listen: false,
    ).getProductDetailApi(context, widget.itemId.toString());
  }

  void _toggleInfo() {
    setState(() {
      _infoExpanded = !_infoExpanded;
      if (_infoExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<String> _normalizeImages(dynamic imageList) {
    if (imageList == null) return <String>[];

    if (imageList is String) {
      return <String>[imageList]; // convert single string to list
    }

    if (imageList is List) {
      return imageList
          .map<String>((e) => (e is String) ? e : (e?.image ?? ''))
          .toList();
    }

    return <String>[];
  }

  @override
  Widget build(BuildContext context) {
    MyFontSize fontSize = MyFontSize(context);
    return Scaffold(
      body: Consumer<CategoryViewModel>(
        builder: (context, provider, child) {
          final getItem = provider.productDetailRes.data;
          if (isFirst == true) {
            if (provider.isLoading) {
              isFirst = false;
              return ItemDetailShimmer();
            }
          }

          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Hero(
                          tag: widget.heroTag ?? "product_${widget.itemId}",
                          child: ProductImageSlider(
                            images: _normalizeImages(
                              provider
                                  .productDetailRes
                                  .data
                                  ?.productDetails
                                  ?.imageList,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 45,
                          left: 20,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.white.withOpacity(0.3),
                              ),
                              child: Icon(
                                Icons.arrow_back_ios_new_outlined,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: Container(
                            width: fontSize.w / 2,
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                // topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 5,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.access_time, size: 10),
                                      SizedBox(width: 5),
                                      CustomText(
                                        getItem?.productDetails?.deliveryTime ==
                                                '0'
                                            ? '5'
                                            : '${getItem?.productDetails?.deliveryTime}',
                                        fontSize: 10,
                                      ),
                                    ],
                                  ),
                                  // CustomText('Rating',fontSize: 10),
                                  // Row(children: List.generate(5, (index) => Icon(Icons.star,color: Colors.yellow,size: 10),),)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: fontSize.h * 0.01),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Delivery time & rating
                          // SizedBox(height:fontSize.h*0.01),
                          // Item name
                          CustomText(
                            getItem?.productDetails?.productName ?? '',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: fontSize.h * 0.002),
                          CustomText(
                            '${getItem?.productDetails?.quantity ?? ''} ${getItem?.productDetails?.volume ?? ''}',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(height: fontSize.h * 0.002),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CustomText(
                                    '₹${getItem?.productDetails?.totalAmt ?? ''}',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                  if (getItem?.productDetails?.totalAmt !=
                                      getItem?.productDetails?.mrp) ...[
                                    SizedBox(width: 10),
                                    CustomText(
                                      'MRP ₹${getItem?.productDetails?.mrp ?? ''}',
                                      fontSize: 14,
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey,
                                    ),
                                  ],
                                  if (getItem?.productDetails?.offerPercent !=
                                          null &&
                                      getItem?.productDetails?.offerPercent !=
                                          '0' &&
                                      getItem?.productDetails?.offerPercent !=
                                          '' &&
                                      getItem?.productDetails?.totalAmt !=
                                          getItem?.productDetails?.mrp) ...[
                                    SizedBox(width: 10),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 5,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.green.shade100,
                                      ),
                                      child: CustomText(
                                        '${getItem?.productDetails?.offerPercent ?? ''}%OFF',
                                        fontSize: 10,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              AddToCartWidget(
                                itemImage: '',
                                status: 'item_detail',
                                // detailProductId: widget.itemId,
                                stockStatus:
                                    getItem?.productDetails?.stockStatus ?? '0',
                                value: int.parse(
                                  getItem?.productDetails?.quantityInCart ??
                                      '0',
                                ),
                                productId: getItem?.productDetails?.id ?? '',
                                onCartChanged: (image) {
                                  fetchData();
                                  // if (onCartChanged != null) {
                                  //   onCartChanged!(image);
                                  // }
                                },
                              ),
                            ],
                          ),

                          SizedBox(height: fontSize.h * 0.01),
                          // Info section with dropdown animation
                          if (getItem?.productDetails?.addInfoTitle != '')
                            GestureDetector(
                              onTap: _toggleInfo,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    "${getItem?.productDetails?.addInfoTitle}",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  Icon(
                                    _infoExpanded
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                  ),
                                ],
                              ),
                            ),
                          if (getItem?.productDetails?.addInfoDesc != '')
                            SizeTransition(
                              sizeFactor: _expandAnimation,
                              axisAlignment: -1,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: CustomText(
                                  fontSize: 12,
                                  getItem?.productDetails?.addInfoDesc ?? '',
                                ),
                              ),
                            ),
                          if (getItem?.productDetails?.addInfoTitle != '')
                            SizedBox(height: fontSize.h * 0.02),
                          // Related products grid
                          const CustomText(
                            'Similar Products',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: getItem?.similarProducts?.length ?? 0,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 3 / 5.9,
                                ),
                            itemBuilder: (context, index) {
                              final getSimilarProduct =
                                  getItem?.similarProducts?[index];
                              final history = Provider.of<CartLocalProvider>(
                                context,
                              ).getAddedHistory();
                              print('----------itemDetail>${history}');
                              return ProductCard1(
                                status: 'similar_on_${widget.itemId}',
                                index: index,
                                itemById: '',
                                stockStatus:
                                    getSimilarProduct?.stockStatus ?? '0',
                                cartCount:
                                    getSimilarProduct?.quantityInCart
                                        .toString() ??
                                    '0',
                                productId: getSimilarProduct?.id.toString(),
                                imageUrl:
                                    getImageUrl(getSimilarProduct?.imageList ?? ''),
                                unitText:
                                    '${getSimilarProduct?.quantity ?? ''}${getSimilarProduct?.volume ?? ''}',
                                title: getSimilarProduct?.productName ?? '',
                                time:
                                    getSimilarProduct?.deliveryTime ??
                                    '',
                                discountText:
                                    "${getSimilarProduct?.offerPercent}% OFF",
                                price: "₹${getSimilarProduct?.totalAmt}",
                                mrp: "MRP ₹${getSimilarProduct?.mrp}",
                                isBestSeller: true,
                                onCartChanged: (image) {},
                              );
                            },
                          ),
                          const SizedBox(height: 150),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                child: SafeArea(
                  child: Consumer<CartLocalProvider>(
                    builder: (context, cartLocal, child) {
                      return cartCheckoutButton(
                        showCartBar: cartLocal.totalQty == 0 ? false : true,
                        totalCartQty: cartLocal.totalQty,
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
