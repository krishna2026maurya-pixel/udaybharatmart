import 'package:uday_bharat/user_screen/provider/model/user_tr_model.dart';
import '../../../data/app_url.dart';
import '../../../data/network/baseapi_services.dart';
import '../../../data/network/network_api_services.dart';
class PaymentRepository {
  final BaseApiServices _baseApiServices = NetworkApiServices();
  Future<dynamic> getWalletTransactionRepo(dynamic data) async {
    try {
      dynamic response =
      await _baseApiServices.getPostApiResponse(AppUrl.usrWalletTrUrl, data);
      return  UserTrModel.fromJson(response);
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  Future<dynamic> createTransactionRepo(dynamic data) async {
    try {
      dynamic response =
      await _baseApiServices.getPostApiResponse(AppUrl.usrCreateTrUrl, data);
      return  response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

}
