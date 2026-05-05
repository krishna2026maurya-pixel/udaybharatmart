class GetCheckoutModel {
  GetCheckoutModel({
      String? status,
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetCheckoutModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _status;
  String? _message;
  Data? _data;
GetCheckoutModel copyWith({  String? status,
  String? message,
  Data? data,
}) => GetCheckoutModel(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  String? get status => _status;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      List<CartItemsList>? cartItemsList, 
      String? totalAmount, 
      String? deliveryCharge, 
      String? handlingCharge, 
      String? grandTotal, 
      List<CouponList>? couponList, 
      List<UserAddressList>? userAddressList,}){
    _cartItemsList = cartItemsList;
    _totalAmount = totalAmount;
    _deliveryCharge = deliveryCharge;
    _handlingCharge = handlingCharge;
    _grandTotal = grandTotal;
    _couponList = couponList;
    _userAddressList = userAddressList;
}

  Data.fromJson(dynamic json) {
    if (json['cart_items_list'] != null) {
      _cartItemsList = [];
      json['cart_items_list'].forEach((v) {
        _cartItemsList?.add(CartItemsList.fromJson(v));
      });
    }
    _totalAmount = json['total_amount'];
    _deliveryCharge = json['delivery_charge'];
    _handlingCharge = json['handling_charge'];
    _grandTotal = json['grand_total'];
    if (json['coupon_list'] != null) {
      _couponList = [];
      json['coupon_list'].forEach((v) {
        _couponList?.add(CouponList.fromJson(v));
      });
    }
    if (json['user_address_list'] != null) {
      _userAddressList = [];
      json['user_address_list'].forEach((v) {
        _userAddressList?.add(UserAddressList.fromJson(v));
      });
    }
  }
  List<CartItemsList>? _cartItemsList;
  String? _totalAmount;
  String? _deliveryCharge;
  String? _handlingCharge;
  String? _grandTotal;
  List<CouponList>? _couponList;
  List<UserAddressList>? _userAddressList;
Data copyWith({  List<CartItemsList>? cartItemsList,
  String? totalAmount,
  String? deliveryCharge,
  String? handlingCharge,
  String? grandTotal,
  List<CouponList>? couponList,
  List<UserAddressList>? userAddressList,
}) => Data(  cartItemsList: cartItemsList ?? _cartItemsList,
  totalAmount: totalAmount ?? _totalAmount,
  deliveryCharge: deliveryCharge ?? _deliveryCharge,
  handlingCharge: handlingCharge ?? _handlingCharge,
  grandTotal: grandTotal ?? _grandTotal,
  couponList: couponList ?? _couponList,
  userAddressList: userAddressList ?? _userAddressList,
);
  List<CartItemsList>? get cartItemsList => _cartItemsList;
  String? get totalAmount => _totalAmount;
  String? get deliveryCharge => _deliveryCharge;
  String? get handlingCharge => _handlingCharge;
  String? get grandTotal => _grandTotal;
  List<CouponList>? get couponList => _couponList;
  List<UserAddressList>? get userAddressList => _userAddressList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_cartItemsList != null) {
      map['cart_items_list'] = _cartItemsList?.map((v) => v.toJson()).toList();
    }
    map['total_amount'] = _totalAmount;
    map['delivery_charge'] = _deliveryCharge;
    map['handling_charge'] = _handlingCharge;
    map['grand_total'] = _grandTotal;
    if (_couponList != null) {
      map['coupon_list'] = _couponList?.map((v) => v.toJson()).toList();
    }
    if (_userAddressList != null) {
      map['user_address_list'] = _userAddressList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class UserAddressList {
  UserAddressList({
      String? id, 
      String? userId, 
      String? addressName, 
      String? addressMobileNumber, 
      String? houseApartmentNo, 
      String? street, 
      String? area, 
      String? city, 
      String? state, 
      String? pinCode, 
      String? landmark, 
      String? gpsLat, 
      String? gpsLong, 
      String? gpsAddress, 
      String? addressType, 
      String? addedDateTime, 
      String? isDefault, 
      String? isDeleted,}){
    _id = id;
    _userId = userId;
    _addressName = addressName;
    _addressMobileNumber = addressMobileNumber;
    _houseApartmentNo = houseApartmentNo;
    _street = street;
    _area = area;
    _city = city;
    _state = state;
    _pinCode = pinCode;
    _landmark = landmark;
    _gpsLat = gpsLat;
    _gpsLong = gpsLong;
    _gpsAddress = gpsAddress;
    _addressType = addressType;
    _addedDateTime = addedDateTime;
    _isDefault = isDefault;
    _isDeleted = isDeleted;
}

  UserAddressList.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _addressName = json['address_name'];
    _addressMobileNumber = json['address_mobile_number'];
    _houseApartmentNo = json['house_apartment_no'];
    _street = json['street'];
    _area = json['area'];
    _city = json['city'];
    _state = json['state'];
    _pinCode = json['pin_code'];
    _landmark = json['landmark'];
    _gpsLat = json['gps_lat'];
    _gpsLong = json['gps_long'];
    _gpsAddress = json['gps_address'];
    _addressType = json['address_type'];
    _addedDateTime = json['added_date_time'];
    _isDefault = json['is_default'];
    _isDeleted = json['is_deleted'];
  }
  String? _id;
  String? _userId;
  String? _addressName;
  String? _addressMobileNumber;
  String? _houseApartmentNo;
  String? _street;
  String? _area;
  String? _city;
  String? _state;
  String? _pinCode;
  String? _landmark;
  String? _gpsLat;
  String? _gpsLong;
  String? _gpsAddress;
  String? _addressType;
  String? _addedDateTime;
  String? _isDefault;
  String? _isDeleted;
UserAddressList copyWith({  String? id,
  String? userId,
  String? addressName,
  String? addressMobileNumber,
  String? houseApartmentNo,
  String? street,
  String? area,
  String? city,
  String? state,
  String? pinCode,
  String? landmark,
  String? gpsLat,
  String? gpsLong,
  String? gpsAddress,
  String? addressType,
  String? addedDateTime,
  String? isDefault,
  String? isDeleted,
}) => UserAddressList(  id: id ?? _id,
  userId: userId ?? _userId,
  addressName: addressName ?? _addressName,
  addressMobileNumber: addressMobileNumber ?? _addressMobileNumber,
  houseApartmentNo: houseApartmentNo ?? _houseApartmentNo,
  street: street ?? _street,
  area: area ?? _area,
  city: city ?? _city,
  state: state ?? _state,
  pinCode: pinCode ?? _pinCode,
  landmark: landmark ?? _landmark,
  gpsLat: gpsLat ?? _gpsLat,
  gpsLong: gpsLong ?? _gpsLong,
  gpsAddress: gpsAddress ?? _gpsAddress,
  addressType: addressType ?? _addressType,
  addedDateTime: addedDateTime ?? _addedDateTime,
  isDefault: isDefault ?? _isDefault,
  isDeleted: isDeleted ?? _isDeleted,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get addressName => _addressName;
  String? get addressMobileNumber => _addressMobileNumber;
  String? get houseApartmentNo => _houseApartmentNo;
  String? get street => _street;
  String? get area => _area;
  String? get city => _city;
  String? get state => _state;
  String? get pinCode => _pinCode;
  String? get landmark => _landmark;
  String? get gpsLat => _gpsLat;
  String? get gpsLong => _gpsLong;
  String? get gpsAddress => _gpsAddress;
  String? get addressType => _addressType;
  String? get addedDateTime => _addedDateTime;
  String? get isDefault => _isDefault;
  String? get isDeleted => _isDeleted;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['address_name'] = _addressName;
    map['address_mobile_number'] = _addressMobileNumber;
    map['house_apartment_no'] = _houseApartmentNo;
    map['street'] = _street;
    map['area'] = _area;
    map['city'] = _city;
    map['state'] = _state;
    map['pin_code'] = _pinCode;
    map['landmark'] = _landmark;
    map['gps_lat'] = _gpsLat;
    map['gps_long'] = _gpsLong;
    map['gps_address'] = _gpsAddress;
    map['address_type'] = _addressType;
    map['added_date_time'] = _addedDateTime;
    map['is_default'] = _isDefault;
    map['is_deleted'] = _isDeleted;
    return map;
  }

}

class CouponList {
  CouponList({
      String? id, 
      String? couponCode, 
      String? usedFor, 
      String? discountValue, 
      String? minOrderValue, 
      String? maxDiscount, 
      String? description, 
      String? validate, 
      String? isActive,}){
    _id = id;
    _couponCode = couponCode;
    _usedFor = usedFor;
    _discountValue = discountValue;
    _minOrderValue = minOrderValue;
    _maxDiscount = maxDiscount;
    _description = description;
    _validate = validate;
    _isActive = isActive;
}

  CouponList.fromJson(dynamic json) {
    _id = json['id'];
    _couponCode = json['coupon_code'];
    _usedFor = json['used_for'];
    _discountValue = json['discount_value'];
    _minOrderValue = json['min_order_value'];
    _maxDiscount = json['max_discount'];
    _description = json['description'];
    _validate = json['validate'];
    _isActive = json['is_active'];
  }
  String? _id;
  String? _couponCode;
  String? _usedFor;
  String? _discountValue;
  String? _minOrderValue;
  String? _maxDiscount;
  String? _description;
  String? _validate;
  String? _isActive;
CouponList copyWith({  String? id,
  String? couponCode,
  String? usedFor,
  String? discountValue,
  String? minOrderValue,
  String? maxDiscount,
  String? description,
  String? validate,
  String? isActive,
}) => CouponList(  id: id ?? _id,
  couponCode: couponCode ?? _couponCode,
  usedFor: usedFor ?? _usedFor,
  discountValue: discountValue ?? _discountValue,
  minOrderValue: minOrderValue ?? _minOrderValue,
  maxDiscount: maxDiscount ?? _maxDiscount,
  description: description ?? _description,
  validate: validate ?? _validate,
  isActive: isActive ?? _isActive,
);
  String? get id => _id;
  String? get couponCode => _couponCode;
  String? get usedFor => _usedFor;
  String? get discountValue => _discountValue;
  String? get minOrderValue => _minOrderValue;
  String? get maxDiscount => _maxDiscount;
  String? get description => _description;
  String? get validate => _validate;
  String? get isActive => _isActive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['coupon_code'] = _couponCode;
    map['used_for'] = _usedFor;
    map['discount_value'] = _discountValue;
    map['min_order_value'] = _minOrderValue;
    map['max_discount'] = _maxDiscount;
    map['description'] = _description;
    map['validate'] = _validate;
    map['is_active'] = _isActive;
    return map;
  }

}

class CartItemsList {
  CartItemsList({
      String? cartId, 
      String? productId, 
      String? productName, 
      String? productImage, 
      String? categoryId, 
      String? categoryName, 
      String? subcategoryId, 
      String? subcategoryName, 
      String? vendorId, 
      String? price, 
      String? discount, 
      String? description, 
      String? unit, 
      String? stock, 
      String? quantity, 
      String? subtotal, 
      String? addedAt,}){
    _cartId = cartId;
    _productId = productId;
    _productName = productName;
    _productImage = productImage;
    _categoryId = categoryId;
    _categoryName = categoryName;
    _subcategoryId = subcategoryId;
    _subcategoryName = subcategoryName;
    _vendorId = vendorId;
    _price = price;
    _discount = discount;
    _description = description;
    _unit = unit;
    _stock = stock;
    _quantity = quantity;
    _subtotal = subtotal;
    _addedAt = addedAt;
}

  CartItemsList.fromJson(dynamic json) {
    _cartId = json['cart_id'];
    _productId = json['product_id'];
    _productName = json['product_name'];
    _productImage = json['product_image'];
    _categoryId = json['category_id'];
    _categoryName = json['category_name'];
    _subcategoryId = json['subcategory_id'];
    _subcategoryName = json['subcategory_name'];
    _vendorId = json['vendor_id'];
    _price = json['price'];
    _discount = json['discount'];
    _description = json['description'];
    _unit = json['unit'];
    _stock = json['stock'];
    _quantity = json['quantity'];
    _subtotal = json['subtotal'];
    _addedAt = json['added_at'];
  }
  String? _cartId;
  String? _productId;
  String? _productName;
  String? _productImage;
  String? _categoryId;
  String? _categoryName;
  String? _subcategoryId;
  String? _subcategoryName;
  String? _vendorId;
  String? _price;
  String? _discount;
  String? _description;
  String? _unit;
  String? _stock;
  String? _quantity;
  String? _subtotal;
  String? _addedAt;
CartItemsList copyWith({  String? cartId,
  String? productId,
  String? productName,
  String? productImage,
  String? categoryId,
  String? categoryName,
  String? subcategoryId,
  String? subcategoryName,
  String? vendorId,
  String? price,
  String? discount,
  String? description,
  String? unit,
  String? stock,
  String? quantity,
  String? subtotal,
  String? addedAt,
}) => CartItemsList(  cartId: cartId ?? _cartId,
  productId: productId ?? _productId,
  productName: productName ?? _productName,
  productImage: productImage ?? _productImage,
  categoryId: categoryId ?? _categoryId,
  categoryName: categoryName ?? _categoryName,
  subcategoryId: subcategoryId ?? _subcategoryId,
  subcategoryName: subcategoryName ?? _subcategoryName,
  vendorId: vendorId ?? _vendorId,
  price: price ?? _price,
  discount: discount ?? _discount,
  description: description ?? _description,
  unit: unit ?? _unit,
  stock: stock ?? _stock,
  quantity: quantity ?? _quantity,
  subtotal: subtotal ?? _subtotal,
  addedAt: addedAt ?? _addedAt,
);
  String? get cartId => _cartId;
  String? get productId => _productId;
  String? get productName => _productName;
  String? get productImage => _productImage;
  String? get categoryId => _categoryId;
  String? get categoryName => _categoryName;
  String? get subcategoryId => _subcategoryId;
  String? get subcategoryName => _subcategoryName;
  String? get vendorId => _vendorId;
  String? get price => _price;
  String? get discount => _discount;
  String? get description => _description;
  String? get unit => _unit;
  String? get stock => _stock;
  String? get quantity => _quantity;
  String? get subtotal => _subtotal;
  String? get addedAt => _addedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cart_id'] = _cartId;
    map['product_id'] = _productId;
    map['product_name'] = _productName;
    map['product_image'] = _productImage;
    map['category_id'] = _categoryId;
    map['category_name'] = _categoryName;
    map['subcategory_id'] = _subcategoryId;
    map['subcategory_name'] = _subcategoryName;
    map['vendor_id'] = _vendorId;
    map['price'] = _price;
    map['discount'] = _discount;
    map['description'] = _description;
    map['unit'] = _unit;
    map['stock'] = _stock;
    map['quantity'] = _quantity;
    map['subtotal'] = _subtotal;
    map['added_at'] = _addedAt;
    return map;
  }

}