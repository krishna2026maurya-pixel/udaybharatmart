class GetBusinessTypeModel {
  GetBusinessTypeModel({
      num? status, 
      List<Data>? data,}){
    _status = status;
    _data = data;
}

  GetBusinessTypeModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  num? _status;
  List<Data>? _data;
GetBusinessTypeModel copyWith({  num? status,
  List<Data>? data,
}) => GetBusinessTypeModel(  status: status ?? _status,
  data: data ?? _data,
);
  num? get status => _status;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Data {
  Data({
      num? id, 
      String? businessTypeName, 
      String? description, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _businessTypeName = businessTypeName;
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _businessTypeName = json['business_type_name'];
    _description = json['description'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _businessTypeName;
  String? _description;
  String? _createdAt;
  String? _updatedAt;
Data copyWith({  num? id,
  String? businessTypeName,
  String? description,
  String? createdAt,
  String? updatedAt,
}) => Data(  id: id ?? _id,
  businessTypeName: businessTypeName ?? _businessTypeName,
  description: description ?? _description,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  String? get businessTypeName => _businessTypeName;
  String? get description => _description;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['business_type_name'] = _businessTypeName;
    map['description'] = _description;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}