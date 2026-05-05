
import 'package:uday_bharat/user_screen/provider/model/get_all_category_model.dart';
import 'package:uday_bharat/user_screen/provider/model/my_order_model.dart';
import 'package:uday_bharat/user_screen/provider/model/order_detail_model.dart';
import 'package:uday_bharat/user_screen/provider/model/product_detail_model.dart';
import 'package:uday_bharat/user_screen/provider/model/subcategory_model.dart';
import '../../../data/app_url.dart';
import '../../../data/network/baseapi_services.dart';
import '../../../data/network/network_api_services.dart';
class CategoryRepository {
  final BaseApiServices _baseApiServices = NetworkApiServices();
  Future<dynamic> getCategoryRepo(dynamic data) async {
    try {
      dynamic response =
      await _baseApiServices.getPostApiResponse(AppUrl.usrCategoryUrl, data);
      return SubcategoryModel.fromJson(response);
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  Future<dynamic> getProductDetailRepo(dynamic data) async {
    try {
      dynamic response =
      await _baseApiServices.getPostApiResponse(AppUrl.usrProductDetailUrl, data);
      return ProductDetailModel.fromJson(response);
    } catch (e) {
      throw Exception(e.toString());
    }
  }




  Future<dynamic> getAllCategoryRepo(dynamic data) async {
    try {
      dynamic response =
      await _baseApiServices.getPostApiResponse(AppUrl.usrAllCategoryUrl, data);
      return GetAllCategoryModel.fromJson(response);
    } catch (e) {
      throw Exception(e.toString());
    }
  }



  Future<dynamic> getMyOrderListRepo(dynamic data) async {
    try {
      dynamic response =
      await _baseApiServices.getPostApiResponse(AppUrl.usrOrderListUrl, data);
      return MyOrderModel.fromJson(response);
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  Future<dynamic> getOrderDetailRepo(dynamic data) async {
    try {
      dynamic response =
      await _baseApiServices.getPostApiResponse(AppUrl.usrOrderDetailUrl, data);
      return OrderDetailModel.fromJson(response);
    } catch (e) {
      throw Exception(e.toString());
    }
  }


}
