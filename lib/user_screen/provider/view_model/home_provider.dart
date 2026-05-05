import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uday_bharat/location_service/location_provider.dart';
import 'package:uday_bharat/user_screen/provider/model/home_page_model.dart';
import 'package:uday_bharat/user_screen/provider/model/search_item_model.dart';
import 'package:uday_bharat/user_screen/provider/model/user_profile_model.dart';
import 'package:uday_bharat/user_screen/provider/repository/cart_repository.dart';
import 'package:uday_bharat/user_screen/provider/repository/home_repo.dart';
import 'package:uday_bharat/user_screen/provider/view_model/cart_view_model.dart';
import 'package:uday_bharat/utils/session.dart';

import '../../../data/checkStatus.dart';
import 'cart_local_provider.dart';

class HomeProvider extends ChangeNotifier {
  final _myRepo = HomeRepository();
  final _cartRepo = CartRepository();
  bool isLoading = false;
  bool hasLoadedOnce = false;
  HomePageModel userHomeRes = HomePageModel();
  /// Local map to store productId -> cart qty
  Map<String, int> cartQty = {};
  /// Queue for background cart API
  List<Map<String, dynamic>> _cartApiQueue = [];
  bool _isProcessingQueue = false;
  /// ------------------------------ HOME API ------------------------------
  int _offset = 10;
  bool _isFetchingMore = false;
  bool hasMore = true;
  /// call on tab change / pull refresh
  void resetOffset() {
    _offset = 0;
    hasMore = true;
    userHomeRes.data?.categoriesWithProducts?.clear();
    notifyListeners();
  }
  // Future<void> homeApi(BuildContext context, {String? categoryTypeId}) async {
  //   final locationProvider = Provider.of<LocationProvider>(context, listen: false);
  //   final userId = await MySharedPreferences.getUserId();
  //   final token = await MySharedPreferences.getFcmToken();
  //   final data = {
  //     "user_id": userId ?? '',
  //     "user_gps_lat": locationProvider.latitude.toString(),
  //     "user_gps_long": locationProvider.longitude.toString(),
  //     "fiberbase_token": userId != null ? token ?? '' : '',
  //     "offset": '0',
  //     "category_type_id": categoryTypeId,
  //   };
  //
  //   isLoading = true;
  //   notifyListeners();
  //
  //   try {
  //     userHomeRes = await _myRepo.getHomeRepo(context, data);
  //     final localCart = Provider.of<CartLocalProvider>(context, listen: false);
  //     /// 🔥 Merge API qty + Local qty
  //     for (var category in userHomeRes.data?.categoriesWithProducts ?? []) {
  //       for (var product in category.products ?? []) {
  //         int localQty = localCart.getQty(product.id.toString());
  //         product.quantityInCart = localQty.toString();
  //         cartQty[product.id.toString()] = localQty;
  //       }
  //     }
  //
  //   } catch (e) {
  //     print("Home API error: $e");
  //   }
  //
  //   isLoading = false;
  //   hasLoadedOnce = true;
  //   notifyListeners();
  // }
  bool canLoadMore = true;
  bool _hasNextPage = true;

  Future<void> homeApi(
      BuildContext context, {
        String? categoryTypeId,
        bool loadMore = false,
      }) async {

    /// 🔒 Guards
    if (_isFetchingMore) return;
    if (loadMore && !_hasNextPage) return;

    final locationProvider = Provider.of<LocationProvider>(context, listen: false);
    final userId = await MySharedPreferences.getUserId();
    final token = await MySharedPreferences.getFcmToken();

    /// 🔄 Fresh load
    if (!loadMore) {
      _offset = 0;
      _hasNextPage = true;
      isLoading = true;
    }

    _isFetchingMore = true;
    notifyListeners();

    final data = {
      "user_id": userId ?? '',
      "user_gps_lat": locationProvider.latitude.toString(),
      "user_gps_long": locationProvider.longitude.toString(),
      "fiberbase_token": userId != null ? token ?? '' : '',
      "offset": _offset.toString(),
      "category_type_id": categoryTypeId,
    };

    try {
      final res = await _myRepo.getHomeRepo(context, data);
      final newList = res.data?.categoriesWithProducts ?? [];

      /// ✅ FIRST LOAD
      if (!loadMore || userHomeRes.data == null) {
        userHomeRes = res;
      }
      /// ✅ PAGINATION → APPEND
      /// ✅ PAGINATION → APPEND WITHOUT DUPLICATES
      else {
        final oldCategories =
            userHomeRes.data?.categoriesWithProducts ?? [];

        for (var newCategory in newList) {
          // find same category
          final index = oldCategories.indexWhere(
                (c) => c.categoryId == newCategory.categoryId,
          );

          if (index == -1) {
            /// 🆕 completely new category
            oldCategories.add(newCategory);
          } else {
            /// 🔁 merge products (NO DUPLICATES)
            final oldProducts =
                oldCategories[index].products ?? [];

            final existingProductIds =
            oldProducts.map((e) => e.id).toSet();

            final freshProducts = newCategory.products
                ?.where((p) => !existingProductIds.contains(p.id))
                .toList() ??
                [];

            oldProducts.addAll(freshProducts);
            oldCategories[index].products = oldProducts;
          }
        }
      }


      /// 🔁 OFFSET / PAGE CONTROL
      if (loadMore) {
        if (newList.isNotEmpty) {
          _offset++;
        } else {
          _hasNextPage = false;
        }
      }

      debugPrint(
          "OFFSET=$_offset | PAGE_SIZE=${newList.length} | hasNext=$_hasNextPage");

    } catch (e) {
      debugPrint("Home API error: $e");
    } finally {
      isLoading = false;
      _isFetchingMore = false;
      notifyListeners();
    }
  }






  /// ------------------------------ GET PRODUCT QTY ------------------------------
  int getProductQty(String productId) {
    return cartQty[productId] ?? 0;
  }

  /// ------------------------------ UPDATE QTY LOCALLY ------------------------------
  void updateLocalQty(String productId, int qty) {
    cartQty[productId] = qty;
    notifyListeners();
  }

  /// ------------------------------ QUEUE CART API ------------------------------
  void queueCartApi(String type, String productId) {
    _cartApiQueue.add({"type": type, "productId": productId});
    _processQueue();
  }

  Future<void> _processQueue() async {
    if (_isProcessingQueue) return;

    _isProcessingQueue = true;

    while (_cartApiQueue.isNotEmpty) {
      final job = _cartApiQueue.first;
      try {
        final res = await _cartRepo.addRemoveCartRepo({
          "user_id": await MySharedPreferences.getUserId(),
          "product_id": job["productId"],
          "type": job["type"]
        });

        if (res['status'] == true) {
          _cartApiQueue.removeAt(0);
        } else {
          // Retry after delay if failed
          await Future.delayed(Duration(seconds: 2));
        }
      } catch (e) {
        print("Cart API error: $e, retrying...");
        await Future.delayed(Duration(seconds: 2));
      }
    }
    _isProcessingQueue = false;
  }

  SearchItemModel seaItemRes = SearchItemModel();
  UserProfileModel usrProfileRes = UserProfileModel();
  TextEditingController mobileController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  toggleWishlist(context,Products product){
    product.wishlistStatus = product.wishlistStatus == '1' ? '0' : '1';
    notifyListeners();
    print('productId----------${product.id}');
    Provider.of<CartViewModel>(context, listen: false)
        .getFevUnFavApi(productID: product.id.toString());
  }

  void initSearchPagination(BuildContext context, String query) {
    searchScrollController.addListener(() {
      if (searchScrollController.position.pixels >=
          searchScrollController.position.maxScrollExtent - 100) {
        searchItemApi(
          context,
          searchQuery: query,
          loadMore: true,
        );
      }
    });
  }


  Future<void>userProfileApi(BuildContext context) async {
    final getUserId = await MySharedPreferences.getUserId();
    dynamic data = {
      "user_id":getUserId??'',
    };
    print('--------${data}');
    // isLoading = true;
    // notifyListeners();
    try {
      usrProfileRes = await _myRepo.getUserProfileRepo(context, data);
      await MySharedPreferences.setUserMobileNUmberId(usrProfileRes.userProfile?.mobileNo??'');
      await MySharedPreferences.setUserWalletAmt(usrProfileRes.userProfile?.walletBalance??'');
    } catch (error) {
      print("Home API error: $error");
    } finally {
      // isLoading = false;
      // hasLoadedOnce = true;
      notifyListeners();
    }
  }
  bool isLoadMore = false;

  int offset = 0;
  final int limit = 15;
  ScrollController searchScrollController = ScrollController();
  Future<void> searchItemApi(
      BuildContext context, {
        String? searchQuery,
        bool loadMore = false,
      }) async {

    final getUserId = await MySharedPreferences.getUserId();
    isLoading = true;
    if (!loadMore) {
      offset = 0;
      hasMore = true;
      seaItemRes.data?.productsList?.clear();
    } else {
      if (!hasMore || isLoadMore) return;
      isLoadMore = true;
    }

    notifyListeners();
    dynamic data = {
      "user_id": getUserId ?? '',
      "products_text": searchQuery ?? '',
      "offset": offset.toString(),
      "limit":limit,
    };
    print('SearchReqData-------------${data}');
    try {
      final response = await _myRepo.searchItemRepo(context, data);
      final newProducts = response.data?.productsList ?? [];
      if (loadMore) {
        seaItemRes.data?.productsList?.addAll(newProducts);
      } else {
        seaItemRes = response;
      }
      hasMore = newProducts.length == limit;
      offset += limit;
    } catch (error) {
      debugPrint("Search API error: $error");
    } finally {
      isLoading = false;
      isLoadMore = false;
      notifyListeners();
    }
  }

  String get totalCartQty {
    return userHomeRes.data?.totalCartQty.toString()??'';
  }

  // ✅ Update cart quantity live
  // void updateCartQty(String qty) {
  //   userHomeRes = userHomeRes.copyWith(
  //     data: userHomeRes.data?.copyWith(
  //       totalCartQty: qty,
  //     ),
  //   );
  //   notifyListeners();
  // }
}