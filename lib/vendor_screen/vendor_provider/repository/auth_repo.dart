import 'package:flutter/material.dart';
import 'package:uday_bharat/utils/session.dart';
import 'package:uday_bharat/utils/toast_msg.dart';
import 'package:uday_bharat/vendor_screen/vendor_provider/model/get_business_type_model.dart';
import 'package:uday_bharat/vendor_screen/vendor_provider/model/shop_category_model.dart';
import '../../../data/app_url.dart';
import '../../../data/network/baseapi_services.dart';
import '../../../data/network/network_api_services.dart';
class VendorAuthRepository {
  final BaseApiServices _baseApiServices = NetworkApiServices();
  Future<dynamic> getVendorRegistrationRepo(BuildContext context,dynamic data,dynamic file) async {
    try {
      dynamic response =
      await _baseApiServices.getPostApiResponse(AppUrl.vendorRegisterUrl, data,files: file);
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  Future<dynamic> vendorLoginRepo(BuildContext context,dynamic data) async {
    try {
      dynamic response =
      await _baseApiServices.getPostApiResponse(AppUrl.vendorLoginUrl, data);
      Utils.toastMessage("${response['message']}");
      await MySharedPreferences.setVendorId(response['vendor_id'].toString());
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  Future<dynamic> getVendorBusinessType(BuildContext context) async {
    try {
      dynamic response =
      await _baseApiServices.getGetApiResponse(context,AppUrl.vendorBusinessTypeUrl);
      return GetBusinessTypeModel.fromJson(response);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  Future<dynamic> getVendorShopCategory(BuildContext context) async {
    try {
      dynamic response =
      await _baseApiServices.getGetApiResponse(context,AppUrl.vendorShopCategoryUrl);
      return ShopCategoryModel.fromJson(response);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  Future<dynamic> vendorLogoutRepo(BuildContext context) async {
    try {
      dynamic response =
      await _baseApiServices.getPostApiResponse(AppUrl.vendorLogoutUrl,{'':''});
      Utils.toastMessage("${response['message']}");
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
