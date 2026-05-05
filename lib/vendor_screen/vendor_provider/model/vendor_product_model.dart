class VendorProductModel {
  bool? status;
  String? message;
  dynamic vendorId;
  String? vendorName;
  List<ProductList>? productList;

  VendorProductModel(
      {this.status,
        this.message,
        this.vendorId,
        this.vendorName,
        this.productList});

  VendorProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    vendorId = json['vendor_id'];
    vendorName = json['vendor_name'];
    if (json['product_list'] != null) {
      productList = <ProductList>[];
      json['product_list'].forEach((v) {
        productList!.add(new ProductList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['vendor_id'] = this.vendorId;
    data['vendor_name'] = this.vendorName;
    if (this.productList != null) {
      data['product_list'] = this.productList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductList {
  String? id;
  String? productName;
  String? lowCategory;
  String? brand;
  String? categoryId;
  String? categoryName;
  String? subcategoryId;
  String? subcategoryName;
  String? productImages;
  String? productLabel;
  String? quantity;
  String? volume;
  String? mrp;
  String? sellingPrice;
  String? gst;
  String? addInfoTitle;
  String? addInfoDesc;
  String? stock;
  String? description;
  String? createdAt;
  String? updatedAt;

  ProductList(
      {this.id,
        this.productName,
        this.lowCategory,
        this.brand,
        this.categoryId,
        this.categoryName,
        this.subcategoryId,
        this.subcategoryName,
        this.productImages,
        this.productLabel,
        this.quantity,
        this.volume,
        this.mrp,
        this.sellingPrice,
        this.gst,
        this.addInfoTitle,
        this.addInfoDesc,
        this.stock,
        this.description,
        this.createdAt,
        this.updatedAt});

  ProductList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    lowCategory = json['low_category'];
    brand = json['brand'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    subcategoryId = json['subcategory_id'];
    subcategoryName = json['subcategory_name'];
    productImages = json['product_images'];
    productLabel = json['product_label'];
    quantity = json['quantity'];
    volume = json['volume'];
    mrp = json['mrp'];
    sellingPrice = json['selling_price'];
    gst = json['gst'];
    addInfoTitle = json['add_info_title'];
    addInfoDesc = json['add_info_desc'];
    stock = json['stock'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_name'] = this.productName;
    data['low_category'] = this.lowCategory;
    data['brand'] = this.brand;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['subcategory_id'] = this.subcategoryId;
    data['subcategory_name'] = this.subcategoryName;
    data['product_images'] = this.productImages;
    data['product_label'] = this.productLabel;
    data['quantity'] = this.quantity;
    data['volume'] = this.volume;
    data['mrp'] = this.mrp;
    data['selling_price'] = this.sellingPrice;
    data['gst'] = this.gst;
    data['add_info_title'] = this.addInfoTitle;
    data['add_info_desc'] = this.addInfoDesc;
    data['stock'] = this.stock;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
