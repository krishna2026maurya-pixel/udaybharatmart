// class GetCartModel {
//   bool? status;
//   String? message;
//   Data? data;
//
//   GetCartModel({this.status, this.message, this.data});
//
//   GetCartModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//
//     if (json['data'] != null && json['data'] is Map<String, dynamic>) {
//       data = Data.fromJson(json['data']);
//     } else {
//       data = null;
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   List<CartItemsList>? cartItemsList;
//   String? totalAmount;
//   String? distanceKm;
//   String? deliveryCharge;
//   String? handlingCharge;
//   String? couponCode;
//   String? couponApplyStatus;
//   String? discountValue;
//   String? minumOrderAmt;
//   String? walletBalance;
//   String? walletAmtApplyStatus;
//   String? walletAppliedAmount;
//   String? walletMinOrderAmount;
//   String? walletPartialApplyAmount;
//   String? walletFullApplyAmount;
//   String? walletMessage;
//   WalletProgress? walletProgress;
//   String? netGrandTotal;
//   List<UserAddressList>? userAddressList;
//
//   Data(
//       {this.cartItemsList,
//         this.totalAmount,
//         this.distanceKm,
//         this.deliveryCharge,
//         this.handlingCharge,
//         this.couponCode,
//         this.couponApplyStatus,
//         this.discountValue,
//         this.minumOrderAmt,
//         this.walletBalance,
//         this.walletAmtApplyStatus,
//         this.walletAppliedAmount,
//         this.walletMinOrderAmount,
//         this.walletPartialApplyAmount,
//         this.walletFullApplyAmount,
//         this.walletMessage,
//         this.walletProgress,
//         this.netGrandTotal,
//         this.userAddressList});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     if (json['cart_items_list'] != null) {
//       cartItemsList = <CartItemsList>[];
//       json['cart_items_list'].forEach((v) {
//         cartItemsList!.add(new CartItemsList.fromJson(v));
//       });
//     }
//     totalAmount = json['total_amount'];
//     distanceKm = json['distance_km'];
//     deliveryCharge = json['delivery_charge'];
//     handlingCharge = json['handling_charge'];
//     couponCode = json['coupon_code'];
//     couponApplyStatus = json['coupon_apply_status'];
//     discountValue = json['discount_value'];
//     minumOrderAmt = json['minum_order_amt'];
//     walletBalance = json['wallet_balance'];
//     walletAmtApplyStatus = json['wallet_amt_apply_status'];
//     walletAppliedAmount = json['wallet_applied_amount'];
//     walletMinOrderAmount = json['wallet_min_order_amount'];
//     walletPartialApplyAmount = json['wallet_partial_apply_amount'];
//     walletFullApplyAmount = json['wallet_full_apply_amount'];
//     walletMessage = json['wallet_message'];
//     walletProgress = json['wallet_progress'] != null
//         ? new WalletProgress.fromJson(json['wallet_progress'])
//         : null;
//     netGrandTotal = json['net_grand_total'];
//     if (json['user_address_list'] != null) {
//       userAddressList = <UserAddressList>[];
//       json['user_address_list'].forEach((v) {
//         userAddressList!.add(new UserAddressList.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.cartItemsList != null) {
//       data['cart_items_list'] =
//           this.cartItemsList!.map((v) => v.toJson()).toList();
//     }
//     data['total_amount'] = this.totalAmount;
//     data['distance_km'] = this.distanceKm;
//     data['delivery_charge'] = this.deliveryCharge;
//     data['handling_charge'] = this.handlingCharge;
//     data['coupon_code'] = this.couponCode;
//     data['coupon_apply_status'] = this.couponApplyStatus;
//     data['discount_value'] = this.discountValue;
//     data['minum_order_amt'] = this.minumOrderAmt;
//     data['wallet_balance'] = this.walletBalance;
//     data['wallet_amt_apply_status'] = this.walletAmtApplyStatus;
//     data['wallet_applied_amount'] = this.walletAppliedAmount;
//     data['wallet_min_order_amount'] = this.walletMinOrderAmount;
//     data['wallet_partial_apply_amount'] = this.walletPartialApplyAmount;
//     data['wallet_full_apply_amount'] = this.walletFullApplyAmount;
//     data['wallet_message'] = this.walletMessage;
//     if (this.walletProgress != null) {
//       data['wallet_progress'] = this.walletProgress!.toJson();
//     }
//     data['net_grand_total'] = this.netGrandTotal;
//     if (this.userAddressList != null) {
//       data['user_address_list'] =
//           this.userAddressList!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class CartItemsList {
//   String? cartId;
//   String? id;
//   String? vendorId;
//   String? productName;
//   String? categoryName;
//   String? subCategoryName;
//   String? productImage;
//   String? brand;
//   String? brandName;
//   String? productLabel;
//   String? quantity;
//   String? volume;
//   String? addInfoTitle;
//   String? addInfoDesc;
//   String? stockStatus;
//   String? mrp;
//   String? sellingPrice;
//   String? gst;
//   String? totalAmt;
//   String? cartQty;
//   String? orginalProductAmt;
//
//   CartItemsList(
//       {this.cartId,
//         this.id,
//         this.vendorId,
//         this.productName,
//         this.categoryName,
//         this.subCategoryName,
//         this.productImage,
//         this.brand,
//         this.brandName,
//         this.productLabel,
//         this.quantity,
//         this.volume,
//         this.addInfoTitle,
//         this.addInfoDesc,
//         this.stockStatus,
//         this.mrp,
//         this.sellingPrice,
//         this.gst,
//         this.totalAmt,
//         this.cartQty,
//         this.orginalProductAmt});
//
//   CartItemsList.fromJson(Map<String, dynamic> json) {
//     cartId = json['cart_id'];
//     id = json['id'];
//     vendorId = json['vendor_id'];
//     productName = json['product_name'];
//     categoryName = json['category_name'];
//     subCategoryName = json['sub_category_name'];
//     productImage = json['product_image'];
//     brand = json['brand'];
//     brandName = json['brand_name'];
//     productLabel = json['product_label'];
//     quantity = json['quantity'];
//     volume = json['volume'];
//     addInfoTitle = json['add_info_title'];
//     addInfoDesc = json['add_info_desc'];
//     stockStatus = json['stock_status'];
//     mrp = json['mrp'];
//     sellingPrice = json['selling_price'];
//     gst = json['gst'];
//     totalAmt = json['total_amt'];
//     cartQty = json['cart_qty'];
//     orginalProductAmt = json['orginal_product_amt'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['cart_id'] = this.cartId;
//     data['id'] = this.id;
//     data['vendor_id'] = this.vendorId;
//     data['product_name'] = this.productName;
//     data['category_name'] = this.categoryName;
//     data['sub_category_name'] = this.subCategoryName;
//     data['product_image'] = this.productImage;
//     data['brand'] = this.brand;
//     data['brand_name'] = this.brandName;
//     data['product_label'] = this.productLabel;
//     data['quantity'] = this.quantity;
//     data['volume'] = this.volume;
//     data['add_info_title'] = this.addInfoTitle;
//     data['add_info_desc'] = this.addInfoDesc;
//     data['stock_status'] = this.stockStatus;
//     data['mrp'] = this.mrp;
//     data['selling_price'] = this.sellingPrice;
//     data['gst'] = this.gst;
//     data['total_amt'] = this.totalAmt;
//     data['cart_qty'] = this.cartQty;
//     data['orginal_product_amt'] = this.orginalProductAmt;
//     return data;
//   }
// }
//
// class WalletProgress {
//   String? currentAmount;
//   String? remainingAmount;
//   String? canApplyWallet;
//
//   WalletProgress(
//       {this.currentAmount, this.remainingAmount, this.canApplyWallet});
//
//   WalletProgress.fromJson(Map<String, dynamic> json) {
//     currentAmount = json['current_amount'];
//     remainingAmount = json['remaining_amount'];
//     canApplyWallet = json['can_apply_wallet'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['current_amount'] = this.currentAmount;
//     data['remaining_amount'] = this.remainingAmount;
//     data['can_apply_wallet'] = this.canApplyWallet;
//     return data;
//   }
// }
//
// class UserAddressList {
//   String? id;
//   String? userId;
//   String? addressName;
//   String? addressMobileNumber;
//   String? houseApartmentNo;
//   String? street;
//   String? area;
//   String? city;
//   String? state;
//   String? pinCode;
//   String? landmark;
//   String? addressType;
//   String? gpsAddress;
//   String? gpsLat;
//   String? gpsLong;
//   String? addedDateTime;
//   String? isDefault;
//   String? isDeleted;
//
//   UserAddressList(
//       {this.id,
//         this.userId,
//         this.addressName,
//         this.addressMobileNumber,
//         this.houseApartmentNo,
//         this.street,
//         this.area,
//         this.city,
//         this.state,
//         this.pinCode,
//         this.landmark,
//         this.addressType,
//         this.gpsAddress,
//         this.gpsLat,
//         this.gpsLong,
//         this.addedDateTime,
//         this.isDefault,
//         this.isDeleted});
//
//   UserAddressList.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     addressName = json['address_name'];
//     addressMobileNumber = json['address_mobile_number'];
//     houseApartmentNo = json['house_apartment_no'];
//     street = json['street'];
//     area = json['area'];
//     city = json['city'];
//     state = json['state'];
//     pinCode = json['pin_code'];
//     landmark = json['landmark'];
//     addressType = json['address_type'];
//     gpsAddress = json['gps_address'];
//     gpsLat = json['gps_lat'];
//     gpsLong = json['gps_long'];
//     addedDateTime = json['added_date_time'];
//     isDefault = json['is_default'];
//     isDeleted = json['is_deleted'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data['address_name'] = this.addressName;
//     data['address_mobile_number'] = this.addressMobileNumber;
//     data['house_apartment_no'] = this.houseApartmentNo;
//     data['street'] = this.street;
//     data['area'] = this.area;
//     data['city'] = this.city;
//     data['state'] = this.state;
//     data['pin_code'] = this.pinCode;
//     data['landmark'] = this.landmark;
//     data['address_type'] = this.addressType;
//     data['gps_address'] = this.gpsAddress;
//     data['gps_lat'] = this.gpsLat;
//     data['gps_long'] = this.gpsLong;
//     data['added_date_time'] = this.addedDateTime;
//     data['is_default'] = this.isDefault;
//     data['is_deleted'] = this.isDeleted;
//     return data;
//   }
// }
//
//
class GetCartModel {
  bool? status;
  String? message;
  Data? data;

  GetCartModel({this.status, this.message, this.data});

  GetCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];

    if (json['data'] != null && json['data'] is Map<String, dynamic>) {
      data = Data.fromJson(json['data']);
    } else {
      data = null;
    }
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
  List<CartItemsList>? cartItemsList;
  String? totalAmount;
  String? distanceKm;
  String? deliveryCharge;
  String? handlingCharge;
  String? couponCode;
  String? couponApplyStatus;
  String? discountValue;
  String? minumOrderAmt;
  String? walletBalance;
  String? walletAmtApplyStatus;
  String? walletAppliedAmount;
  String? orderTimingStatus;
  String? orderTimingMessage;
  String? walletMinOrderAmount;
  String? walletPartialApplyAmount;
  String? walletFullApplyAmount;
  String? walletMessage;
  WalletProgress? walletProgress;
  String? netGrandTotal;
  List<UserAddressList>? userAddressList;

  Data(
      {this.cartItemsList,
        this.totalAmount,
        this.distanceKm,
        this.deliveryCharge,
        this.handlingCharge,
        this.couponCode,
        this.couponApplyStatus,
        this.discountValue,
        this.minumOrderAmt,
        this.walletBalance,
        this.walletAmtApplyStatus,
        this.walletAppliedAmount,
        this.orderTimingStatus,
        this.orderTimingMessage,
        this.walletMinOrderAmount,
        this.walletPartialApplyAmount,
        this.walletFullApplyAmount,
        this.walletMessage,
        this.walletProgress,
        this.netGrandTotal,
        this.userAddressList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['cart_items_list'] != null) {
      cartItemsList = <CartItemsList>[];
      json['cart_items_list'].forEach((v) {
        cartItemsList!.add(new CartItemsList.fromJson(v));
      });
    }
    totalAmount = json['total_amount'];
    distanceKm = json['distance_km'];
    deliveryCharge = json['delivery_charge'];
    handlingCharge = json['handling_charge'];
    couponCode = json['coupon_code'];
    couponApplyStatus = json['coupon_apply_status'];
    discountValue = json['discount_value'];
    minumOrderAmt = json['minum_order_amt'];
    walletBalance = json['wallet_balance'];
    walletAmtApplyStatus = json['wallet_amt_apply_status'];
    walletAppliedAmount = json['wallet_applied_amount'];
    orderTimingStatus = json['order_timing_status'];
    orderTimingMessage = json['order_timing_message'];
    walletMinOrderAmount = json['wallet_min_order_amount'];
    walletPartialApplyAmount = json['wallet_partial_apply_amount'];
    walletFullApplyAmount = json['wallet_full_apply_amount'];
    walletMessage = json['wallet_message'];
    walletProgress = json['wallet_progress'] != null
        ? new WalletProgress.fromJson(json['wallet_progress'])
        : null;
    netGrandTotal = json['net_grand_total'];
    if (json['user_address_list'] != null) {
      userAddressList = <UserAddressList>[];
      json['user_address_list'].forEach((v) {
        userAddressList!.add(new UserAddressList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cartItemsList != null) {
      data['cart_items_list'] =
          this.cartItemsList!.map((v) => v.toJson()).toList();
    }
    data['total_amount'] = this.totalAmount;
    data['distance_km'] = this.distanceKm;
    data['delivery_charge'] = this.deliveryCharge;
    data['handling_charge'] = this.handlingCharge;
    data['coupon_code'] = this.couponCode;
    data['coupon_apply_status'] = this.couponApplyStatus;
    data['discount_value'] = this.discountValue;
    data['minum_order_amt'] = this.minumOrderAmt;
    data['wallet_balance'] = this.walletBalance;
    data['wallet_amt_apply_status'] = this.walletAmtApplyStatus;
    data['wallet_applied_amount'] = this.walletAppliedAmount;
    data['order_timing_status'] = this.orderTimingStatus;
    data['order_timing_message'] = this.orderTimingMessage;
    data['wallet_min_order_amount'] = this.walletMinOrderAmount;
    data['wallet_partial_apply_amount'] = this.walletPartialApplyAmount;
    data['wallet_full_apply_amount'] = this.walletFullApplyAmount;
    data['wallet_message'] = this.walletMessage;
    if (this.walletProgress != null) {
      data['wallet_progress'] = this.walletProgress!.toJson();
    }
    data['net_grand_total'] = this.netGrandTotal;
    if (this.userAddressList != null) {
      data['user_address_list'] =
          this.userAddressList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartItemsList {
  String? cartId;
  String? id;
  String? vendorId;
  String? productName;
  String? categoryName;
  String? subCategoryName;
  String? productImage;
  String? brand;
  String? brandName;
  String? productLabel;
  String? quantity;
  String? volume;
  String? addInfoTitle;
  String? addInfoDesc;
  String? stockStatus;
  String? mrp;
  String? sellingPrice;
  String? gst;
  String? totalAmt;
  String? cartQty;
  String? orginalProductAmt;

  CartItemsList(
      {this.cartId,
        this.id,
        this.vendorId,
        this.productName,
        this.categoryName,
        this.subCategoryName,
        this.productImage,
        this.brand,
        this.brandName,
        this.productLabel,
        this.quantity,
        this.volume,
        this.addInfoTitle,
        this.addInfoDesc,
        this.stockStatus,
        this.mrp,
        this.sellingPrice,
        this.gst,
        this.totalAmt,
        this.cartQty,
        this.orginalProductAmt});

  CartItemsList.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    id = json['id'];
    vendorId = json['vendor_id'];
    productName = json['product_name'];
    categoryName = json['category_name'];
    subCategoryName = json['sub_category_name'];
    productImage = json['product_image'];
    brand = json['brand'];
    brandName = json['brand_name'];
    productLabel = json['product_label'];
    quantity = json['quantity'];
    volume = json['volume'];
    addInfoTitle = json['add_info_title'];
    addInfoDesc = json['add_info_desc'];
    stockStatus = json['stock_status'];
    mrp = json['mrp'];
    sellingPrice = json['selling_price'];
    gst = json['gst'];
    totalAmt = json['total_amt'];
    cartQty = json['cart_qty'];
    orginalProductAmt = json['orginal_product_amt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_id'] = this.cartId;
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['product_name'] = this.productName;
    data['category_name'] = this.categoryName;
    data['sub_category_name'] = this.subCategoryName;
    data['product_image'] = this.productImage;
    data['brand'] = this.brand;
    data['brand_name'] = this.brandName;
    data['product_label'] = this.productLabel;
    data['quantity'] = this.quantity;
    data['volume'] = this.volume;
    data['add_info_title'] = this.addInfoTitle;
    data['add_info_desc'] = this.addInfoDesc;
    data['stock_status'] = this.stockStatus;
    data['mrp'] = this.mrp;
    data['selling_price'] = this.sellingPrice;
    data['gst'] = this.gst;
    data['total_amt'] = this.totalAmt;
    data['cart_qty'] = this.cartQty;
    data['orginal_product_amt'] = this.orginalProductAmt;
    return data;
  }
}

class WalletProgress {
  String? currentAmount;
  String? remainingAmount;
  String? canApplyWallet;

  WalletProgress(
      {this.currentAmount, this.remainingAmount, this.canApplyWallet});

  WalletProgress.fromJson(Map<String, dynamic> json) {
    currentAmount = json['current_amount'];
    remainingAmount = json['remaining_amount'];
    canApplyWallet = json['can_apply_wallet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_amount'] = this.currentAmount;
    data['remaining_amount'] = this.remainingAmount;
    data['can_apply_wallet'] = this.canApplyWallet;
    return data;
  }
}

class UserAddressList {
  String? id;
  String? userId;
  String? addressName;
  String? addressMobileNumber;
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

  UserAddressList(
      {this.id,
        this.userId,
        this.addressName,
        this.addressMobileNumber,
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

  UserAddressList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    addressName = json['address_name'];
    addressMobileNumber = json['address_mobile_number'];
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
    data['user_id'] = this.userId;
    data['address_name'] = this.addressName;
    data['address_mobile_number'] = this.addressMobileNumber;
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
