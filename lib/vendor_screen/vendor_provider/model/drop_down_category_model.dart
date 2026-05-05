class DropDownCategoryModel {
  DropDownCategoryModel({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  DropDownCategoryModel.fromJson(dynamic json) {
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
DropDownCategoryModel copyWith({  bool? status,
  String? message,
  List<Data>? data,
}) => DropDownCategoryModel(  status: status ?? _status,
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
      num? id, 
      String? categoryName, 
      String? description, 
      String? createdAt, 
      String? updatedAt, 
      String? categoryImage, 
      List<SubCategoryList>? subCategoryList,}){
    _id = id;
    _categoryName = categoryName;
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _categoryImage = categoryImage;
    _subCategoryList = subCategoryList;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _categoryName = json['category_name'];
    _description = json['description'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _categoryImage = json['category_image'];
    if (json['sub_category_list'] != null) {
      _subCategoryList = [];
      json['sub_category_list'].forEach((v) {
        _subCategoryList?.add(SubCategoryList.fromJson(v));
      });
    }
  }
  num? _id;
  String? _categoryName;
  String? _description;
  String? _createdAt;
  String? _updatedAt;
  String? _categoryImage;
  List<SubCategoryList>? _subCategoryList;
Data copyWith({  num? id,
  String? categoryName,
  String? description,
  String? createdAt,
  String? updatedAt,
  String? categoryImage,
  List<SubCategoryList>? subCategoryList,
}) => Data(  id: id ?? _id,
  categoryName: categoryName ?? _categoryName,
  description: description ?? _description,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  categoryImage: categoryImage ?? _categoryImage,
  subCategoryList: subCategoryList ?? _subCategoryList,
);
  num? get id => _id;
  String? get categoryName => _categoryName;
  String? get description => _description;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get categoryImage => _categoryImage;
  List<SubCategoryList>? get subCategoryList => _subCategoryList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['category_name'] = _categoryName;
    map['description'] = _description;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['category_image'] = _categoryImage;
    if (_subCategoryList != null) {
      map['sub_category_list'] = _subCategoryList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class SubCategoryList {
  SubCategoryList({
      num? id, 
      num? categoryId, 
      String? name, 
      String? image, 
      bool? status, 
      String? addedDateTime, 
      String? discription, 
      String? subCategoryImage, 
      List<SubOfSubcategoryList>? subOfSubcategoryList,}){
    _id = id;
    _categoryId = categoryId;
    _name = name;
    _image = image;
    _status = status;
    _addedDateTime = addedDateTime;
    _discription = discription;
    _subCategoryImage = subCategoryImage;
    _subOfSubcategoryList = subOfSubcategoryList;
}

  SubCategoryList.fromJson(dynamic json) {
    _id = json['id'];
    _categoryId = json['category_id'];
    _name = json['name'];
    _image = json['image'];
    _status = json['status'];
    _addedDateTime = json['added_date_time'];
    _discription = json['discription'];
    _subCategoryImage = json['sub_category_image'];
    if (json['sub_of_subcategory_list'] != null) {
      _subOfSubcategoryList = [];
      json['sub_of_subcategory_list'].forEach((v) {
        _subOfSubcategoryList?.add(SubOfSubcategoryList.fromJson(v));
      });
    }
  }
  num? _id;
  num? _categoryId;
  String? _name;
  String? _image;
  bool? _status;
  String? _addedDateTime;
  String? _discription;
  String? _subCategoryImage;
  List<SubOfSubcategoryList>? _subOfSubcategoryList;
SubCategoryList copyWith({  num? id,
  num? categoryId,
  String? name,
  String? image,
  bool? status,
  String? addedDateTime,
  String? discription,
  String? subCategoryImage,
  List<SubOfSubcategoryList>? subOfSubcategoryList,
}) => SubCategoryList(  id: id ?? _id,
  categoryId: categoryId ?? _categoryId,
  name: name ?? _name,
  image: image ?? _image,
  status: status ?? _status,
  addedDateTime: addedDateTime ?? _addedDateTime,
  discription: discription ?? _discription,
  subCategoryImage: subCategoryImage ?? _subCategoryImage,
  subOfSubcategoryList: subOfSubcategoryList ?? _subOfSubcategoryList,
);
  num? get id => _id;
  num? get categoryId => _categoryId;
  String? get name => _name;
  String? get image => _image;
  bool? get status => _status;
  String? get addedDateTime => _addedDateTime;
  String? get discription => _discription;
  String? get subCategoryImage => _subCategoryImage;
  List<SubOfSubcategoryList>? get subOfSubcategoryList => _subOfSubcategoryList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['category_id'] = _categoryId;
    map['name'] = _name;
    map['image'] = _image;
    map['status'] = _status;
    map['added_date_time'] = _addedDateTime;
    map['discription'] = _discription;
    map['sub_category_image'] = _subCategoryImage;
    if (_subOfSubcategoryList != null) {
      map['sub_of_subcategory_list'] = _subOfSubcategoryList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class SubOfSubcategoryList {
  SubOfSubcategoryList({
      num? id, 
      num? subCategoryId, 
      String? name, 
      String? image, 
      num? sno, 
      num? status, 
      num? catId, 
      String? addedDateTime, 
      num? isDeleted, 
      num? gst, 
      num? commissionPrecent,}){
    _id = id;
    _subCategoryId = subCategoryId;
    _name = name;
    _image = image;
    _sno = sno;
    _status = status;
    _catId = catId;
    _addedDateTime = addedDateTime;
    _isDeleted = isDeleted;
    _gst = gst;
    _commissionPrecent = commissionPrecent;
}

  SubOfSubcategoryList.fromJson(dynamic json) {
    _id = json['id'];
    _subCategoryId = json['sub_category_id'];
    _name = json['name'];
    _image = json['image'];
    _sno = json['sno'];
    _status = json['status'];
    _catId = json['cat_id'];
    _addedDateTime = json['added_date_time'];
    _isDeleted = json['is_deleted'];
    _gst = json['gst'];
    _commissionPrecent = json['commission_precent'];
  }
  num? _id;
  num? _subCategoryId;
  String? _name;
  String? _image;
  num? _sno;
  num? _status;
  num? _catId;
  String? _addedDateTime;
  num? _isDeleted;
  num? _gst;
  num? _commissionPrecent;
SubOfSubcategoryList copyWith({  num? id,
  num? subCategoryId,
  String? name,
  String? image,
  num? sno,
  num? status,
  num? catId,
  String? addedDateTime,
  num? isDeleted,
  num? gst,
  num? commissionPrecent,
}) => SubOfSubcategoryList(  id: id ?? _id,
  subCategoryId: subCategoryId ?? _subCategoryId,
  name: name ?? _name,
  image: image ?? _image,
  sno: sno ?? _sno,
  status: status ?? _status,
  catId: catId ?? _catId,
  addedDateTime: addedDateTime ?? _addedDateTime,
  isDeleted: isDeleted ?? _isDeleted,
  gst: gst ?? _gst,
  commissionPrecent: commissionPrecent ?? _commissionPrecent,
);
  num? get id => _id;
  num? get subCategoryId => _subCategoryId;
  String? get name => _name;
  String? get image => _image;
  num? get sno => _sno;
  num? get status => _status;
  num? get catId => _catId;
  String? get addedDateTime => _addedDateTime;
  num? get isDeleted => _isDeleted;
  num? get gst => _gst;
  num? get commissionPrecent => _commissionPrecent;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['sub_category_id'] = _subCategoryId;
    map['name'] = _name;
    map['image'] = _image;
    map['sno'] = _sno;
    map['status'] = _status;
    map['cat_id'] = _catId;
    map['added_date_time'] = _addedDateTime;
    map['is_deleted'] = _isDeleted;
    map['gst'] = _gst;
    map['commission_precent'] = _commissionPrecent;
    return map;
  }

}