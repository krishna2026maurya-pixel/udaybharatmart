class OrderDetailModel {
  bool? status;
  String? message;
  Data? data;

  OrderDetailModel({this.status, this.message, this.data});

  OrderDetailModel.fromJson(Map<String, dynamic> json) {
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
  String? orderId;
  String? orderNumber;
  String? subtotalAmount;
  String? deliveryCharge;
  String? totalAmount;
  String? adminCommission;
  String? paymentMethod;
  String? paymentStatus;
  String? deliveryBoyId;
  String? status;
  PendingOrderDetails? pendingOrderDetails;
  String? createdAt;
  ShippingAddress? shippingAddress;
  DeliveryBoy? deliveryBoy;
  List<OrderItems>? orderItems;

  Data(
      {this.orderId,
        this.orderNumber,
        this.subtotalAmount,
        this.deliveryCharge,
        this.totalAmount,
        this.adminCommission,
        this.paymentMethod,
        this.paymentStatus,
        this.deliveryBoyId,
        this.status,
        this.pendingOrderDetails,
        this.createdAt,
        this.shippingAddress,
        this.deliveryBoy,
        this.orderItems});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    orderNumber = json['order_number'];
    subtotalAmount = json['subtotal_amount'];
    deliveryCharge = json['delivery_charge'];
    totalAmount = json['total_amount'];
    adminCommission = json['admin_commission'];
    paymentMethod = json['payment_method'];
    paymentStatus = json['payment_status'];
    deliveryBoyId = json['delivery_boy_id'];
    status = json['status'];
    pendingOrderDetails = json['pending_order_details'] != null
        ? new PendingOrderDetails.fromJson(json['pending_order_details'])
        : null;
    createdAt = json['created_at'];
    shippingAddress = json['shipping_address'] != null
        ? new ShippingAddress.fromJson(json['shipping_address'])
        : null;
    deliveryBoy = json['delivery_boy'] != null
        ? new DeliveryBoy.fromJson(json['delivery_boy'])
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
    data['subtotal_amount'] = this.subtotalAmount;
    data['delivery_charge'] = this.deliveryCharge;
    data['total_amount'] = this.totalAmount;
    data['admin_commission'] = this.adminCommission;
    data['payment_method'] = this.paymentMethod;
    data['payment_status'] = this.paymentStatus;
    data['delivery_boy_id'] = this.deliveryBoyId;
    data['status'] = this.status;
    if (this.pendingOrderDetails != null) {
      data['pending_order_details'] = this.pendingOrderDetails!.toJson();
    }
    data['created_at'] = this.createdAt;
    if (this.shippingAddress != null) {
      data['shipping_address'] = this.shippingAddress!.toJson();
    }
    if (this.deliveryBoy != null) {
      data['delivery_boy'] = this.deliveryBoy!.toJson();
    }
    if (this.orderItems != null) {
      data['order_items'] = this.orderItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PendingOrderDetails {
  String? orderId;
  String? status;
  PendingDeliveryBoy? deliveryBoy;

  String? eTAStatus;
  String? deliveryEtaMinutes;

  PendingOrderDetails(
      {this.orderId,
        this.status,
        this.deliveryBoy,
        this.eTAStatus,
        this.deliveryEtaMinutes});

  PendingOrderDetails.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    status = json['status'];
    deliveryBoy = json['delivery_boy'] != null
        ? new PendingDeliveryBoy.fromJson(json['delivery_boy'])
        : null;

    eTAStatus = json['ETA_status'];
    deliveryEtaMinutes = json['delivery_eta_minutes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['status'] = this.status;
    if (this.deliveryBoy != null) {
      data['delivery_boy'] = this.deliveryBoy!.toJson();
    }
    data['ETA_status'] = this.eTAStatus;
    data['delivery_eta_minutes'] = this.deliveryEtaMinutes;
    return data;
  }
}

class PendingDeliveryBoy {
  String? id;
  String? name;
  String? phone;

  PendingDeliveryBoy({this.id, this.name, this.phone});

  PendingDeliveryBoy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    return data;
  }
}



class ShippingAddress {
  String? id;
  String? userId;
  String? name;
  String? mobileNo;
  String? flatNo;
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

  ShippingAddress(
      {this.id,
        this.userId,
        this.name,
        this.mobileNo,
        this.flatNo,
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

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    mobileNo = json['mobile_no'];
    flatNo = json['flat_no'];
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
    data['name'] = this.name;
    data['mobile_no'] = this.mobileNo;
    data['flat_no'] = this.flatNo;
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

class DeliveryBoy {
  String? id;
  String? name;
  String? phone;
  String? gpsLat;
  String? gpsLong;
  String? gpsAddress;
  String? vehicleType;
  String? isActive;
  String? isVerified;
  String? isAvailable;
  String? profilePhoto;

  DeliveryBoy(
      {this.id,
        this.name,
        this.phone,
        this.gpsLat,
        this.gpsLong,
        this.gpsAddress,
        this.vehicleType,
        this.isActive,
        this.isVerified,
        this.isAvailable,
        this.profilePhoto});

  DeliveryBoy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    gpsLat = json['gps_lat'];
    gpsLong = json['gps_long'];
    gpsAddress = json['gps_address'];
    vehicleType = json['vehicle_type'];
    isActive = json['is_active'];
    isVerified = json['is_verified'];
    isAvailable = json['is_available'];
    profilePhoto = json['profile_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['gps_lat'] = this.gpsLat;
    data['gps_long'] = this.gpsLong;
    data['gps_address'] = this.gpsAddress;
    data['vehicle_type'] = this.vehicleType;
    data['is_active'] = this.isActive;
    data['is_verified'] = this.isVerified;
    data['is_available'] = this.isAvailable;
    data['profile_photo'] = this.profilePhoto;
    return data;
  }
}

class OrderItems {
  String? productId;
  String? productName;
  String? mrp;
  String? sellingPrice;
  String? quantity;
  String? productImages;
  String? isWishlist;
  String? cartQty;
  String? totalCartItemCount;
  String? totalCartQty;
  String? distanceKm;
  String? deliveryTimeTaken;

  OrderItems(
      {this.productId,
        this.productName,
        this.mrp,
        this.sellingPrice,
        this.quantity,
        this.productImages,
        this.isWishlist,
        this.cartQty,
        this.totalCartItemCount,
        this.totalCartQty,
        this.distanceKm,
        this.deliveryTimeTaken});

  OrderItems.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    mrp = json['mrp'];
    sellingPrice = json['selling_price'];
    quantity = json['quantity'];
    productImages = json['product_images'];
    isWishlist = json['is_wishlist'];
    cartQty = json['cart_qty'];
    totalCartItemCount = json['total_cart_item_count'];
    totalCartQty = json['total_cart_qty'];
    distanceKm = json['distance_km'];
    deliveryTimeTaken = json['delivery_time_taken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['mrp'] = this.mrp;
    data['selling_price'] = this.sellingPrice;
    data['quantity'] = this.quantity;
    data['product_images'] = this.productImages;
    data['is_wishlist'] = this.isWishlist;
    data['cart_qty'] = this.cartQty;
    data['total_cart_item_count'] = this.totalCartItemCount;
    data['total_cart_qty'] = this.totalCartQty;
    data['distance_km'] = this.distanceKm;
    data['delivery_time_taken'] = this.deliveryTimeTaken;
    return data;
  }
}
