class MyOrderModel {
  MyOrderModel({
      bool? success, 
      String? message, 
      List<Data>? data,}){
    _success = success;
    _message = message;
    _data = data;
}

  MyOrderModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _success;
  String? _message;
  List<Data>? _data;
MyOrderModel copyWith({  bool? success,
  String? message,
  List<Data>? data,
}) => MyOrderModel(  success: success ?? _success,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get success => _success;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Data {
  Data({
      String? orderId, 
      String? orderNumber, 
      String? subtotalAmount, 
      String? deliveryCharge, 
      String? totalAmount, 
      String? adminCommission, 
      String? paymentMethod, 
      String? paymentStatus, 
      String? deliveryBoyId, 
      String? status, 
      String? createdAt, 
      ShippingAddress? shippingAddress, 
      List<OrderItems>? orderItems,}){
    _orderId = orderId;
    _orderNumber = orderNumber;
    _subtotalAmount = subtotalAmount;
    _deliveryCharge = deliveryCharge;
    _totalAmount = totalAmount;
    _adminCommission = adminCommission;
    _paymentMethod = paymentMethod;
    _paymentStatus = paymentStatus;
    _deliveryBoyId = deliveryBoyId;
    _status = status;
    _createdAt = createdAt;
    _shippingAddress = shippingAddress;
    _orderItems = orderItems;
}

  Data.fromJson(dynamic json) {
    _orderId = json['order_id'];
    _orderNumber = json['order_number'];
    _subtotalAmount = json['subtotal_amount'];
    _deliveryCharge = json['delivery_charge'];
    _totalAmount = json['total_amount'];
    _adminCommission = json['admin_commission'];
    _paymentMethod = json['payment_method'];
    _paymentStatus = json['payment_status'];
    _deliveryBoyId = json['delivery_boy_id'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _shippingAddress = json['shipping_address'] != null ? ShippingAddress.fromJson(json['shipping_address']) : null;
    if (json['order_items'] != null) {
      _orderItems = [];
      json['order_items'].forEach((v) {
        _orderItems?.add(OrderItems.fromJson(v));
      });
    }
  }
  String? _orderId;
  String? _orderNumber;
  String? _subtotalAmount;
  String? _deliveryCharge;
  String? _totalAmount;
  String? _adminCommission;
  String? _paymentMethod;
  String? _paymentStatus;
  String? _deliveryBoyId;
  String? _status;
  String? _createdAt;
  ShippingAddress? _shippingAddress;
  List<OrderItems>? _orderItems;
Data copyWith({  String? orderId,
  String? orderNumber,
  String? subtotalAmount,
  String? deliveryCharge,
  String? totalAmount,
  String? adminCommission,
  String? paymentMethod,
  String? paymentStatus,
  String? deliveryBoyId,
  String? status,
  String? createdAt,
  ShippingAddress? shippingAddress,
  List<OrderItems>? orderItems,
}) => Data(  orderId: orderId ?? _orderId,
  orderNumber: orderNumber ?? _orderNumber,
  subtotalAmount: subtotalAmount ?? _subtotalAmount,
  deliveryCharge: deliveryCharge ?? _deliveryCharge,
  totalAmount: totalAmount ?? _totalAmount,
  adminCommission: adminCommission ?? _adminCommission,
  paymentMethod: paymentMethod ?? _paymentMethod,
  paymentStatus: paymentStatus ?? _paymentStatus,
  deliveryBoyId: deliveryBoyId ?? _deliveryBoyId,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  shippingAddress: shippingAddress ?? _shippingAddress,
  orderItems: orderItems ?? _orderItems,
);
  String? get orderId => _orderId;
  String? get orderNumber => _orderNumber;
  String? get subtotalAmount => _subtotalAmount;
  String? get deliveryCharge => _deliveryCharge;
  String? get totalAmount => _totalAmount;
  String? get adminCommission => _adminCommission;
  String? get paymentMethod => _paymentMethod;
  String? get paymentStatus => _paymentStatus;
  String? get deliveryBoyId => _deliveryBoyId;
  String? get status => _status;
  String? get createdAt => _createdAt;
  ShippingAddress? get shippingAddress => _shippingAddress;
  List<OrderItems>? get orderItems => _orderItems;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order_id'] = _orderId;
    map['order_number'] = _orderNumber;
    map['subtotal_amount'] = _subtotalAmount;
    map['delivery_charge'] = _deliveryCharge;
    map['total_amount'] = _totalAmount;
    map['admin_commission'] = _adminCommission;
    map['payment_method'] = _paymentMethod;
    map['payment_status'] = _paymentStatus;
    map['delivery_boy_id'] = _deliveryBoyId;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    if (_shippingAddress != null) {
      map['shipping_address'] = _shippingAddress?.toJson();
    }
    if (_orderItems != null) {
      map['order_items'] = _orderItems?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class OrderItems {
  OrderItems({
      String? productId, 
      String? productName, 
      String? categoryId, 
      String? categoryName, 
      String? subcategoryId, 
      String? subcategoryName, 
      String? brand, 
      String? mrp, 
      String? sellingPrice, 
      String? quantity, 
      String? volume, 
      String? gst, 
      String? description, 
      String? productImages, 
      String? itemTotal, 
      String? vendorId, 
      String? vendorName, 
      String? vendorMobile, 
      String? vendorEmail, 
      String? vendorShopName, 
      String? vendorCategory, 
      String? vendorBusinessType, 
      String? vendorGstNumber, 
      String? vendorPanNumber, 
      String? vendorLicenceNumber, 
      String? vendorAddress, 
      String? vendorState, 
      String? vendorCity, 
      String? vendorPincode, 
      String? vendorLandmark, 
      String? vendorServicesCoverage, 
      String? vendorShopImage, 
      String? vendorAadharFront, 
      String? vendorAadharBack, 
      String? vendorGpsLat, 
      String? vendorGpsLong, 
      String? vendorGpsLocation, 
      String? vendorIsVerified, 
      String? vendorIsBestseller, 
      String? vendorHandlingCharge,}){
    _productId = productId;
    _productName = productName;
    _categoryId = categoryId;
    _categoryName = categoryName;
    _subcategoryId = subcategoryId;
    _subcategoryName = subcategoryName;
    _brand = brand;
    _mrp = mrp;
    _sellingPrice = sellingPrice;
    _quantity = quantity;
    _volume = volume;
    _gst = gst;
    _description = description;
    _productImages = productImages;
    _itemTotal = itemTotal;
    _vendorId = vendorId;
    _vendorName = vendorName;
    _vendorMobile = vendorMobile;
    _vendorEmail = vendorEmail;
    _vendorShopName = vendorShopName;
    _vendorCategory = vendorCategory;
    _vendorBusinessType = vendorBusinessType;
    _vendorGstNumber = vendorGstNumber;
    _vendorPanNumber = vendorPanNumber;
    _vendorLicenceNumber = vendorLicenceNumber;
    _vendorAddress = vendorAddress;
    _vendorState = vendorState;
    _vendorCity = vendorCity;
    _vendorPincode = vendorPincode;
    _vendorLandmark = vendorLandmark;
    _vendorServicesCoverage = vendorServicesCoverage;
    _vendorShopImage = vendorShopImage;
    _vendorAadharFront = vendorAadharFront;
    _vendorAadharBack = vendorAadharBack;
    _vendorGpsLat = vendorGpsLat;
    _vendorGpsLong = vendorGpsLong;
    _vendorGpsLocation = vendorGpsLocation;
    _vendorIsVerified = vendorIsVerified;
    _vendorIsBestseller = vendorIsBestseller;
    _vendorHandlingCharge = vendorHandlingCharge;
}

  OrderItems.fromJson(dynamic json) {
    _productId = json['product_id'];
    _productName = json['product_name'];
    _categoryId = json['category_id'];
    _categoryName = json['category_name'];
    _subcategoryId = json['subcategory_id'];
    _subcategoryName = json['subcategory_name'];
    _brand = json['brand'];
    _mrp = json['mrp'];
    _sellingPrice = json['selling_price'];
    _quantity = json['quantity'];
    _volume = json['volume'];
    _gst = json['gst'];
    _description = json['description'];
    _productImages = json['product_images'];
    _itemTotal = json['item_total'];
    _vendorId = json['vendor_id'];
    _vendorName = json['vendor_name'];
    _vendorMobile = json['vendor_mobile'];
    _vendorEmail = json['vendor_email'];
    _vendorShopName = json['vendor_shop_name'];
    _vendorCategory = json['vendor_category'];
    _vendorBusinessType = json['vendor_business_type'];
    _vendorGstNumber = json['vendor_gst_number'];
    _vendorPanNumber = json['vendor_pan_number'];
    _vendorLicenceNumber = json['vendor_licence_number'];
    _vendorAddress = json['vendor_address'];
    _vendorState = json['vendor_state'];
    _vendorCity = json['vendor_city'];
    _vendorPincode = json['vendor_pincode'];
    _vendorLandmark = json['vendor_landmark'];
    _vendorServicesCoverage = json['vendor_services_coverage'];
    _vendorShopImage = json['vendor_shop_image'];
    _vendorAadharFront = json['vendor_aadhar_front'];
    _vendorAadharBack = json['vendor_aadhar_back'];
    _vendorGpsLat = json['vendor_gps_lat'];
    _vendorGpsLong = json['vendor_gps_long'];
    _vendorGpsLocation = json['vendor_gps_location'];
    _vendorIsVerified = json['vendor_is_verified'];
    _vendorIsBestseller = json['vendor_is_bestseller'];
    _vendorHandlingCharge = json['vendor_handling_charge'];
  }
  String? _productId;
  String? _productName;
  String? _categoryId;
  String? _categoryName;
  String? _subcategoryId;
  String? _subcategoryName;
  String? _brand;
  String? _mrp;
  String? _sellingPrice;
  String? _quantity;
  String? _volume;
  String? _gst;
  String? _description;
  String? _productImages;
  String? _itemTotal;
  String? _vendorId;
  String? _vendorName;
  String? _vendorMobile;
  String? _vendorEmail;
  String? _vendorShopName;
  String? _vendorCategory;
  String? _vendorBusinessType;
  String? _vendorGstNumber;
  String? _vendorPanNumber;
  String? _vendorLicenceNumber;
  String? _vendorAddress;
  String? _vendorState;
  String? _vendorCity;
  String? _vendorPincode;
  String? _vendorLandmark;
  String? _vendorServicesCoverage;
  String? _vendorShopImage;
  String? _vendorAadharFront;
  String? _vendorAadharBack;
  String? _vendorGpsLat;
  String? _vendorGpsLong;
  String? _vendorGpsLocation;
  String? _vendorIsVerified;
  String? _vendorIsBestseller;
  String? _vendorHandlingCharge;
OrderItems copyWith({  String? productId,
  String? productName,
  String? categoryId,
  String? categoryName,
  String? subcategoryId,
  String? subcategoryName,
  String? brand,
  String? mrp,
  String? sellingPrice,
  String? quantity,
  String? volume,
  String? gst,
  String? description,
  String? productImages,
  String? itemTotal,
  String? vendorId,
  String? vendorName,
  String? vendorMobile,
  String? vendorEmail,
  String? vendorShopName,
  String? vendorCategory,
  String? vendorBusinessType,
  String? vendorGstNumber,
  String? vendorPanNumber,
  String? vendorLicenceNumber,
  String? vendorAddress,
  String? vendorState,
  String? vendorCity,
  String? vendorPincode,
  String? vendorLandmark,
  String? vendorServicesCoverage,
  String? vendorShopImage,
  String? vendorAadharFront,
  String? vendorAadharBack,
  String? vendorGpsLat,
  String? vendorGpsLong,
  String? vendorGpsLocation,
  String? vendorIsVerified,
  String? vendorIsBestseller,
  String? vendorHandlingCharge,
}) => OrderItems(  productId: productId ?? _productId,
  productName: productName ?? _productName,
  categoryId: categoryId ?? _categoryId,
  categoryName: categoryName ?? _categoryName,
  subcategoryId: subcategoryId ?? _subcategoryId,
  subcategoryName: subcategoryName ?? _subcategoryName,
  brand: brand ?? _brand,
  mrp: mrp ?? _mrp,
  sellingPrice: sellingPrice ?? _sellingPrice,
  quantity: quantity ?? _quantity,
  volume: volume ?? _volume,
  gst: gst ?? _gst,
  description: description ?? _description,
  productImages: productImages ?? _productImages,
  itemTotal: itemTotal ?? _itemTotal,
  vendorId: vendorId ?? _vendorId,
  vendorName: vendorName ?? _vendorName,
  vendorMobile: vendorMobile ?? _vendorMobile,
  vendorEmail: vendorEmail ?? _vendorEmail,
  vendorShopName: vendorShopName ?? _vendorShopName,
  vendorCategory: vendorCategory ?? _vendorCategory,
  vendorBusinessType: vendorBusinessType ?? _vendorBusinessType,
  vendorGstNumber: vendorGstNumber ?? _vendorGstNumber,
  vendorPanNumber: vendorPanNumber ?? _vendorPanNumber,
  vendorLicenceNumber: vendorLicenceNumber ?? _vendorLicenceNumber,
  vendorAddress: vendorAddress ?? _vendorAddress,
  vendorState: vendorState ?? _vendorState,
  vendorCity: vendorCity ?? _vendorCity,
  vendorPincode: vendorPincode ?? _vendorPincode,
  vendorLandmark: vendorLandmark ?? _vendorLandmark,
  vendorServicesCoverage: vendorServicesCoverage ?? _vendorServicesCoverage,
  vendorShopImage: vendorShopImage ?? _vendorShopImage,
  vendorAadharFront: vendorAadharFront ?? _vendorAadharFront,
  vendorAadharBack: vendorAadharBack ?? _vendorAadharBack,
  vendorGpsLat: vendorGpsLat ?? _vendorGpsLat,
  vendorGpsLong: vendorGpsLong ?? _vendorGpsLong,
  vendorGpsLocation: vendorGpsLocation ?? _vendorGpsLocation,
  vendorIsVerified: vendorIsVerified ?? _vendorIsVerified,
  vendorIsBestseller: vendorIsBestseller ?? _vendorIsBestseller,
  vendorHandlingCharge: vendorHandlingCharge ?? _vendorHandlingCharge,
);
  String? get productId => _productId;
  String? get productName => _productName;
  String? get categoryId => _categoryId;
  String? get categoryName => _categoryName;
  String? get subcategoryId => _subcategoryId;
  String? get subcategoryName => _subcategoryName;
  String? get brand => _brand;
  String? get mrp => _mrp;
  String? get sellingPrice => _sellingPrice;
  String? get quantity => _quantity;
  String? get volume => _volume;
  String? get gst => _gst;
  String? get description => _description;
  String? get productImages => _productImages;
  String? get itemTotal => _itemTotal;
  String? get vendorId => _vendorId;
  String? get vendorName => _vendorName;
  String? get vendorMobile => _vendorMobile;
  String? get vendorEmail => _vendorEmail;
  String? get vendorShopName => _vendorShopName;
  String? get vendorCategory => _vendorCategory;
  String? get vendorBusinessType => _vendorBusinessType;
  String? get vendorGstNumber => _vendorGstNumber;
  String? get vendorPanNumber => _vendorPanNumber;
  String? get vendorLicenceNumber => _vendorLicenceNumber;
  String? get vendorAddress => _vendorAddress;
  String? get vendorState => _vendorState;
  String? get vendorCity => _vendorCity;
  String? get vendorPincode => _vendorPincode;
  String? get vendorLandmark => _vendorLandmark;
  String? get vendorServicesCoverage => _vendorServicesCoverage;
  String? get vendorShopImage => _vendorShopImage;
  String? get vendorAadharFront => _vendorAadharFront;
  String? get vendorAadharBack => _vendorAadharBack;
  String? get vendorGpsLat => _vendorGpsLat;
  String? get vendorGpsLong => _vendorGpsLong;
  String? get vendorGpsLocation => _vendorGpsLocation;
  String? get vendorIsVerified => _vendorIsVerified;
  String? get vendorIsBestseller => _vendorIsBestseller;
  String? get vendorHandlingCharge => _vendorHandlingCharge;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_id'] = _productId;
    map['product_name'] = _productName;
    map['category_id'] = _categoryId;
    map['category_name'] = _categoryName;
    map['subcategory_id'] = _subcategoryId;
    map['subcategory_name'] = _subcategoryName;
    map['brand'] = _brand;
    map['mrp'] = _mrp;
    map['selling_price'] = _sellingPrice;
    map['quantity'] = _quantity;
    map['volume'] = _volume;
    map['gst'] = _gst;
    map['description'] = _description;
    map['product_images'] = _productImages;
    map['item_total'] = _itemTotal;
    map['vendor_id'] = _vendorId;
    map['vendor_name'] = _vendorName;
    map['vendor_mobile'] = _vendorMobile;
    map['vendor_email'] = _vendorEmail;
    map['vendor_shop_name'] = _vendorShopName;
    map['vendor_category'] = _vendorCategory;
    map['vendor_business_type'] = _vendorBusinessType;
    map['vendor_gst_number'] = _vendorGstNumber;
    map['vendor_pan_number'] = _vendorPanNumber;
    map['vendor_licence_number'] = _vendorLicenceNumber;
    map['vendor_address'] = _vendorAddress;
    map['vendor_state'] = _vendorState;
    map['vendor_city'] = _vendorCity;
    map['vendor_pincode'] = _vendorPincode;
    map['vendor_landmark'] = _vendorLandmark;
    map['vendor_services_coverage'] = _vendorServicesCoverage;
    map['vendor_shop_image'] = _vendorShopImage;
    map['vendor_aadhar_front'] = _vendorAadharFront;
    map['vendor_aadhar_back'] = _vendorAadharBack;
    map['vendor_gps_lat'] = _vendorGpsLat;
    map['vendor_gps_long'] = _vendorGpsLong;
    map['vendor_gps_location'] = _vendorGpsLocation;
    map['vendor_is_verified'] = _vendorIsVerified;
    map['vendor_is_bestseller'] = _vendorIsBestseller;
    map['vendor_handling_charge'] = _vendorHandlingCharge;
    return map;
  }

}

class ShippingAddress {
  ShippingAddress({
      String? id, 
      String? userId, 
      String? name, 
      String? mobileNo, 
      String? flatNo, 
      String? street, 
      String? area, 
      String? city, 
      String? state, 
      String? pinCode, 
      String? landmark, 
      String? addressType, 
      String? gpsAddress, 
      String? gpsLat, 
      String? gpsLong, 
      String? addedDateTime, 
      String? isDefault, 
      String? isDeleted,}){
    _id = id;
    _userId = userId;
    _name = name;
    _mobileNo = mobileNo;
    _flatNo = flatNo;
    _street = street;
    _area = area;
    _city = city;
    _state = state;
    _pinCode = pinCode;
    _landmark = landmark;
    _addressType = addressType;
    _gpsAddress = gpsAddress;
    _gpsLat = gpsLat;
    _gpsLong = gpsLong;
    _addedDateTime = addedDateTime;
    _isDefault = isDefault;
    _isDeleted = isDeleted;
}

  ShippingAddress.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _name = json['name'];
    _mobileNo = json['mobile_no'];
    _flatNo = json['flat_no'];
    _street = json['street'];
    _area = json['area'];
    _city = json['city'];
    _state = json['state'];
    _pinCode = json['pin_code'];
    _landmark = json['landmark'];
    _addressType = json['address_type'];
    _gpsAddress = json['gps_address'];
    _gpsLat = json['gps_lat'];
    _gpsLong = json['gps_long'];
    _addedDateTime = json['added_date_time'];
    _isDefault = json['is_default'];
    _isDeleted = json['is_deleted'];
  }
  String? _id;
  String? _userId;
  String? _name;
  String? _mobileNo;
  String? _flatNo;
  String? _street;
  String? _area;
  String? _city;
  String? _state;
  String? _pinCode;
  String? _landmark;
  String? _addressType;
  String? _gpsAddress;
  String? _gpsLat;
  String? _gpsLong;
  String? _addedDateTime;
  String? _isDefault;
  String? _isDeleted;
ShippingAddress copyWith({  String? id,
  String? userId,
  String? name,
  String? mobileNo,
  String? flatNo,
  String? street,
  String? area,
  String? city,
  String? state,
  String? pinCode,
  String? landmark,
  String? addressType,
  String? gpsAddress,
  String? gpsLat,
  String? gpsLong,
  String? addedDateTime,
  String? isDefault,
  String? isDeleted,
}) => ShippingAddress(  id: id ?? _id,
  userId: userId ?? _userId,
  name: name ?? _name,
  mobileNo: mobileNo ?? _mobileNo,
  flatNo: flatNo ?? _flatNo,
  street: street ?? _street,
  area: area ?? _area,
  city: city ?? _city,
  state: state ?? _state,
  pinCode: pinCode ?? _pinCode,
  landmark: landmark ?? _landmark,
  addressType: addressType ?? _addressType,
  gpsAddress: gpsAddress ?? _gpsAddress,
  gpsLat: gpsLat ?? _gpsLat,
  gpsLong: gpsLong ?? _gpsLong,
  addedDateTime: addedDateTime ?? _addedDateTime,
  isDefault: isDefault ?? _isDefault,
  isDeleted: isDeleted ?? _isDeleted,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get name => _name;
  String? get mobileNo => _mobileNo;
  String? get flatNo => _flatNo;
  String? get street => _street;
  String? get area => _area;
  String? get city => _city;
  String? get state => _state;
  String? get pinCode => _pinCode;
  String? get landmark => _landmark;
  String? get addressType => _addressType;
  String? get gpsAddress => _gpsAddress;
  String? get gpsLat => _gpsLat;
  String? get gpsLong => _gpsLong;
  String? get addedDateTime => _addedDateTime;
  String? get isDefault => _isDefault;
  String? get isDeleted => _isDeleted;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['name'] = _name;
    map['mobile_no'] = _mobileNo;
    map['flat_no'] = _flatNo;
    map['street'] = _street;
    map['area'] = _area;
    map['city'] = _city;
    map['state'] = _state;
    map['pin_code'] = _pinCode;
    map['landmark'] = _landmark;
    map['address_type'] = _addressType;
    map['gps_address'] = _gpsAddress;
    map['gps_lat'] = _gpsLat;
    map['gps_long'] = _gpsLong;
    map['added_date_time'] = _addedDateTime;
    map['is_default'] = _isDefault;
    map['is_deleted'] = _isDeleted;
    return map;
  }

}