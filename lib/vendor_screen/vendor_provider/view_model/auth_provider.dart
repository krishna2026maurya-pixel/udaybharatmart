import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uday_bharat/data/checkStatus.dart';
import 'package:uday_bharat/utils/session.dart';
import 'package:uday_bharat/utils/toast_msg.dart';
import 'package:uday_bharat/vendor_screen/auth/login.dart';
import 'package:uday_bharat/vendor_screen/vendor_provider/model/get_business_type_model.dart';
import 'package:uday_bharat/vendor_screen/vendor_provider/model/shop_category_model.dart';
import 'package:uday_bharat/vendor_screen/vendor_provider/repository/auth_repo.dart';
import '../../dashboard/vendor_dashboard.dart';
class VendorAuthProvider extends ChangeNotifier {
  final _myRepo = VendorAuthRepository();
  GetBusinessTypeModel getBusinessTypeRes = GetBusinessTypeModel();
  ShopCategoryModel getShopCategoryRes = ShopCategoryModel();
  bool isLoading = false;
  bool isRegLoading = false;
  bool isLocationLoading = false;
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final mobileCtrl = TextEditingController();
  final shopNameCtrl = TextEditingController();
  final gstCtrl = TextEditingController();
  final panCtrl = TextEditingController();
  final licenceCtrl = TextEditingController();
  final categoryCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final cityCtrl = TextEditingController();
  final pinCtrl = TextEditingController();
  final stateCtrl = TextEditingController();
  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confirmPasswordCtrl = TextEditingController();
  File? shopImage;
  File? backAadhaar;
  File? frontAadhaar;
  final picker = ImagePicker();
  String? currentAddress;
  bool useCurrentLocation = false;
  String? getLatitude;
  String? getLongitude;
  String? getVendorId;
  double serviceRadius = 3;
  final double maxRadius = 8;
  void setLatitude(String value) {
    getLatitude = value;
    notifyListeners();
  }
  void setLongitude(String value) {
    getLongitude = value;
    notifyListeners();
  }
  void  setServiceRadius(double value) {
    serviceRadius = value;
    notifyListeners();
  }
    void setUseCurrentLocation(bool value) {
    useCurrentLocation = value;
    notifyListeners();
  }

  Future<void> pickImage(String? isShopImage) async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      if (isShopImage=='shopImage') {
        shopImage = File(picked.path);
        notifyListeners();
      } else if(isShopImage=='backAadhaar') {
        backAadhaar = File(picked.path);
        notifyListeners();
      }else{
        frontAadhaar = File(picked.path);
        notifyListeners();
      }
    }
  }
  Future<void> getCurrentLocation() async {
    isLocationLoading = true;
    notifyListeners();
    try {
      // Check and request permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        currentAddress = "Location permission denied";
        isLocationLoading = false;
        notifyListeners();
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Convert coordinates to address
      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);
      getLongitude = position.longitude.toString();
      getLatitude = position.latitude.toString();
      Placemark place = placemarks.first;
      currentAddress =
      "${place.name}, ${place.street}, ${place.subLocality}, ${place.locality}, "
          "${place.administrativeArea}, ${place.postalCode}, ${place.country}";
      addressCtrl.text = currentAddress ?? '';
      cityCtrl.text = place.locality ?? '';
      stateCtrl.text = place.administrativeArea ?? '';
      pinCtrl.text = place.postalCode ?? '';
      notifyListeners();
    } catch (e) {
      currentAddress = "Error getting location: $e";
      notifyListeners();
    } finally {
      isLocationLoading = false;
      notifyListeners();
    }
  }
  String? setVendorId;
  Future<void> vendorRegistrationApi(BuildContext context,{String?currentIndex}) async {
    isRegLoading = true;
    notifyListeners();
    final vendorId = await MySharedPreferences.getVendorId();
    final token = await MySharedPreferences.getFcmToken();
    dynamic data = {
      "full_name": nameCtrl.text.toString(),
      "fiberbase_token": token,
      "email": emailCtrl.text.toString(),
      "mobile_number": mobileCtrl.text.toString(),
      "password": passwordCtrl.text.toString(),
      "shop_name": shopNameCtrl.text,
      // "shop_category": categoryCtrl.text,
      "business_type": businessTypeCtrl.text,
      "gps_lat": getLatitude,
      "gps_long":getLongitude,
      "gst_number": gstCtrl.text,
      "pan_number": panCtrl.text,
      "licence_number": licenceCtrl.text,
      "gps_location": addressCtrl.text,
      "country": 'india',
      "state":stateCtrl.text ,
      "city": cityCtrl.text,
      "pincode": pinCtrl.text,
      "landmark": '',
      "services_coverage": serviceRadius,
     // "vendor_id": setVendorId,
    };
    dynamic file = {
      if (shopImage != null) "shop_image": shopImage!,
      if (frontAadhaar != null) "aadhar_front": frontAadhaar!,
      if (backAadhaar != null) "aadhar_back": backAadhaar!,
    };
    print(file);
    print(data);
    try {
    final response =  await _myRepo.getVendorRegistrationRepo(context, data,file);
    // getVendorId = response['data']['id'];
    ApiStatus.status = response['status'];
    if(response['status']==false){
      Utils.toastMessage(response['message']);
    }

   print('>>>>>>>>>>>>>>>>>>status:${response['status']}');
   print('>>>>>>>>>>>>>>>>>>vendor_id:${response['vendor_id']}');

    notifyListeners();
     if(ApiStatus.status==true){
       isRegLoading = false;
       setVendorId = response['vendor_id'].toString();
       notifyListeners();
       if(currentIndex=='1'){
         await  MySharedPreferences.setVendorId(setVendorId.toString());
         Navigator.push(context, MaterialPageRoute(builder:  (context) => vendorDashBoardScreen()));
       }
     }
    } catch (error) {
      print(error);
    } finally {
      isRegLoading = false;
      notifyListeners();
    }
  }

  Future<void> vendorLoginApi(BuildContext context) async {
    if(emailCtrl.text.isEmpty){
      return Utils.toastMessage('Please enter email or phone number');
    }else if (passwordCtrl.text.isEmpty){
      return Utils.toastMessage('Please enter password');
    }
    isLoading = true;
    notifyListeners();
    dynamic data = {
      "email": emailCtrl.text,
      "password": passwordCtrl.text,
    };
    try {
     final res =  await _myRepo.vendorLoginRepo(context, data);
     print('----------------->?.>>>>>>>');
      if(res['status']==true){
        print('----------------->');
        Navigator.push(context, MaterialPageRoute(builder:  (context) => vendorDashBoardScreen()));
        isLoading = false;
        notifyListeners();
      }
    } catch (error) {
      print(error);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


  Future<void> vendorLogoutApi(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    try {
      await _myRepo.vendorLogoutRepo(context);
      if(ApiStatus.status==true){
        isLoading = false;
        notifyListeners();
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => VendorLoginScreen(),),  (Route route) => false);
      }
    } catch (error) {
      print(error);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  var selectedBusinessType;
  var selectedCategoryType;
  TextEditingController businessTypeCtrl = TextEditingController();
  Future<void> getVendorBusinessType(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    try {
   getBusinessTypeRes =    await _myRepo.getVendorBusinessType(context);
    } catch (error) {
      print(error);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  Future<void> getVendorShopCategoryType(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    try {
      getShopCategoryRes =    await _myRepo.getVendorShopCategory(context);
    } catch (error) {
      print(error);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
