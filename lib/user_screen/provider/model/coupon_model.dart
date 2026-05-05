class CouponModel {
  CouponModel({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  CouponModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Data>? _data;
CouponModel copyWith({  bool? status,
  String? message,
  List<Data>? data,
}) => CouponModel(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Data {
  Data({
      String? id, 
      String? couponCode, 
      String? minOrderValue, 
      String? maxDiscount, 
      String? description, 
      String? validate, 
      String? isActive, 
      String? discountValue,}){
    _id = id;
    _couponCode = couponCode;
    _minOrderValue = minOrderValue;
    _maxDiscount = maxDiscount;
    _description = description;
    _validate = validate;
    _isActive = isActive;
    _discountValue = discountValue;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _couponCode = json['coupon_code'];
    _minOrderValue = json['min_order_value'];
    _maxDiscount = json['max_discount'];
    _description = json['description'];
    _validate = json['validate'];
    _isActive = json['is_active'];
    _discountValue = json['discount_value'];
  }
  String? _id;
  String? _couponCode;
  String? _minOrderValue;
  String? _maxDiscount;
  String? _description;
  String? _validate;
  String? _isActive;
  String? _discountValue;
Data copyWith({  String? id,
  String? couponCode,
  String? minOrderValue,
  String? maxDiscount,
  String? description,
  String? validate,
  String? isActive,
  String? discountValue,
}) => Data(  id: id ?? _id,
  couponCode: couponCode ?? _couponCode,
  minOrderValue: minOrderValue ?? _minOrderValue,
  maxDiscount: maxDiscount ?? _maxDiscount,
  description: description ?? _description,
  validate: validate ?? _validate,
  isActive: isActive ?? _isActive,
  discountValue: discountValue ?? _discountValue,
);
  String? get id => _id;
  String? get couponCode => _couponCode;
  String? get minOrderValue => _minOrderValue;
  String? get maxDiscount => _maxDiscount;
  String? get description => _description;
  String? get validate => _validate;
  String? get isActive => _isActive;
  String? get discountValue => _discountValue;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['coupon_code'] = _couponCode;
    map['min_order_value'] = _minOrderValue;
    map['max_discount'] = _maxDiscount;
    map['description'] = _description;
    map['validate'] = _validate;
    map['is_active'] = _isActive;
    map['discount_value'] = _discountValue;
    return map;
  }

}