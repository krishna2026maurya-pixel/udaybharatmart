class VendorProfileModel {
  bool? status;
  String? message;
  Data? data;

  VendorProfileModel({this.status, this.message, this.data});

  VendorProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  dynamic? id;
  String? fullName;
  String? email;
  String? mobileNumber;
  String? shopName;
  String? shopCategory;
  String? businessType;
  String? gstNumber;
  String? panNumber;
  String? licenceNumber;
  String? password;
  String? address;
  String? country;
  String? state;
  String? city;
  String? pincode;
  String? landmark;
  String? servicesCoverage;
  String? shopImage;
  String? aadharFront;
  String? aadharBack;
  String? gpsLat;
  String? gpsLong;
  String? gpsLocation;
  String? isVerified;
  String? isBestseller;
  String? walletBalance;
  String? createdAt;
  String? updatedAt;
  String? fiberbaseToken;
  String? handlingCharge;
  String? panCard;
  String? gstCertificate;

  Data(
      {this.id,
        this.fullName,
        this.email,
        this.mobileNumber,
        this.shopName,
        this.shopCategory,
        this.businessType,
        this.gstNumber,
        this.panNumber,
        this.licenceNumber,
        this.address,
        this.country,
        this.state,
        this.password,
        this.city,
        this.pincode,
        this.landmark,
        this.servicesCoverage,
        this.shopImage,
        this.aadharFront,
        this.aadharBack,
        this.gpsLat,
        this.gpsLong,
        this.gpsLocation,
        this.isVerified,
        this.isBestseller,
        this.walletBalance,
        this.createdAt,
        this.updatedAt,
        this.fiberbaseToken,
        this.handlingCharge,
        this.panCard,
        this.gstCertificate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    shopName = json['shop_name'];
    shopCategory = json['shop_category'];
    businessType = json['business_type'];
    gstNumber = json['gst_number'];
    panNumber = json['pan_number'];
    password = json['password'];
    licenceNumber = json['licence_number'];
    address = json['address'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    pincode = json['pincode'];
    landmark = json['landmark'];
    servicesCoverage = json['services_coverage'];
    shopImage = json['shop_image'];
    aadharFront = json['aadhar_front'];
    aadharBack = json['aadhar_back'];
    gpsLat = json['gps_lat'];
    gpsLong = json['gps_long'];
    gpsLocation = json['gps_location'];
    isVerified = json['is_verified'];
    isBestseller = json['is_bestseller'];
    walletBalance = json['wallet_balance'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fiberbaseToken = json['fiberbase_token'];
    handlingCharge = json['handling_charge'];
    panCard = json['pan_card'];
    gstCertificate = json['gst_certificate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['mobile_number'] = this.mobileNumber;
    data['shop_name'] = this.shopName;
    data['shop_category'] = this.shopCategory;
    data['business_type'] = this.businessType;
    data['gst_number'] = this.gstNumber;
    data['pan_number'] = this.panNumber;
    data['licence_number'] = this.licenceNumber;
    data['address'] = this.address;
    data['country'] = this.country;
    data['state'] = this.state;
    data['password'] = this.password;
    data['city'] = this.city;
    data['pincode'] = this.pincode;
    data['landmark'] = this.landmark;
    data['services_coverage'] = this.servicesCoverage;
    data['shop_image'] = this.shopImage;
    data['aadhar_front'] = this.aadharFront;
    data['aadhar_back'] = this.aadharBack;
    data['gps_lat'] = this.gpsLat;
    data['gps_long'] = this.gpsLong;
    data['gps_location'] = this.gpsLocation;
    data['is_verified'] = this.isVerified;
    data['is_bestseller'] = this.isBestseller;
    data['wallet_balance'] = this.walletBalance;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['fiberbase_token'] = this.fiberbaseToken;
    data['handling_charge'] = this.handlingCharge;
    data['pan_card'] = this.panCard;
    data['gst_certificate'] = this.gstCertificate;
    return data;
  }
}
