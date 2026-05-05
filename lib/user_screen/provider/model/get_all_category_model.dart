class GetAllCategoryModel {
  GetAllCategoryModel({
      String? status, 
      String? message, 
      List<AllCategoryData>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetAllCategoryModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(AllCategoryData.fromJson(v));
      });
    }
  }
  String? _status;
  String? _message;
  List<AllCategoryData>? _data;
GetAllCategoryModel copyWith({  String? status,
  String? message,
  List<AllCategoryData>? data,
}) => GetAllCategoryModel(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  String? get status => _status;
  String? get message => _message;
  List<AllCategoryData>? get data => _data;

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

class AllCategoryData {
  AllCategoryData({
      String? categoryId, 
      String? categoryName, 
      String? categoryImage, 
      String? categoryDescription,}){
    _categoryId = categoryId;
    _categoryName = categoryName;
    _categoryImage = categoryImage;
    _categoryDescription = categoryDescription;
}

  AllCategoryData.fromJson(dynamic json) {
    _categoryId = json['category_id'];
    _categoryName = json['category_name'];
    _categoryImage = json['category_image'];
    _categoryDescription = json['category_description'];
  }
  String? _categoryId;
  String? _categoryName;
  String? _categoryImage;
  String? _categoryDescription;
  AllCategoryData copyWith({  String? categoryId,
  String? categoryName,
  String? categoryImage,
  String? categoryDescription,
}) => AllCategoryData(  categoryId: categoryId ?? _categoryId,
  categoryName: categoryName ?? _categoryName,
  categoryImage: categoryImage ?? _categoryImage,
  categoryDescription: categoryDescription ?? _categoryDescription,
);
  String? get categoryId => _categoryId;
  String? get categoryName => _categoryName;
  String? get categoryImage => _categoryImage;
  String? get categoryDescription => _categoryDescription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['category_id'] = _categoryId;
    map['category_name'] = _categoryName;
    map['category_image'] = _categoryImage;
    map['category_description'] = _categoryDescription;
    return map;
  }

}