class VendorOrderListModel {
  bool? success;
  String? message;
  int? totalOrders;
  List<OrdersList>? ordersList;

  VendorOrderListModel(
      {this.success, this.message, this.totalOrders, this.ordersList});

  VendorOrderListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    totalOrders = json['total_orders'];
    if (json['orders_list'] != null) {
      ordersList = <OrdersList>[];
      json['orders_list'].forEach((v) {
        ordersList!.add(new OrdersList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['total_orders'] = this.totalOrders;
    if (this.ordersList != null) {
      data['orders_list'] = this.ordersList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrdersList {
  String? orderId;
  String? orderNumber;
  String? status;
  String? paymentStatus;
  String? pickup_otp;
  String? paymentMethod;
  String? totalAmount;
  String? totalProductAmount;
  String? adminCommission;
  String? deliveryCharge;
  String? createdAt;
  String? updatedAt;
  String? is_scheduled;
  String? scheduled_at;
  CustomerDetails? customerDetails;
  ShippingAddress? shippingAddress;
  DeliveryBoy? deliveryBoy;
  List<OrderItems>? orderItems;

  OrdersList(
      {this.orderId,
        this.orderNumber,
        this.status,
        this.paymentStatus,
        this.pickup_otp,
        this.paymentMethod,
        this.totalAmount,
        this.totalProductAmount,
        this.adminCommission,
        this.deliveryCharge,
        this.is_scheduled,
        this.createdAt,
        this.updatedAt,
        this.customerDetails,
        this.shippingAddress,
        this.deliveryBoy,
        this.orderItems});

  OrdersList.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    orderNumber = json['order_number'];
    status = json['status'];
    paymentStatus = json['payment_status'];
    pickup_otp = json['pickup_otp'];
    paymentMethod = json['payment_method'];
    totalAmount = json['total_amount'];
    totalProductAmount = json['total_product_amount'];
    adminCommission = json['admin_commission'];
    deliveryCharge = json['delivery_charge'];
    is_scheduled = json['is_scheduled'];
    scheduled_at = json['scheduled_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customerDetails = json['customer_details'] != null
        ? new CustomerDetails.fromJson(json['customer_details'])
        : null;
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
    data['status'] = this.status;
    data['payment_status'] = this.paymentStatus;
    data['pickup_otp'] = this.pickup_otp;
    data['payment_method'] = this.paymentMethod;
    data['total_amount'] = this.totalAmount;
    data['total_product_amount'] = this.totalProductAmount;
    data['admin_commission'] = this.adminCommission;
    data['delivery_charge'] = this.deliveryCharge;
    data['is_scheduled'] = this.is_scheduled;
    data['scheduled_at'] = this.scheduled_at;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.customerDetails != null) {
      data['customer_details'] = this.customerDetails!.toJson();
    }
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

class CustomerDetails {
  String? id;
  String? name;
  String? mobileNo;
  String? email;

  CustomerDetails({this.id, this.name, this.mobileNo, this.email});

  CustomerDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobileNo = json['mobile_no'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile_no'] = this.mobileNo;
    data['email'] = this.email;
    return data;
  }
}

class ShippingAddress {
  String? id;
  String? addressName;
  String? addressMobileNumber;
  String? houseApartmentNo;
  String? street;
  String? area;
  String? city;
  String? state;
  String? pinCode;
  String? landmark;
  String? gpsLat;
  String? gpsLong;
  String? gpsAddress;

  ShippingAddress(
      {this.id,
        this.addressName,
        this.addressMobileNumber,
        this.houseApartmentNo,
        this.street,
        this.area,
        this.city,
        this.state,
        this.pinCode,
        this.landmark,
        this.gpsLat,
        this.gpsLong,
        this.gpsAddress});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addressName = json['address_name'];
    addressMobileNumber = json['address_mobile_number'];
    houseApartmentNo = json['house_apartment_no'];
    street = json['street'];
    area = json['area'];
    city = json['city'];
    state = json['state'];
    pinCode = json['pin_code'];
    landmark = json['landmark'];
    gpsLat = json['gps_lat'];
    gpsLong = json['gps_long'];
    gpsAddress = json['gps_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address_name'] = this.addressName;
    data['address_mobile_number'] = this.addressMobileNumber;
    data['house_apartment_no'] = this.houseApartmentNo;
    data['street'] = this.street;
    data['area'] = this.area;
    data['city'] = this.city;
    data['state'] = this.state;
    data['pin_code'] = this.pinCode;
    data['landmark'] = this.landmark;
    data['gps_lat'] = this.gpsLat;
    data['gps_long'] = this.gpsLong;
    data['gps_address'] = this.gpsAddress;
    return data;
  }
}

class DeliveryBoy {
  String? id;
  String? name;
  String? phone;
  String? vehicleType;
  String? walletBalance;
  String? profilePhoto;

  DeliveryBoy(
      {this.id,
        this.name,
        this.phone,
        this.vehicleType,
        this.walletBalance,
        this.profilePhoto});

  DeliveryBoy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    vehicleType = json['vehicle_type'];
    walletBalance = json['wallet_balance'];
    profilePhoto = json['profile_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['vehicle_type'] = this.vehicleType;
    data['wallet_balance'] = this.walletBalance;
    data['profile_photo'] = this.profilePhoto;
    return data;
  }
}

class OrderItems {
  String? itemId;
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
      {this.itemId,
        this.productId,
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
    itemId = json['item_id'];
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
    data['item_id'] = this.itemId;
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
