import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uday_bharat/user_screen/provider/model/get_all_category_model.dart';
import 'package:uday_bharat/user_screen/provider/model/my_order_model.dart';
import 'package:uday_bharat/user_screen/provider/model/order_detail_model.dart';
import 'package:uday_bharat/user_screen/provider/model/product_detail_model.dart';
import 'package:uday_bharat/user_screen/provider/model/subcategory_model.dart';
import 'package:uday_bharat/user_screen/provider/repository/category_repo.dart';
import 'package:uday_bharat/utils/session.dart';

import '../../../location_service/location_provider.dart';
import 'cart_view_model.dart';
class CategoryViewModel extends ChangeNotifier {
  final _myRepo = CategoryRepository();
  SubcategoryModel subcategoryRes = SubcategoryModel();
  ProductDetailModel productDetailRes = ProductDetailModel();
  GetAllCategoryModel getAllCatRes = GetAllCategoryModel();
  MyOrderModel getMyOrderListRes = MyOrderModel();
  OrderDetailModel getOrderDetailRes = OrderDetailModel();
  bool isLoading = false;
  bool isMyOrderLoading = false;

  ScrollController productScrollController = ScrollController();

  int offset = 0;
  int limit = 16;
  bool isLoadMoreLoading = false;
  bool hasMoreData = true;

  String selectedSubcategoryId = '0';

  // void initPagination(BuildContext context, String catId) {
  //   productScrollController.addListener(() {
  //     if (productScrollController.position.pixels >=
  //         productScrollController.position.maxScrollExtent - 200 &&
  //         !isLoadMoreLoading &&
  //         hasMoreData &&
  //         !isLoading) {
  //       loadMore(context, catId);
  //     }
  //   });
  // }
  void initPagination(BuildContext context, String catId) {

    productScrollController = ScrollController();

    productScrollController.addListener(() {

      if (productScrollController.position.pixels >=
          productScrollController.position.maxScrollExtent - 100) {

        if (hasMoreData && !isLoadMoreLoading && !isLoading) {

          getCategoryApi(
            context,
            catId,
            isLoadMore: true,
          );
        }
      }
    });
  }


  Future<void> loadMore(BuildContext context, String catId) async {
    if (isLoadMoreLoading || !hasMoreData) return;

    isLoadMoreLoading = true;
    notifyListeners();

    await getCategoryApi(
      context,
      catId,
      isLoadMore: true,
      subcategoryId: selectedSubcategoryId,
    );
  }


  Future<void> getCategoryApi(
      BuildContext context,
      String catId, {
        bool isLoadMore = false,
        String? subcategoryId,
      }) async {
    // ✅ Prevent multiple load-more calls
    if (isLoadMore && isLoadMoreLoading) return;

    if (isLoadMore) {
      isLoadMoreLoading = true;
    }

    if (!isLoadMore) {
      offset = 0;
      hasMoreData = true;
      selectedSubcategoryId = subcategoryId ?? '0';
      isLoading = true;
      notifyListeners();
    }

    final userId = await MySharedPreferences.getUserId();

    final data = {
      'category_id': catId,
      'subcategory_id': selectedSubcategoryId,
      'offset': offset.toString(),
      'limit': limit.toString(),
      'user_id': userId,
    };
    print('subcategoryData-------------------->${data}');

    try {
      final response = await _myRepo.getCategoryRepo(data);
      final newProducts = response.data?.products ?? [];
      if (isLoadMore) {

        // LOAD MORE CASE
        subcategoryRes.data?.products?.addAll(newProducts);

      } else {

        // FIRST LOAD / SUBCATEGORY CHANGE
        subcategoryRes = response;

        // IMPORTANT: clear old list reference
        subcategoryRes.data?.products = List.from(newProducts);

      }



      // ✅ OFFSET UPDATE AFTER SUCCESS
      if (newProducts.isEmpty) {
        hasMoreData = false;
        print(
            'LOAD MORE | offset=$offset | hasMore=$hasMoreData | loading=$isLoadMoreLoading'
        );

      } else {
        offset += limit;
        print(
            'LOAD MORE | offset=$offset | hasMore=$hasMoreData | loading=$isLoadMoreLoading'
        );

      }

    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
      isLoadMoreLoading = false;
      notifyListeners();
    }
  }



  // Future<void> getCategoryApi(context,String catId) async {
  //   isLoading = true;
  //   notifyListeners();
  //   final userId = await MySharedPreferences.getUserId();
  //   print('catId-----------${catId}');
  //   dynamic  data = {
  //     'category_id': '${catId}',
  //      'user_id':userId,
  //   };
  //   print('getCategoryApi----------->${data}');
  //   try {
  //     subcategoryRes=   await _myRepo.getCategoryRepo(data);
  //   } catch (error) {
  //     print(error);
  //   } finally {
  //     isLoading = false;
  //     notifyListeners();
  //   }
  // }

  toggleSubcategory(context,Products product){
    product.wishlistStatus = product.wishlistStatus == '1' ? '0' : '1';
    notifyListeners();
    print('productId----------${product.id}');
    Provider.of<CartViewModel>(context, listen: false)
        .getFevUnFavApi(productID: product.id.toString());
  }

  void clearProductDetail() {
    productDetailRes = ProductDetailModel();
    notifyListeners();
  }
  final Map<String, dynamic> productDetailCache = {};

  Future<void> getProductDetailApi(context, String itemId) async {
    final getLocationProvider =
    Provider.of<LocationProvider>(context, listen: false);

    // 👉 CACHE CHECK (No API call if already loaded)
    if (productDetailCache.containsKey(itemId)) {
      productDetailRes = productDetailCache[itemId];
      notifyListeners();
      return;
    }

    isLoading = true;
    notifyListeners();

    final userId = await MySharedPreferences.getUserId();

    dynamic data = {
      'product_id': itemId,
      'user_id': userId,
      'user_gps_lat': getLocationProvider.latitude.toString(),
      'user_gps_long': getLocationProvider.longitude.toString()
    };

    try {
      final res = await _myRepo.getProductDetailRepo(data);

      /// 👉 SAVE TO CACHE
      productDetailCache[itemId] = res;
      productDetailRes = res;

    } catch (error) {
      print(error);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


  bool hasLoadOnce = false;
  Future<void> getAllCategoryApi(BuildContext context) async {
    if (hasLoadOnce) return;

    isLoading = true;
    notifyListeners();

    final getLocationProvider = Provider.of<LocationProvider>(context, listen: false);
    final userId = await MySharedPreferences.getUserId();
    dynamic data = {
      'user_id': userId,
      'user_gps_lat': getLocationProvider.latitude.toString(),
      'user_gps_long': getLocationProvider.longitude.toString()
    };

    try {
      getAllCatRes = await _myRepo.getAllCategoryRepo(data);
      hasLoadOnce = true;
    } catch (error) {
      print(error);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


  Future<void> getMyOrderApi(BuildContext context) async {
    isMyOrderLoading = true;
    notifyListeners();
    final userId = await MySharedPreferences.getUserId();
    dynamic  data = {
      'user_id':userId,
    };
    try {
      getMyOrderListRes=   await _myRepo.getMyOrderListRepo(data);
    } catch (error) {
      print(error);
    } finally {
      isMyOrderLoading = false;
      notifyListeners();
    }
  }

  Future<void> getOrderDetailApi(BuildContext context,{String?orderId}) async {
    isLoading = true;
    notifyListeners();
    dynamic  data = {
      'order_id':orderId,
    };
    print('req------>${data}');
    try {
      getOrderDetailRes=   await _myRepo.getOrderDetailRepo(data);
    } catch (error) {
      print(error);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
// toggleItemDetailWishlist(context,Products product){
//   product.wishListStatus = product.wishListStatus == 1 ? 0 : 1;
//   notifyListeners(); // Refresh UI immediately
//   print('productId----------${product.id}');
//   Provider.of<CartViewModel>(context, listen: false)
//       .getFevUnFavApi(productID: product.id.toString());
// }
}