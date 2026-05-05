import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uday_bharat/user_screen/provider/view_model/home_provider.dart';
import 'package:uday_bharat/user_screen/widgets/product_card.dart';
import 'package:uday_bharat/utils/cache_image.dart';
import 'package:uday_bharat/utils/color.dart';
import 'package:uday_bharat/utils/cutom_text.dart';
import 'package:uday_bharat/utils/form.dart';
import 'package:uday_bharat/utils/size.dart';

import '../../provider/view_model/cart_local_provider.dart';
import '../../widgets/empty_cart.dart';
import '../../widgets/image_slider.dart';
import '../../widgets/shimmer/search_item_shimmer.dart';

class SearchItemScreen extends StatefulWidget {
  const SearchItemScreen({super.key});

  @override
  State<SearchItemScreen> createState() => _SearchItemScreenState();
}

class _SearchItemScreenState extends State<SearchItemScreen> {
  TextEditingController queryController = TextEditingController();
  bool showSuggestions = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<HomeProvider>(context, listen: false);
    provider.searchItemApi(context, searchQuery: '');
    provider.initSearchPagination(context, '');
  }
  @override
  void dispose() {
    _debounce?.cancel();
    queryController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    MyFontSize fontSize = MyFontSize(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: Container(),
        toolbarHeight: 20,
        bottom: PreferredSize(
          preferredSize: Size(100, 50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CustomForm(
              controller: queryController,
              hintWidget: CustomText(
                'Search for atta, dal, vegitable, beauty',
                color: AppColors.black.withOpacity(0.5),
                fontSize: 12,

              ),
              suffixIcon: queryController.text.isNotEmpty
                  ? InkWell(
                onTap: () {
                  queryController.clear();
                  FocusScope.of(context).unfocus();
                  setState(() => showSuggestions = false);

                  Provider.of<HomeProvider>(context, listen: false)
                      .searchItemApi(context, searchQuery: '');
                },
                child: const Icon(Icons.close, size: 18),
              )
                  : null,

              prefixIcon: Icon(Icons.search,
                  size: 20, color: AppColors.black.withOpacity(0.5)),
              onChanged: (value) {
                setState(() {
                  showSuggestions = value.isNotEmpty;
                });

                if (_debounce?.isActive ?? false) _debounce!.cancel();

                _debounce = Timer(const Duration(milliseconds: 300), () {
                  Provider.of<HomeProvider>(context, listen: false)
                      .searchItemApi(context, searchQuery: value);
                });
              },

            ),
          ),
        ),
      ),
      body: Consumer<HomeProvider>(
        builder: (context, provider, child) {
          final getSearchData = provider.seaItemRes.data;

          if (provider.isLoading==true && showSuggestions) {
            return const SearchShimmer();
          }

          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SafeArea(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (showSuggestions &&
                          (getSearchData?.suggestionList?.isNotEmpty ?? false))
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            getSearchData!.suggestionList!.length,
                                (index) {
                              final getSuggestionData =
                              getSearchData.suggestionList![index];
                              return InkWell(
                                onTap: () {
                                  queryController.text = getSuggestionData.productName ?? '';
                                  FocusScope.of(context).unfocus();
                                  setState(() => showSuggestions = false);
                                  Provider.of<HomeProvider>(context, listen: false)
                                      .searchItemApi(
                                    context,
                                    searchQuery: getSuggestionData.productName ?? '',
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  child: Row(
                                    children: [
                                      CustomNetworkImage(
                                        imageUrl: getSuggestionData.image ?? '',
                                        height: 40,
                                        width: 40,
                                        borderRadius: 8,
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: CustomText(
                                          getSuggestionData.productName ?? '',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );

                            },
                          ),
                        ),
                      if (!provider.isLoading &&
                          (getSearchData?.productsList?.isEmpty ?? true) &&
                          queryController.text.isNotEmpty)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Column(
                              children: [
                                Icon(Icons.search_off, size: 60, color: Colors.grey),
                                const SizedBox(height: 10),
                                CustomText(
                                  'No products found',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                      SizedBox(height: 10),
                      // ⭐ Product Grid
                      Expanded(
                        child: GridView.builder( padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          controller: provider.searchScrollController,
                          shrinkWrap: true,
                          //physics: NeverScrollableScrollPhysics(),
                          itemCount: getSearchData?.productsList?.length ?? 0,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, crossAxisSpacing: 5,
                            mainAxisSpacing: 10, childAspectRatio: 3 / 5.8, ),
                          itemBuilder: (context, index) {
                            final getItem = getSearchData?.productsList?[index];
                            return  ProductCard1(
                              itemById: '',
                              status: 'category',
                              index: index,
                              // itemById: widget.catId,
                              stockStatus: getItem?.stockStatus ?? '',
                              cartCount: getItem?.quantityInCart.toString()??'',
                              productId: getItem?.id.toString(),
                              imageUrl:getItem?.productImage??'', //getImageUrl(getItem?.image?? ''),
                              unitText: '${getItem?.quantity??""}${getItem?.volume??""}',
                              title: getItem?.productName ?? '',
                              time: getItem?.deliveryTime ?? '',
                              discountText: "${getItem?.offerPercent}% OFF",
                              price: "₹${getItem?.totalAmt}",
                              mrp: "MRP ₹${getItem?.mrp}",
                              isBestSeller: true,
                              onCartChanged:  (image) {
                              },
                            ); }, ),
                      ),
                      if (provider.isLoadMore)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),

                    ],
                  ),
                ),
              ),

              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: Consumer<CartLocalProvider>(builder: (context, cartLocal, child) {
                      return cartCheckoutButton(
                        showCartBar: cartLocal.totalQty != 0,
                        totalCartQty: cartLocal.totalQty,
                        grandTotalAmount: cartLocal.grandTotalAmount,
                        totalSavedAmount: cartLocal.totalSavedAmount,
                      );
                    }
                    ),
                  )
              ),
            ],
          );
        },
      ),
    );
  }
}