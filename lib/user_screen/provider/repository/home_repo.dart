import 'package:flutter/material.dart';
import 'package:uday_bharat/user_screen/provider/model/search_item_model.dart';
import 'package:uday_bharat/user_screen/provider/model/user_profile_model.dart';
import '../../../data/app_url.dart';
import '../../../data/network/baseapi_services.dart';
import '../../../data/network/network_api_services.dart';
import '../model/home_page_model.dart';
class HomeRepository {
  final BaseApiServices _baseApiServices = NetworkApiServices();
  Future<dynamic> getHomeRepo(BuildContext context,dynamic data) async {
    try {
      dynamic response =
      await _baseApiServices.getPostApiResponse(AppUrl.usrHomeUrl, data);
      return response is Map<String, dynamic>
          ? HomePageModel.fromJson(response)
          : HomePageModel();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<dynamic> getUserProfileRepo(BuildContext context,dynamic data) async {
    try {
      dynamic response =
      await _baseApiServices.getPostApiResponse(AppUrl.usrProfileUrl, data);
      return  UserProfileModel.fromJson(response);
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  Future<dynamic> searchItemRepo(BuildContext context,dynamic data) async {
    try {
      dynamic response =
      await _baseApiServices.getPostApiResponse(AppUrl.usrSarchItemUrl, data);
      return  SearchItemModel.fromJson(response);
    } catch (e) {
      throw Exception(e.toString());
    }
  }



}
