import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:uday_bharat/data/checkStatus.dart';
import 'package:uday_bharat/main.dart';
import 'package:uday_bharat/user_screen/dashborad/dashboard.dart';
import 'package:uday_bharat/user_screen/provider/model/coupon_model.dart'
    hide Data;
import 'package:uday_bharat/user_screen/provider/model/get_cart_model.dart';
import 'package:uday_bharat/user_screen/provider/model/get_checkout_model.dart'
    hide UserAddressList;
import 'package:uday_bharat/user_screen/provider/model/get_user_wishlist_model.dart';
import 'package:uday_bharat/user_screen/provider/view_model/home_provider.dart';
import 'package:uday_bharat/utils/custom_button.dart';
import 'package:uday_bharat/utils/cutom_text.dart';
import 'package:uday_bharat/utils/session.dart';
import 'package:uday_bharat/utils/toast_msg.dart';
import '../../dashborad/cart/order_place_dilogue.dart';
import '../../widgets/cart_button_widget.dart';
import '../repository/cart_repository.dart';
import 'cart_local_provider.dart';
import 'category_view_model.dart';

class CartViewModel extends ChangeNotifier {
  final _myRepo = CartRepository();
  bool isLoading = false;
  bool isCreateBookingLoading = false;
  GetCartModel getCartRes = GetCartModel();
  CouponModel getCouponRes = CouponModel();
  GetCheckoutModel getCheckOutRes = GetCheckoutModel();
  GetUserWishlistModel getWishListRes = GetUserWishlistModel();
  String? selectedAddress;
  String? selectedAddressId;

  void setDefaultAddressIfNeeded(List<UserAddressList> allAddresses) {
    if (allAddresses == null || allAddresses.isEmpty) return;

    // Already selected? then skip
    if (selectedAddress != null &&
        selectedAddress!.isNotEmpty &&
        selectedAddressId != null) {
      return;
    }

    // Find default address
    UserAddressList defaultAddr = allAddresses.firstWhere(
      (e) => e.isDefault == "1",
      orElse: () => allAddresses.first,
    );

    selectedAddress = defaultAddr.gpsAddress ?? '';
    selectedAddressId = defaultAddr.id?.toString() ?? '';

    debugPrint("DEFAULT ADDRESS SET => $selectedAddress");

    notifyListeners();
  }

  void setSelectedAddress({String? address, String? addressId}) {
    selectedAddress = address;
    selectedAddressId = addressId;
    print(selectedAddress);
    notifyListeners();
  }

  String? selectedUserName;
  String? selectedUserNumber;

  String selectedPaymentMethod = "COD";
  bool isWalletApply = false;

  bool showCouponAnimation = false;
  void triggerCouponAnimation() {
    showCouponAnimation = true;
    notifyListeners();

    Future.delayed(Duration(seconds: 2), () {
      showCouponAnimation = false;
      notifyListeners();
    });
  }

  void setIsWallet(bool? isWallet) {
    isWalletApply = isWallet!;
    notifyListeners();
  }

  void setPaymentMethod(String method) {
    selectedPaymentMethod = method;
    notifyListeners();
  }

  toggleWishlist(context, Wishlist product) {
    product.isWishlist = product.isWishlist == '1' ? '0' : '1';
    notifyListeners(); // Refresh UI immediately
    print('productId----------${product.productId}');
    Provider.of<CartViewModel>(
      context,
      listen: false,
    ).getFevUnFavApi(productID: product.productId.toString());
    getUserWishlistApi(productID: product.productId.toString());
    notifyListeners();
  }

  Future<void> addRemoveCartApi(
    BuildContext context, {
    String? productId,
    String? detailProductId,
    String? type,
    String? status,
  }) async {
    isLoading = true;
    notifyListeners();
    final userId = await MySharedPreferences.getUserId();
    dynamic data = {'user_id': userId, 'product_id': productId, 'type': type};
    print('CartRequestData:----------:${data}');
    print('----------${status}');
    try {
      final res = await _myRepo.addRemoveCartRepo(data);
      if (res['status'] == true) {
        log('>>>>>>>>>>>>>>>>${res}');
        if (status == 'home') {
          await Provider.of<HomeProvider>(
            context,
            listen: false,
          ).homeApi(context);
        } else if (status == 'cart') {
          await getCartApi(context);
        } else if (status?.trim() == 'item_detail') {
          print('===========>> Item Detail Triggered');
          print('DETAIL PRODUCT ID: $detailProductId');
          final catVM = Provider.of<CategoryViewModel>(context, listen: false);
          catVM.productDetailCache.remove(detailProductId);
          await catVM.getProductDetailApi(context, detailProductId!);
        }
      }
    } catch (error) {
      print(error);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getCartApi(
    BuildContext context, {
    String? coupon,
    String? isWallet,
  }) async {
    isLoading = true;
    notifyListeners();

    final userId = await MySharedPreferences.getUserId();
    dynamic data = {
      'user_id': userId,
      'coupon_code': coupon,
      'is_wallet_apply': isWallet,
    };
    try {
      getCartRes = await _myRepo.getCartRepo(data);
      getCartRes.data?.cartItemsList?.removeWhere((item) {
        return int.tryParse(item.cartQty ?? "0") == 0;
      });
      final cartLocal = Provider.of<CartLocalProvider>(context, listen: false);
      print(getCartRes.data?.walletMessage);
      if (getCartRes.data == null ||
          getCartRes.data?.cartItemsList == null ||
          getCartRes.data!.cartItemsList!.isEmpty) {
        cartLocal.clearCart();
      }
      if (getCartRes.data?.couponApplyStatus == '1') {
        triggerCouponAnimation();
      }
      final addressList = getCartRes.data?.userAddressList;
      if (addressList != null && addressList.isNotEmpty) {
        setDefaultAddressIfNeeded(addressList);
      }
    } catch (error) {
      print(error);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getCouponApi() async {
    isLoading = true;
    notifyListeners();
    final userId = await MySharedPreferences.getUserId();
    dynamic data = {'user_id': userId};
    try {
      getCouponRes = await _myRepo.getCouponRepo(data);
    } catch (error) {
      print(error);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getCheckoutApi() async {
    isLoading = true;
    notifyListeners();
    final userid = await MySharedPreferences.getUserId();
    print('============userId${userid}');
    dynamic data = {'user_id': userid};
    print('DATA:${data}');
    try {
      getCheckOutRes = await _myRepo.getCheckoutRepo(data);
    } catch (error) {
      print(error);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createBookingApi(
    context, {
    required String userAddressId,
    required String paymentMethod,
    required String transactionId,
    required String netGrandTotal,
    required String deliveryCharge,
    required String discountValue,
    required String walletAppliedAmount,
    required String couponCode,
    required String isSchedule,
    required String scheduledAt,
  }) async {
    isCreateBookingLoading = true;
    notifyListeners();
    final userId = await MySharedPreferences.getUserId();
    final cartItems = getCartRes.data?.cartItemsList ?? [];
    List<Map<String, dynamic>> itemsList = cartItems.map((item) {
      return {
        "cart_id": item.cartId.toString(),
        "id": item.id.toString(),
        "vendor_id": item.vendorId.toString(),
        "product_name": item.productName.toString(),
        "category_name": item.categoryName.toString(),
        "sub_category_name": item.subCategoryName.toString(),
        "product_images": item.productImage.toString(), // ← BACKEND KEY
        "brand": item.brand ?? "",
        "brand_name": item.brandName ?? "",
        "product_label": item.productLabel ?? "",
        "quantity": item.quantity.toString(), // ← YES (not cartQty)
        "volume": item.volume.toString(), // ← YES
        "add_info_title": item.addInfoTitle.toString(),
        "add_info_desc": item.addInfoDesc.toString(),
        "stock_status": item.stockStatus.toString(),
        "mrp": item.mrp.toString(),
        "selling_price": item.sellingPrice.toString(),
        "gst": item.gst.toString(),
        "total_amt": item.totalAmt.toString(), // ← REQUIRED
        "cart_qty": item.cartQty.toString(), // ← REQUIRED
        "orginal_product_amt": item.orginalProductAmt.toString(),
      };
    }).toList();
    print('CartItemList------${itemsList}');
    final data = {
      'user_id': userId.toString(),
      'user_address_id': userAddressId.toString(),
      'payment_method': paymentMethod,
      'transaction_id': transactionId ?? '',
      'net_grand_total': netGrandTotal,
      'delivery_charge': deliveryCharge,
      'discount_value': discountValue,
      'wallet_applied_amount': walletAppliedAmount,
      'coupon_code': couponCode,
      'cart_items_list': itemsList,
      'is_scheduled': isSchedule,
      'scheduled_at': scheduledAt,
    };
    print('createBookingDataItemsList--------->${itemsList}');
    print('createBookingData>>--------->${data}');
    try {
      final res = await _myRepo.createBookingRepo(data);
      if (ApiStatus.status == true) {
        await showSuccessDialog(context, orderId: res['order_number']);
        print('createBookingData>>--------$res');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
        final cartLocal = Provider.of<CartLocalProvider>(
          context,
          listen: false,
        );
        cartLocal.clearCart();
        Provider.of<HomeProvider>(context, listen: false).homeApi(context);
        Provider.of<HomeProvider>(
          context,
          listen: false,
        ).userProfileApi(context);
        // getCartApi();
      } else {
        Utils.toastMessage(res['message']);
      }
    } catch (error) {
      print("❌ Booking Error: $error");
    } finally {
      isCreateBookingLoading = false;
      notifyListeners();
    }
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController houseNoController = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();

  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  String selectedAddressType = "Home";
  String? areaController;
  String? street;

  Future<void> addUpdateAddressApi(context, {String? lat, String? long}) async {
    final userId = await MySharedPreferences.getUserId();
    if (nameController.text.isEmpty) {
      Utils.toastMessage('Please enter name');
      return;
    }
    if (phoneController.text.isEmpty) {
      Utils.toastMessage('Please enter phone number');
      return;
    }
    if (addressController.text.isEmpty) {
      Utils.toastMessage('Please enter address');
      return;
    }
    if (cityController.text.isEmpty) {
      Utils.toastMessage('Please enter city');
      return;
    }
    if (stateController.text.isEmpty) {
      Utils.toastMessage('Please enter state');
      return;
    }
    isLoading = true;
    notifyListeners();
    dynamic data = {
      'user_id': userId,
      'address_name': nameController.text,
      'address_mobile_number': phoneController.text,
      'house_apartment_no': '',
      'street': street,
      'area': areaController,
      'city': cityController.text,
      'state': stateController.text,
      'pin_code': pincodeController.text,
      'landmark': landmarkController.text,
      'gps_lat': lat,
      'gps_long': long,
      'gps_address': addressController.text,
      'address_type': selectedAddressType,
    };
    print('==========${data}');
    try {
      final res = await _myRepo.addUpdateAddressRepo(data);
      if (res['status'] == 'true') {
        await getCartApi(context);
        Navigator.pop(context);
      } else {
        Utils.toastMessage(res['message']);
      }
    } catch (error) {
      print(error);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getFevUnFavApi({String? productID}) async {
    final userId = await MySharedPreferences.getUserId();
    if (userId == '' || userId == null) {
      return showLoginPrompt(navigatorKey.currentContext!);
    }
    isLoading = true;
    notifyListeners();
    final userid = await MySharedPreferences.getUserId();
    dynamic data = {'user_id': userid, 'product_id': productID};
    print('DATA:${data}');
    try {
      await _myRepo.getFavUnFaveRepo(data);
    } catch (error) {
      print(error);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getUserWishlistApi({String? productID}) async {
    isLoading = true;
    notifyListeners();
    final userid = await MySharedPreferences.getUserId();
    dynamic data = {'user_id': userid};
    print('DATA:${data}');
    try {
      getWishListRes = await _myRepo.getWishlistRepo(data);
      print('==========${getWishListRes.wishlist?.first.productName}');
    } catch (error) {
      print(error);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
