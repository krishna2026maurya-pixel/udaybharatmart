class VendorDashboardModel {
  bool? success;
  Data? data;

  VendorDashboardModel({this.success, this.data});

  VendorDashboardModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  VendorDetails? vendorDetails;
  List<OrdersList>? ordersList;
  Statistics? statistics;
  Data({this.vendorDetails, this.ordersList, this.statistics});
  Data.fromJson(Map<String, dynamic> json) {
    vendorDetails = json['vendor_details'] != null
        ? new VendorDetails.fromJson(json['vendor_details'])
        : null;
    if (json['orders_list'] != null) {
      ordersList = <OrdersList>[];
      json['orders_list'].forEach((v) {
        ordersList!.add(new OrdersList.fromJson(v));
      });
    }
    statistics = json['statistics'] != null
        ? new Statistics.fromJson(json['statistics'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.vendorDetails != null) {
      data['vendor_details'] = this.vendorDetails!.toJson();
    }
    if (this.ordersList != null) {
      data['orders_list'] = this.ordersList!.map((v) => v.toJson()).toList();
    }
    if (this.statistics != null) {
      data['statistics'] = this.statistics!.toJson();
    }
    return data;
  }
}

class VendorDetails {
  String? vendorId;
  String? fullName;
  String? shopName;
  String? mobileNumber;
  String? email;
  String? walletBalance;
  String? gpsLat;
  String? gpsLong;
  String? gpsLocation;
  String? isVerified;
  String? isBestseller;
  String? fiberbaseToken;

  VendorDetails(
      {this.vendorId,
        this.fullName,
        this.shopName,
        this.mobileNumber,
        this.email,
        this.walletBalance,
        this.gpsLat,
        this.gpsLong,
        this.gpsLocation,
        this.isVerified,
        this.isBestseller,
        this.fiberbaseToken});

  VendorDetails.fromJson(Map<String, dynamic> json) {
    vendorId = json['vendor_id'];
    fullName = json['full_name'];
    shopName = json['shop_name'];
    mobileNumber = json['mobile_number'];
    email = json['email'];
    walletBalance = json['wallet_balance'];
    gpsLat = json['gps_lat'];
    gpsLong = json['gps_long'];
    gpsLocation = json['gps_location'];
    isVerified = json['is_verified'];
    isBestseller = json['is_bestseller'];
    fiberbaseToken = json['fiberbase_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor_id'] = this.vendorId;
    data['full_name'] = this.fullName;
    data['shop_name'] = this.shopName;
    data['mobile_number'] = this.mobileNumber;
    data['email'] = this.email;
    data['wallet_balance'] = this.walletBalance;
    data['gps_lat'] = this.gpsLat;
    data['gps_long'] = this.gpsLong;
    data['gps_location'] = this.gpsLocation;
    data['is_verified'] = this.isVerified;
    data['is_bestseller'] = this.isBestseller;
    data['fiberbase_token'] = this.fiberbaseToken;
    return data;
  }
}

class OrdersList {
  String? orderId;
  String? orderNumber;
  String? status;
  String? pickupOtp;
  String? payment_type;
  String? paymentStatus;
  String? totalAmount;
  String? createdAt;
  AddressDetails? addressDetails;
  DeliveryBoyDetails? deliveryBoyDetails;
  UserDetails? userDetails;
  List<OrderItems>? orderItems;

  OrdersList(
      {this.orderId,
        this.orderNumber,
        this.status,
        this.pickupOtp,
        this.payment_type,
        this.paymentStatus,
        this.totalAmount,
        this.createdAt,
        this.addressDetails,
        this.deliveryBoyDetails,
        this.userDetails,
        this.orderItems});

  OrdersList.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    orderNumber = json['order_number'];
    status = json['status'];
    pickupOtp = json['pickup_otp'];
    payment_type = json['payment_type'];
    paymentStatus = json['payment_status'];
    totalAmount = json['total_amount'];
    createdAt = json['created_at'];
    addressDetails = json['address_details'] != null
        ? new AddressDetails.fromJson(json['address_details'])
        : null;
    deliveryBoyDetails = json['delivery_boy_details'] != null
        ? new DeliveryBoyDetails.fromJson(json['delivery_boy_details'])
        : null;
    userDetails = json['user_details'] != null
        ? new UserDetails.fromJson(json['user_details'])
        : null;
    if (json['order_items'] != null) {
      orderItems = <OrderItems>[];
      json['order_items'].forEach((v) {
        orderItems!.add(new OrderItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['order_number'] = this.orderNumber;
    data['status'] = this.status;
    data['pickup_otp'] = this.pickupOtp;
    data['payment_type'] = this.payment_type;
    data['payment_status'] = this.paymentStatus;
    data['total_amount'] = this.totalAmount;
    data['created_at'] = this.createdAt;
    if (this.addressDetails != null) {
      data['address_details'] = this.addressDetails!.toJson();
    }
    if (this.deliveryBoyDetails != null) {
      data['delivery_boy_details'] = this.deliveryBoyDetails!.toJson();
    }
    if (this.userDetails != null) {
      data['user_details'] = this.userDetails!.toJson();
    }
    if (this.orderItems != null) {
      data['order_items'] = this.orderItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddressDetails {
  String? id;
  String? name;
  String? mobileNo;
  String? houseApartmentNo;
  String? street;
  String? area;
  String? city;
  String? state;
  String? pinCode;
  String? landmark;
  String? addressType;
  String? gpsAddress;
  String? gpsLat;
  String? gpsLong;
  String? addedDateTime;
  String? isDefault;
  String? isDeleted;

  AddressDetails(
      {this.id,
        this.name,
        this.mobileNo,
        this.houseApartmentNo,
        this.street,
        this.area,
        this.city,
        this.state,
        this.pinCode,
        this.landmark,
        this.addressType,
        this.gpsAddress,
        this.gpsLat,
        this.gpsLong,
        this.addedDateTime,
        this.isDefault,
        this.isDeleted});

  AddressDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobileNo = json['mobile_no'];
    houseApartmentNo = json['house_apartment_no'];
    street = json['street'];
    area = json['area'];
    city = json['city'];
    state = json['state'];
    pinCode = json['pin_code'];
    landmark = json['landmark'];
    addressType = json['address_type'];
    gpsAddress = json['gps_address'];
    gpsLat = json['gps_lat'];
    gpsLong = json['gps_long'];
    addedDateTime = json['added_date_time'];
    isDefault = json['is_default'];
    isDeleted = json['is_deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile_no'] = this.mobileNo;
    data['house_apartment_no'] = this.houseApartmentNo;
    data['street'] = this.street;
    data['area'] = this.area;
    data['city'] = this.city;
    data['state'] = this.state;
    data['pin_code'] = this.pinCode;
    data['landmark'] = this.landmark;
    data['address_type'] = this.addressType;
    data['gps_address'] = this.gpsAddress;
    data['gps_lat'] = this.gpsLat;
    data['gps_long'] = this.gpsLong;
    data['added_date_time'] = this.addedDateTime;
    data['is_default'] = this.isDefault;
    data['is_deleted'] = this.isDeleted;
    return data;
  }
}

class DeliveryBoyDetails {
  String? id;
  String? name;
  String? fatherName;
  String? phone;
  String? gender;
  String? email;
  String? gpsAddress;
  String? gpsLat;
  String? gpsLong;
  String? district;
  String? city;
  String? profilePhotot;
  String? aadharFront;
  String? aadharBack;
  String? drivingLicense;
  String? vechileRegistrationCard;
  String? bankName;
  String? bankAccountNumber;
  String? bankIfcsCode;
  String? bankBranch;
  String? accountHolderName;
  String? isActive;
  String? isVerified;
  String? isAvailable;
  String? walletBalance;
  String? createdAt;
  String? updatedAt;
  String? vehicleType;

  DeliveryBoyDetails(
      {this.id,
        this.name,
        this.fatherName,
        this.phone,
        this.gender,
        this.email,
        this.gpsAddress,
        this.gpsLat,
        this.gpsLong,
        this.district,
        this.city,
        this.profilePhotot,
        this.aadharFront,
        this.aadharBack,
        this.drivingLicense,
        this.vechileRegistrationCard,
        this.bankName,
        this.bankAccountNumber,
        this.bankIfcsCode,
        this.bankBranch,
        this.accountHolderName,
        this.isActive,
        this.isVerified,
        this.isAvailable,
        this.walletBalance,
        this.createdAt,
        this.updatedAt,
        this.vehicleType});

  DeliveryBoyDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    fatherName = json['father_name'];
    phone = json['phone'];
    gender = json['gender'];
    email = json['email'];
    gpsAddress = json['gps_address'];
    gpsLat = json['gps_lat'];
    gpsLong = json['gps_long'];
    district = json['district'];
    city = json['city'];
    profilePhotot = json['profile_photot'];
    aadharFront = json['aadhar_front'];
    aadharBack = json['aadhar_back'];
    drivingLicense = json['driving_license'];
    vechileRegistrationCard = json['vechile_registration_card'];
    bankName = json['bank_name'];
    bankAccountNumber = json['bank_account_number'];
    bankIfcsCode = json['bank_ifcs_code'];
    bankBranch = json['bank_branch'];
    accountHolderName = json['account_holder_name'];
    isActive = json['is_active'];
    isVerified = json['is_verified'];
    isAvailable = json['is_available'];
    walletBalance = json['wallet_balance'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    vehicleType = json['vehicle_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['father_name'] = this.fatherName;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['gps_address'] = this.gpsAddress;
    data['gps_lat'] = this.gpsLat;
    data['gps_long'] = this.gpsLong;
    data['district'] = this.district;
    data['city'] = this.city;
    data['profile_photot'] = this.profilePhotot;
    data['aadhar_front'] = this.aadharFront;
    data['aadhar_back'] = this.aadharBack;
    data['driving_license'] = this.drivingLicense;
    data['vechile_registration_card'] = this.vechileRegistrationCard;
    data['bank_name'] = this.bankName;
    data['bank_account_number'] = this.bankAccountNumber;
    data['bank_ifcs_code'] = this.bankIfcsCode;
    data['bank_branch'] = this.bankBranch;
    data['account_holder_name'] = this.accountHolderName;
    data['is_active'] = this.isActive;
    data['is_verified'] = this.isVerified;
    data['is_available'] = this.isAvailable;
    data['wallet_balance'] = this.walletBalance;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['vehicle_type'] = this.vehicleType;
    return data;
  }
}

class UserDetails {
  String? userId;
  String? mobileNo;

  UserDetails({this.userId, this.mobileNo});

  UserDetails.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    mobileNo = json['mobile_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['mobile_no'] = this.mobileNo;
    return data;
  }
}

class OrderItems {
  String? productId;
  String? vendorId;
  String? productName;
  String? brand;
  String? productLabel;
  String? quantity;
  String? volume;
  String? mrp;
  String? sellingPrice;

  String? gst;
  String? productDescription;
  String? productImages;
  String? addInfoTitle;
  String? addInfoDesc;
  String? stockStatus;
  String? createdAt;
  String? updatedAt;
  String? subtotal;

  OrderItems(
      {this.productId,
        this.vendorId,
        this.productName,
        this.brand,
        this.productLabel,
        this.quantity,
        this.volume,
        this.mrp,
        this.sellingPrice,
        this.gst,
        this.productDescription,
        this.productImages,
        this.addInfoTitle,
        this.addInfoDesc,
        this.stockStatus,
        this.createdAt,
        this.updatedAt,
        this.subtotal});

  OrderItems.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    vendorId = json['vendor_id'];
    productName = json['product_name'];
    brand = json['brand'];
    productLabel = json['product_label'];
    quantity = json['quantity'];
    volume = json['volume'];
    mrp = json['mrp'];
    sellingPrice = json['selling_price'];
    gst = json['gst'];
    productDescription = json['product_description'];
    productImages = json['product_images'];
    addInfoTitle = json['add_info_title'];
    addInfoDesc = json['add_info_desc'];
    stockStatus = json['stock_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    subtotal = json['subtotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['vendor_id'] = this.vendorId;
    data['product_name'] = this.productName;
    data['brand'] = this.brand;
    data['product_label'] = this.productLabel;
    data['quantity'] = this.quantity;
    data['volume'] = this.volume;
    data['mrp'] = this.mrp;
    data['selling_price'] = this.sellingPrice;
    data['gst'] = this.gst;
    data['product_description'] = this.productDescription;
    data['product_images'] = this.productImages;
    data['add_info_title'] = this.addInfoTitle;
    data['add_info_desc'] = this.addInfoDesc;
    data['stock_status'] = this.stockStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['subtotal'] = this.subtotal;
    return data;
  }
}

class Statistics {
  String? totalNewOrders;
  String? totalConfirmedOrders;
  String? totalShippedOrders;
  String? totalDeliveredOrders;
  String? total_vendor_net_amt;
  String? totalCancelledOrders;

  Statistics(
      {this.totalNewOrders,
        this.totalConfirmedOrders,
        this.totalShippedOrders,
        this.totalDeliveredOrders,
        this.total_vendor_net_amt,
        this.totalCancelledOrders});

  Statistics.fromJson(Map<String, dynamic> json) {
    totalNewOrders = json['total_new_orders'];
    totalConfirmedOrders = json['total_confirmed_orders'];
    totalShippedOrders = json['total_shipped_orders'];
    totalDeliveredOrders = json['total_delivered_orders'];
    total_vendor_net_amt = json['total_vendor_net_amt'];
    totalCancelledOrders = json['total_cancelled_orders'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_new_orders'] = this.totalNewOrders;
    data['total_confirmed_orders'] = this.totalConfirmedOrders;
    data['total_shipped_orders'] = this.totalShippedOrders;
    data['total_vendor_net_amt'] = this.total_vendor_net_amt;
    data['total_cancelled_orders'] = this.totalCancelledOrders;
    data['total_delivered_orders'] = this.totalDeliveredOrders;
    return data;
  }
}
