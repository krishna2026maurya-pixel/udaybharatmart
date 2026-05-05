class UserProfileModel {
  bool? status;
  String? razerpayKey;
  String? razsecretKey;
  String? message;
  UserProfile? userProfile;

  UserProfileModel(
      {this.status, this.razerpayKey,
        this.razsecretKey,
        this.message, this.userProfile});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    razerpayKey = json['razerpay_key']?.toString();
    razsecretKey = json['razsecretKey']?.toString();
    message = json['message']?.toString();
    userProfile = (json['user_profile'] != null && json['user_profile'] is Map<String, dynamic>)
        ? new UserProfile.fromJson(json['user_profile'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['razerpay_key'] = this.razerpayKey;
    data['razsecretKey'] = this.razsecretKey;
    data['message'] = this.message;
    if (this.userProfile != null) {
      data['user_profile'] = this.userProfile!.toJson();
    }
    return data;
  }
}

class UserProfile {
  int? id;
  String? mobileNo;
  String? isVerified;
  String? fiberbaseToken;
  String? createdAt;
  String? updatedAt;
  String? gpsLat;
  String? gpsLong;
  String? walletBalance;
  String? isWalletUsed;

  UserProfile(
      {this.id,
        this.mobileNo,
        this.isVerified,
        this.fiberbaseToken,
        this.createdAt,
        this.updatedAt,
        this.gpsLat,
        this.gpsLong,
        this.walletBalance,
        this.isWalletUsed});

  UserProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mobileNo = json['mobile_no']?.toString();
    isVerified = json['is_verified']?.toString();
    fiberbaseToken = json['fiberbase_token']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
    gpsLat = json['gps_lat']?.toString();
    gpsLong = json['gps_long']?.toString();
    walletBalance = json['wallet_balance']?.toString();
    isWalletUsed = json['is_wallet_used']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mobile_no'] = this.mobileNo;
    data['is_verified'] = this.isVerified;
    data['fiberbase_token'] = this.fiberbaseToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['gps_lat'] = this.gpsLat;
    data['gps_long'] = this.gpsLong;
    data['wallet_balance'] = this.walletBalance;
    data['is_wallet_used'] = this.isWalletUsed;
    return data;
  }
}
