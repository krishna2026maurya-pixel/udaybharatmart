import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uday_bharat/utils/session.dart';
import 'package:uday_bharat/utils/toast_msg.dart';
import 'package:uday_bharat/vendor_screen/vendor_provider/model/get_business_type_model.dart';
import 'package:uday_bharat/vendor_screen/vendor_provider/model/shop_category_model.dart';
import 'package:uday_bharat/vendor_screen/vendor_provider/model/vendor_profile_model.dart';
import 'package:uday_bharat/vendor_screen/vendor_provider/repository/profile_repo.dart';

import '../../../data/checkStatus.dart';
class ProfileViewModel extends ChangeNotifier {
  final _myRepo = VendorProfileRepository();
  GetBusinessTypeModel getBusinessTypeRes = GetBusinessTypeModel();
  ShopCategoryModel getShopCategoryRes = ShopCategoryModel();
  VendorProfileModel getProfileRes = VendorProfileModel();
  bool isLoading = false;
  bool isUpDateLoading = false;
  bool isRegLoading = false;
  bool isLocationLoading = false;
  final shopNameController = TextEditingController();
  final ownerNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();
  final descriptionController = TextEditingController();
  final gstNumberController = TextEditingController();
  final panNumberController = TextEditingController();
  final aadhaarNumberController = TextEditingController();
  File? shopImage;
  File? backAadhaar;
  File? frontAadhaar;
  final picker = ImagePicker();
  String? currentAddress;
  bool useCurrentLocation = false;
  String? getLatitude;
  String? getLongitude;
  String? getVendorId;
  String? setCity;
  String? setState;
  String? setPinCode;
  double serviceRadius = 10;
  final double maxRadius = 50;
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
      setCity = place.locality ?? '';
      setState = place.administrativeArea ?? '';
      setPinCode = place.postalCode ?? '';
      currentAddress =
      "${place.name}, ${place.street}, ${place.subLocality}, ${place.locality}, "
          "${place.administrativeArea}, ${place.postalCode}, ${place.country}";
      addressController.text = currentAddress ?? '';
      // cityCtrl.text = place.locality ?? '';
      // stateCtrl.text = place.administrativeArea ?? '';
      // pinCtrl.text = place.postalCode ?? '';
      notifyListeners();
    } catch (e) {
      currentAddress = "Error getting location: $e";
      notifyListeners();
    } finally {
      isLocationLoading = false;
      notifyListeners();
    }
  }



  File? shopLogo;
  File? aadhaarFrontImage;
  File? aadhaarBackImage;
  File? gstImage;
  File? panCardImage;

  Future<void> pickUpdateImage(String status) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      if (status=='logo') {
        shopLogo = File(picked.path);
        notifyListeners();
      } else if(status=='front'){
        aadhaarFrontImage = File(picked.path);
        notifyListeners();
      }else if (status=='back'){
        aadhaarBackImage = File(picked.path);
        notifyListeners();
      }else if (status=='pan_card'){
        panCardImage = File(picked.path);
        notifyListeners();
      }else if (status=='gst'){
        gstImage = File(picked.path);
        notifyListeners();
      }
    }
  }

  void setVendorProfile (){
    shopNameController.text = getProfileRes.data?.shopName ?? '';
    ownerNameController.text = getProfileRes.data?.fullName ?? '';
    emailController.text = getProfileRes.data?.email ?? '';
    phoneController.text = getProfileRes.data?.mobileNumber ?? '';
    addressController.text = getProfileRes.data?.gpsLocation ?? '';
     gstNumberController.text = getProfileRes.data?.gstNumber ?? '';
     panNumberController.text =  getProfileRes.data?.panNumber ?? '';
     aadhaarNumberController.text = getProfileRes.data?.licenceNumber ?? '';
     passwordController.text = getProfileRes.data?.password ?? '';
    // descriptionController.text = getProfileRes.data?. ?? '';
    serviceRadius = double.parse(getProfileRes.data?.servicesCoverage ?? '10');
    getLatitude = getProfileRes.data?.gpsLat ?? '';
    getLongitude = getProfileRes.data?.gpsLong ?? '';
    notifyListeners();
  }
  Future<void> getVendorProfileApi(BuildContext context) async {
    final vendorId = await MySharedPreferences.getVendorId();
    isLoading = true;
    notifyListeners();
    dynamic data = {
      "vendor_id": vendorId,
    };
    try {
      getProfileRes =   await _myRepo.getVendorProfileRepo(context, data);
      setVendorProfile ();
    } catch (error) {
      print(error);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


  Future<void> vendorUpdateProfileApi(BuildContext context,{String?currentIndex}) async {
    isUpDateLoading = true;
    notifyListeners();
    final vendorId = await MySharedPreferences.getVendorId();
    dynamic data = {
      "full_name": ownerNameController.text.toString(),
      "email": '@gmail.com',
      "vendor_id": vendorId,
      "mobile_number": phoneController.text,
      "shop_name": shopNameController.text,
      // "shop_category": categoryCtrl.text,
      "business_type": '',
      "gps_lat": getLatitude,
      "gps_long":getLongitude,
      "gst_number": gstNumberController.text,
      "pan_number": panNumberController.text,
      "licence_number": aadhaarNumberController.text,
      "gps_location": addressController.text,
      "password": passwordController.text,
      "country": 'india',
      "state":setState ,
      "city": setCity,
      "pincode": setPinCode,
      "landmark": '',
      "services_coverage": serviceRadius,
      "vendor_id": vendorId,
    };
    dynamic file = {
      if (shopImage != null) "shop_image": shopImage!,
      if (frontAadhaar != null) "aadhar_front": frontAadhaar!,
      if (backAadhaar != null) "aadhar_back": backAadhaar!,
      if (panCardImage != null) "pan_card": panCardImage!,
      if (gstImage != null) "gst_certificate": gstImage!,
    };
    print(file);
    print(data);
    try {
     await _myRepo.getVendorUpdateProfileRepo(context, data,file);
      notifyListeners();
      if(ApiStatus.status==true){
        frontAadhaar=null;
        shopImage=null;
        backAadhaar=null;
        panCardImage=null;
        gstImage=null;
         Navigator.pop(context);
      }
    } catch (error) {
      print(error);
    } finally {
      isUpDateLoading = false;
      notifyListeners();
    }
  }


}
