import 'package:flutter/material.dart';
import 'package:uday_bharat/utils/toast_msg.dart';
import '../../../data/app_url.dart';
import '../../../data/network/baseapi_services.dart';
import '../../../data/network/network_api_services.dart';
class AuthRepository {
  final BaseApiServices _baseApiServices = NetworkApiServices();
  Future<dynamic> getOtpRepo(BuildContext context,dynamic data) async {
    try {
      dynamic response =
      await _baseApiServices.getPostApiResponse(AppUrl.userLoginUrl, data);
      // Utils.toastMessage("${response['message']}/OTP:${response['OTP']}");
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  Future<dynamic> verifyOtpRepo(BuildContext context,dynamic data) async {
    try {
      dynamic response =
      await _baseApiServices.getPostApiResponse(AppUrl.userVerifyOtp, data);

      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }




}
