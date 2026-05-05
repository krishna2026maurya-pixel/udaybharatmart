import 'package:flutter/material.dart';
import 'package:uday_bharat/vendor_screen/vendor_provider/model/vendor_profile_model.dart';
import '../../../data/app_url.dart';
import '../../../data/network/baseapi_services.dart';
import '../../../data/network/network_api_services.dart';
import '../../../utils/toast_msg.dart';
class VendorProfileRepository {
  final BaseApiServices _baseApiServices = NetworkApiServices();
  Future<dynamic> getVendorProfileRepo(BuildContext context,dynamic data) async {
    try {
      dynamic response =
      await _baseApiServices.getPostApiResponse(AppUrl.getVendorProfiledUrl, data);
      return VendorProfileModel.fromJson(response);
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  Future<dynamic> getVendorUpdateProfileRepo(BuildContext context,dynamic data,dynamic file) async {
    try {
      dynamic response =
      await _baseApiServices.getPostApiResponse(AppUrl.vendorRegisterUrl, data,files: file);
      Utils.toastMessage("${response['message']}");
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

}
