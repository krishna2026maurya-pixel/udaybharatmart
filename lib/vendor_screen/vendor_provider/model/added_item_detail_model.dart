class AddedItemDetailModel {
  bool? status;
  String? message;
  Data? data;

  AddedItemDetailModel({this.status, this.message, this.data});

  AddedItemDetailModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  int? vendorId;
  String? productName;
  int? catTypeId;
  String? category;
  String? subcategory;
  String? lowCategory;
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
  Null? description;
  String? categoryName;
  String? subcategoryName;

  Data(
      {this.id,
        this.vendorId,
        this.productName,
        this.catTypeId,
        this.category,
        this.subcategory,
        this.lowCategory,
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
        this.description,
        this.categoryName,
        this.subcategoryName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    productName = json['product_name'];
    catTypeId = json['cat_type_id'];
    category = json['category'];
    subcategory = json['subcategory'];
    lowCategory = json['low_category'];
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
    description = json['description'];
    categoryName = json['category_name'];
    subcategoryName = json['subcategory_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['product_name'] = this.productName;
    data['cat_type_id'] = this.catTypeId;
    data['category'] = this.category;
    data['subcategory'] = this.subcategory;
    data['low_category'] = this.lowCategory;
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
    data['description'] = this.description;
    data['category_name'] = this.categoryName;
    data['subcategory_name'] = this.subcategoryName;
    return data;
  }
}
