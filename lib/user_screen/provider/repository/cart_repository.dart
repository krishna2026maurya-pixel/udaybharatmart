import 'package:uday_bharat/user_screen/provider/model/coupon_model.dart';
import 'package:uday_bharat/user_screen/provider/model/get_cart_model.dart';
import 'package:uday_bharat/user_screen/provider/model/get_checkout_model.dart';
import 'package:uday_bharat/user_screen/provider/model/get_user_wishlist_model.dart';

import '../../../data/app_url.dart';
import '../../../data/network/baseapi_services.dart';
import '../../../data/network/network_api_services.dart';
class CartRepository {
  final BaseApiServices _baseApiServices = NetworkApiServices();
  Future<dynamic> addRemoveCartRepo(dynamic data) async {
    try {
      dynamic response =
      await _baseApiServices.getPostApiResponse(AppUrl.usrAddRemoveCartUrl, data);
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  Future<dynamic> getCartRepo(dynamic data) async {
    try {
      dynamic response =
      await _baseApiServices.getPostApiResponse(AppUrl.usrGetCartUrl, data);

      if (response is Map<String, dynamic>) {
        return GetCartModel.fromJson(response);
      }
      else if (response is List) {
        // API returned empty list → return empty model
        return GetCartModel(
          status: false,
          message: "Empty cart",
          data: null,
        );
      }
      else {
        throw Exception("Invalid API format");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }




  Future<dynamic> getCheckoutRepo(dynamic data) async {
    try {
      dynamic response =
      await _baseApiServices.getPostApiResponse(AppUrl.usrGetCheckoutUrl, data);
      return GetCheckoutModel.fromJson(response);
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  Future<dynamic> getCouponRepo(dynamic data) async {
    try {
      dynamic response =
      await _baseApiServices.getPostApiResponse(AppUrl.usrGetCouponUrl, data);
      return CouponModel.fromJson(response);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  Future<dynamic> addUpdateAddressRepo(dynamic data) async {
    try {
      dynamic response =
      await _baseApiServices.getPostApiResponse(AppUrl.usrAddUpdateUrl, data);
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  Future<dynamic> getFavUnFaveRepo(dynamic data) async {
    try {
      dynamic response =
      await _baseApiServices.getPostApiResponse(AppUrl.usrFevUnFaveUrl, data);
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  Future<dynamic> createBookingRepo(dynamic data) async {
    try {
      dynamic response =
      await _baseApiServices.getPostApiResponse(AppUrl.usrCreateBookingUrl, data);
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  Future<dynamic> getWishlistRepo(dynamic data) async {
    try {
      dynamic response =
      await _baseApiServices.getPostApiResponse(AppUrl.usrGetWishListUrl, data);
      return GetUserWishlistModel.fromJson(response);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

}
