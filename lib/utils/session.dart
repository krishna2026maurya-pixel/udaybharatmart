import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static Future<SharedPreferences> get _prefs async => SharedPreferences.getInstance();

  static Future<void> init() async {
    await _prefs;
  }

  static Future<void> setUserId(String userId) async {
    final prefs = await _prefs;
    await prefs.setString('user_idd', userId);
  }

  static Future<String?> getUserId() async {
    final prefs = await _prefs;
    return prefs.getString("user_idd");
  }

  static Future<void> setUserMobileNUmberId(String userId) async {
    final prefs = await _prefs;
    await prefs.setString('userNUmber', userId);
  }

  static Future<String?> getUserMobileNumberId() async {
    final prefs = await _prefs;
    return prefs.getString("userNUmber");
  }

  static Future<void> setUserWalletAmt(String amt) async {
    final prefs = await _prefs;
    await prefs.setString('walletAmt', amt);
  }

  static Future<String?> getUserWalletAmt() async {
    final prefs = await _prefs;
    return prefs.getString("walletAmt");
  }


  static Future<void> setFcmToken(String token) async {
    final prefs = await _prefs;
    await prefs.setString('fcmToken', token);
  }
  static Future<String?> getFcmToken() async {
    final prefs = await _prefs;
    return prefs.getString("fcmToken");
  }
  static Future<void> setVendorId(String userId) async {
    final prefs = await _prefs;
    await prefs.setString('vendor_id', userId);
  }

  static Future<String?> getVendorId() async {
    final prefs = await _prefs;
    return prefs.getString("vendor_id");
  }

  static Future<void> setToken(String token) async {
    final prefs = await _prefs;
    await prefs.setString('token', token);
  }

  // ✅ Fix: getToken() should return Future<String?>
  static Future<String?> getToken() async {
    final prefs = await _prefs;
    return prefs.getString("token");  // ✅ Return the token
  }

  static Future<void> removeUserId() async {
    final prefs = await _prefs;
    await prefs.remove('user_idd');  // ✅ No need for parameter here
  }

  static Future<bool> isUserId16() async {
    final prefs = await _prefs;
    final userId = prefs.getString('user_idd16');
    return userId == "16";
  }

}
