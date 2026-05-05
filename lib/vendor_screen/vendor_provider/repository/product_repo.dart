import 'package:flutter/material.dart';
import 'package:uday_bharat/utils/session.dart';
import 'package:uday_bharat/utils/toast_msg.dart';
import 'package:uday_bharat/vendor_screen/vendor_provider/model/added_item_detail_model.dart';
import 'package:uday_bharat/vendor_screen/vendor_provider/model/drop_down_category_model.dart';
import 'package:uday_bharat/vendor_screen/vendor_provider/model/vendor_dashboard_model.dart';
import 'package:uday_bharat/vendor_screen/vendor_provider/model/vendor_order_list_model.dart';
import 'package:uday_bharat/vendor_screen/vendor_provider/model/vendor_product_model.dart';
import '../../../data/app_url.dart';
import '../../../data/network/baseapi_services.dart';
import '../../../data/network/network_api_services.dart';
class VendorProductRepository {
  final BaseApiServices _baseApiServices = NetworkApiServices();
  Future<dynamic> getVendorAddProductRepo(BuildContext context,dynamic data,dynamic file) async {
    try {
      dynamic response =
      await _baseApiServices.getPostApiResponse(AppUrl.vendorAddProductUrl, data,files: file);

      Utils.toastMessage("${response['message']}");
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<dynamic> getDropDownCategoryRepo(BuildContext context) async {
     dynamic  data  = {
       '': '',
     };
    try {
      dynamic response =
      await _baseApiServices.getPostApiResponse(AppUrl.getDropDownCategoryUrl,data);
      return DropDownCategoryModel.fromJson(response);
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  Future<dynamic> getVendorProductListRepo(BuildContext context) async {
    final userID = await MySharedPreferences.getVendorId();
    dynamic  data  = {
      'vendor_id': userID,
    };
    print('data---------${data}');
    try {
      dynamic response =
      await _baseApiServices.getPostApiResponse(AppUrl.getVendorProductUrl,data);
      return VendorProductModel.fromJson(response);
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  Future<dynamic> vendorProductDeleteRepo(dynamic data) async {
    try {
      dynamic response =
      await _baseApiServices.getPostApiResponse(AppUrl.getVendorProductDeleteUrl,data);
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<dynamic> vendorDashboardRepo(dynamic data) async {
    try {
      dynamic response =
      await _baseApiServices.getPostApiResponse(AppUrl.getVendorDashboardUrl,data);
      return VendorDashboardModel.fromJson(response);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<dynamic> vendorOrderListRepo(dynamic data) async {
    try {
      dynamic response =
      await _baseApiServices.getPostApiResponse(AppUrl.getVendorOrderListUrl,data);
      return VendorOrderListModel.fromJson(response);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<dynamic> vendorUpdateStatusRepo(dynamic data) async {
    try {
      dynamic response =
      await _baseApiServices.getPostApiResponse(AppUrl.getVendorUpdateStatusUrl,data);
      Utils.toastMessage(response['message']);
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  Future<dynamic> vendorAddedItemDetailRepo(dynamic data) async {
    try {
      dynamic response =
      await _baseApiServices.getPostApiResponse(AppUrl.getVendorProductBYIdUrl,data);
      return AddedItemDetailModel.fromJson(response);
    } catch (e) {
      throw Exception(e.toString());
    }
  }



}


