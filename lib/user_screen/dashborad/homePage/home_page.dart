import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart' hide SearchBar;
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uday_bharat/user_screen/dashborad/homePage/homeslider.dart';
import 'package:uday_bharat/user_screen/dashborad/order/order_detail_screen.dart';
import 'package:uday_bharat/user_screen/provider/view_model/cart_local_provider.dart';
import 'package:uday_bharat/user_screen/provider/view_model/home_provider.dart';
import 'package:uday_bharat/user_screen/widgets/empty_cart.dart';
import 'package:uday_bharat/user_screen/widgets/shimmer/home_shimmer.dart';
import 'package:uday_bharat/utils/cache_image.dart';
import 'package:uday_bharat/utils/color.dart';
import 'package:uday_bharat/utils/cutom_text.dart';
import 'package:uday_bharat/utils/size.dart';
import '../../../empty_service.dart';
import '../../../location_service/location_provider.dart';
import '../../../location_service/update_item_location.dart';
import '../../../utils/session.dart';
import '../../wallet/wallet_balance_widget.dart';
import '../../widgets/custom_stack_avatar.dart';
import '../../widgets/product_card.dart';
import '../../widgets/track_order_widget.dart';
import '../item/category_screen.dart';
import '../item/item_detail_screen.dart';
import '../../widgets/home_heder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  String? lastAddedImage;
  int totalCartItems = 0;
  bool isFirst = true;
  bool showCartBar = false;
  late LocationProvider locationProvider;
  bool showAllCategory = false;
  int categoryIndex = 0;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
    userID();
  }

  void _scrollListener() {
    final controller = _scrollController;
    if (!controller.hasClients) return;
    final isAtBottom =
        controller.position.pixels >= controller.position.maxScrollExtent - 150;
    final isScrollingDown =
        controller.position.userScrollDirection == ScrollDirection.reverse;
    if (isAtBottom && isScrollingDown) {
      Provider.of<HomeProvider>(
        context,
        listen: false,
      ).homeApi(context, loadMore: true);
    }
  }

  String? userId;
  void userID() async {
    userId = await MySharedPreferences.getUserId();
    setState(() {});
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MyFontSize fontSize = MyFontSize(context);
    return Scaffold(
      body: Consumer<HomeProvider>(
        builder: (context, cartProvider, child) {
          final qty =
              int.tryParse(
                cartProvider.userHomeRes.data?.totalCartQty ?? '0',
              ) ??
              0;
          showCartBar = qty > 0;
          final homeProvider = cartProvider;
          final getHomeData = homeProvider.userHomeRes.data;
          if (isFirst == true) {
            if (homeProvider.isLoading) {
              isFirst = false;
              return const Center(child: HomePageShimmer());
            }
          }
          if (getHomeData?.serviceAreaStatus == '0') {
            isFirst = false;
            return Center(
              child: EmptyServiceView(
                onChangeLocation: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (context) => const FractionallySizedBox(
                      heightFactor: 0.70,
                      child: SelectLocationBottomSheet(),
                    ),
                  );
                },
              ),
            );
          }
          print('-----------------------${getHomeData?.serviceAreaStatus}');
          return Stack(
            children: [
              RefreshIndicator(
                onRefresh: () =>
                    homeProvider.homeApi(context, categoryTypeId: ''),
                child: CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  controller: _scrollController,
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      floating: true,
                      expandedHeight: fontSize.h / 3.3,
                      backgroundColor: AppColors.appColor,
                      leading: Container(),
                      actions: [
                        Padding(
                          padding: EdgeInsets.only(right: 12),
                          child: WalletBalanceWidget(userId: userId),
                        ),
                      ],
                      flexibleSpace: FlexibleSpaceBar(
                        background: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColors.appColor,
                                AppColors.lightAppColor,
                                AppColors.lightAppColor.withOpacity(0.4),
                              ],
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: fontSize.h * 0.04),
                              AnimatedTextKit(
                                repeatForever: true,
                                animatedTexts: [
                                  ColorizeAnimatedText(
                                    'Fast Delivery',
                                    textStyle: GoogleFonts.archivoBlack(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    colors: [
                                      Colors.black,
                                      Colors.orange,
                                      Colors.yellow,
                                      Colors.green,
                                      Colors.blue,
                                      Colors.purple,
                                    ],
                                    speed: const Duration(milliseconds: 400),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.white,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                    ),
                                    builder: (context) =>
                                        const FractionallySizedBox(
                                          heightFactor: 0.70,
                                          child: SelectLocationBottomSheet(),
                                        ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      color: AppColors.white,
                                      size: 20,
                                    ),
                                    SizedBox(width: 6),
                                    Expanded(
                                      child: Consumer<LocationProvider>(
                                        builder: (context, value, child) =>
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                  'Delivery in minutes',
                                                  fontSize: 12,
                                                  //color: AppColors.white,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                CustomText(
                                                  value.fullAddress ??
                                                      'No Location Selected',
                                                  fontSize: 12,
                                                  // color: AppColors.white,
                                                  maxLines: 2,
                                                ),
                                                SizedBox(height: 5),
                                              ],
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                // const SizedBox(height: 10),
                              ),
                              const SizedBox(height: 10),
                              SearchBar(),
                            ],
                          ),
                        ),
                      ),
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(fontSize.h * 0.10),
                        child: Container(
                          height: fontSize.h * 0.10,
                          color: AppColors.lightAppColor.withOpacity(0.2),
                          child: AnimatedCategoryTabBar(
                            tabs: getHomeData?.categoriesOnly ?? [],
                            onChanged: (index) {
                              if (index == -1) {
                                homeProvider.homeApi(
                                  context,
                                  categoryTypeId: '',
                                );
                              } else {
                                final cat = getHomeData?.categoriesOnly?[index];
                                homeProvider.homeApi(
                                  context,
                                  categoryTypeId: cat?.id,
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    // if(getHomeData?.banners?.first.bannerType=='image')
                    //   const SizedBox(height: 10),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: HomeBannerSlider(
                          banners: getHomeData?.banners ?? [],
                        ),
                      ),
                    ),

                    SliverList(
                      delegate: SliverChildListDelegate([
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5),
                              CustomText(
                                'Bestsellers',
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                              const SizedBox(height: 10),
                              GridView.builder(
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    (getHomeData
                                                ?.bestsellerVendorProducts
                                                ?.length ??
                                            0)
                                        .clamp(0, 9),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 12,
                                      childAspectRatio: 0.75,
                                    ),
                                itemBuilder: (context, boxIndex) {
                                  final category = getHomeData
                                      ?.bestsellerVendorProducts?[boxIndex];
                                  final products = category?.products ?? [];

                                  return InkWell(
                                    borderRadius: BorderRadius.circular(12),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => CategoryScreen(
                                            catId: category?.categoryId ?? "",
                                            catName:
                                                category?.categoryName ?? "",
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.blue.withOpacity(0.06),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: const EdgeInsets.all(1),
                                      child: Column(
                                        children: [
                                          /// 🖼 PRODUCT IMAGE GRID (FIXED SIZE)
                                          Expanded(
                                            child: GridView.builder(
                                              padding: EdgeInsets.zero,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: 4,
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    crossAxisSpacing: 1,
                                                    mainAxisSpacing: 1,
                                                  ),
                                              itemBuilder: (context, index) {
                                                if (index >= products.length) {
                                                  return const SizedBox();
                                                }

                                                final product = products[index];

                                                return ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: AspectRatio(
                                                    aspectRatio: 1,
                                                    child: CustomNetworkImage(
                                                      borderRadius: 10,
                                                      imageUrl:
                                                          product
                                                              .productImages ??
                                                          '',
                                                      // fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),

                                          const SizedBox(height: 5),

                                          /// 🏷 CATEGORY NAME
                                          CustomText(
                                            category?.categoryName ?? '',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey.shade800,
                                          ),
                                          const SizedBox(height: 2),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 2),
                              CustomText(
                                'Category',
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                              const SizedBox(height: 1),
                              GridView.builder(
                                primary: false,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                addRepaintBoundaries: false,
                                itemCount:
                                    getHomeData
                                        ?.categoriesWithProducts
                                        ?.length ??
                                    0,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      crossAxisSpacing: 5,
                                      mainAxisSpacing: 10,
                                      childAspectRatio: 3 / 5,
                                    ),
                                itemBuilder: (context, boxIndex) {
                                  final getProduct = getHomeData
                                      ?.categoriesWithProducts?[boxIndex];

                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => CategoryScreen(
                                            catId: getProduct?.categoryId ?? '',
                                            catName:
                                                getProduct?.categoryName ?? '',
                                          ),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.teal.withOpacity(
                                              0.07,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          padding: const EdgeInsets.all(8),
                                          child: CustomNetworkImage(
                                            height: fontSize.h / 9.1,
                                            imageUrl:
                                                getProduct?.categoryImage ?? '',
                                            borderRadius: 10,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        CustomText(
                                          getProduct?.categoryName ?? '',
                                          maxLines: 2,
                                          fontSize: 12,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),

                              const SizedBox(height: 20),
                              CustomText(
                                'Trending near you',
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                              const CustomText(
                                'Discover the top product trending today',
                              ),

                              const SizedBox(height: 10),
                              ...List.generate(getHomeData?.categoriesWithProducts?.length ?? 0, (
                                index,
                              ) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (getHomeData
                                            ?.categoriesWithProducts?[index]
                                            .products
                                            ?.isNotEmpty ??
                                        false)
                                      CustomText(
                                        getHomeData
                                                ?.categoriesWithProducts?[index]
                                                .categoryName ??
                                            "",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                      ),
                                    const SizedBox(height: 10),
                                    GridView.builder(
                                      padding: EdgeInsets.zero,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: getHomeData
                                          ?.categoriesWithProducts?[index]
                                          .products
                                          ?.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 5,
                                            mainAxisSpacing: 10,
                                            childAspectRatio: 3 / 5.9,
                                          ),
                                      itemBuilder: (context, boxIndex) {
                                        final getProduct = getHomeData
                                            ?.categoriesWithProducts?[index]
                                            .products?[boxIndex];
                                        categoryIndex = boxIndex;
                                        // final history = Provider.of<CartLocalProvider>(context).getAddedHistory();
                                        return Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () {
                                              print(
                                                'productIdByTap---->${getProduct?.id}',
                                              );
                                              print(
                                                'productImages---->${getProduct?.productImages ?? ''}',
                                              );
                                              print(
                                                'getAdded:${Provider.of<CartLocalProvider>(context, listen: false).getQty(getProduct?.id.toString() ?? '').toString()}',
                                              );
                                              Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  transitionDuration:
                                                      const Duration(
                                                        milliseconds: 450,
                                                      ),
                                                  reverseTransitionDuration:
                                                      const Duration(
                                                        milliseconds: 300,
                                                      ),
                                                  pageBuilder:
                                                      (
                                                        context,
                                                        animation,
                                                        secondaryAnimation,
                                                      ) {
                                                        return FadeTransition(
                                                          opacity: animation,
                                                          child: ItemDetailPage(
                                                            itemId:
                                                                getProduct?.id
                                                                    .toString() ??
                                                                '',
                                                            itemImage:
                                                                getProduct
                                                                    ?.productImages ??
                                                                '',
                                                          ),
                                                        );
                                                      },
                                                ),
                                              );
                                            },
                                            child: ProductCard(
                                              heroTag: "product_${getProduct?.id}_${index}_${boxIndex}",
                                              status: 'home',
                                              index: index,
                                              productIndex: boxIndex,
                                              stockStatus:
                                                  getProduct?.stockStatus ??
                                                  '',
                                              cartCount:
                                                  Provider.of<
                                                        CartLocalProvider
                                                      >(
                                                        context,
                                                        listen: false,
                                                      )
                                                      .getQty(
                                                        getProduct?.id
                                                                .toString() ??
                                                            '',
                                                      )
                                                      .toString(),
                                              productId: getProduct?.id
                                                  .toString(),
                                              imageUrl:
                                                  getProduct?.productImages ??
                                                  '',
                                              unitText:
                                                  "${getProduct?.quantity} ${getProduct?.volume}",
                                              title:
                                                  getProduct?.productName ??
                                                  '',
                                              time:
                                                  getProduct
                                                      ?.deliveryTimeTaken ??
                                                  '',
                                              discountText:
                                                  "${getProduct?.offerPercent}% OFF",
                                              price:
                                                  "₹${getProduct?.totalAmt}",
                                              mrp: "MRP ₹${getProduct?.mrp}",
                                              isBestSeller:
                                                  getProduct
                                                          ?.vendor
                                                          ?.isBestseller ==
                                                      '0'
                                                  ? false
                                                  : true,
                                              onCartChanged: (image) {},
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    if (getHomeData
                                            ?.categoriesWithProducts?[index]
                                            .products
                                            ?.isNotEmpty ??
                                        false)
                                      InkWell(
                                        onTap: () {
                                          final getCat = getHomeData
                                              ?.categoriesWithProducts?[index];
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CategoryScreen(
                                                    catId:
                                                        getCat?.categoryId ??
                                                        "",
                                                    catName:
                                                        getCat?.categoryName ??
                                                        "",
                                                  ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 5,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                            color: Colors.cyan.shade50,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CustomAvatarStack1(
                                                overlap: 12,
                                                size: 30,
                                                imageUrls: List.generate(
                                                  getHomeData
                                                          ?.categoriesWithProducts?[index]
                                                          .products
                                                          ?.length ??
                                                      0,
                                                  (catindex) {
                                                    final getProduct = getHomeData
                                                        ?.categoriesWithProducts?[index]
                                                        .products?[catindex];
                                                    return getProduct
                                                            ?.productImages ??
                                                        "";
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                width: fontSize.w * 0.02,
                                              ),
                                              Row(
                                                children: [
                                                  CustomText(
                                                    'See all product',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  Icon(
                                                    Icons.arrow_right,
                                                    size: 15,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                );
                              }),
                              if (!homeProvider.hasMore == false)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 30,
                                  ),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          'Ziply Mart',
                                          style: GoogleFonts.poppins(
                                            fontSize: 26,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 2,
                                            color: Colors.grey.withOpacity(0.6),
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          'Fast. Simple. Reliable.❤️❤️❤️',
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey.withOpacity(0.5),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Consumer<CartLocalProvider>(
                  builder: (context, cartLocal, child) {
                    return Column(
                      children: [
                        if (getHomeData?.pendingOrderStatus == '1')
                          OrderTrackingCard(
                            orderId: "skdj",
                            eta:
                                "${getHomeData?.pendingOrderDetails?.deliveryEtaMinutes ?? ''} Minutes",
                            currentStep: 2,
                            onTrackTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OrderDetailScreen(
                                    orderID: getHomeData
                                        ?.pendingOrderDetails
                                        ?.orderId,
                                    showOrderID: '',
                                  ),
                                ),
                              );
                            },
                          ),
                        if (cartLocal.totalQty != 0)
                          cartCheckoutButton(
                            showCartBar: cartLocal.totalQty != 0,
                            totalCartQty: cartLocal.totalQty,
                            grandTotalAmount: cartLocal.grandTotalAmount,
                            totalSavedAmount: cartLocal.totalSavedAmount,
                          ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
