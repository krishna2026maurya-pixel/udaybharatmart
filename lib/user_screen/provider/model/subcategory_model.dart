class SubcategoryModel {
  bool? status;
  String? message;
  Data? data;

  SubcategoryModel({this.status, this.message, this.data});

  SubcategoryModel.fromJson(Map<String, dynamic> json) {
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
  String? categoryId;
  String? categoryName;
  String? offset;
  String? limit;
  List<SubcategoryList>? subcategoryList;
  List<Products>? products;

  Data(
      {this.categoryId,
        this.categoryName,
        this.offset,
        this.limit,
        this.subcategoryList,
        this.products});

  Data.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    offset = json['offset'];
    limit = json['limit'];
    if (json['subcategory_list'] != null) {
      subcategoryList = <SubcategoryList>[];
      json['subcategory_list'].forEach((v) {
        subcategoryList!.add(new SubcategoryList.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['offset'] = this.offset;
    data['limit'] = this.limit;
    if (this.subcategoryList != null) {
      data['subcategory_list'] =
          this.subcategoryList!.map((v) => v.toJson()).toList();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubcategoryList {
  String? subcategoryId;
  String? subcategoryName;
  String? subcategoryImage;

  SubcategoryList(
      {this.subcategoryId, this.subcategoryName, this.subcategoryImage});

  SubcategoryList.fromJson(Map<String, dynamic> json) {
    subcategoryId = json['subcategory_id'];
    subcategoryName = json['subcategory_name'];
    subcategoryImage = json['subcategory_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subcategory_id'] = this.subcategoryId;
    data['subcategory_name'] = this.subcategoryName;
    data['subcategory_image'] = this.subcategoryImage;
    return data;
  }
}

class Products {
  String? id;
  String? vendorId;
  String? productName;
  String? catTypeId;
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
  String? totalAmt;
  String? productDescription;
  String? productImages;
  String? addInfoTitle;
  String? addInfoDesc;
  String? stockStatus;
  String? description;
  String? offerPercent;
  String? productImage;
  String? deliveryTime;
  String? quantityInCart;
  String? wishlistStatus;
  String? catTypeName;
  String? categoryName;
  String? subcategoryName;

  Products(
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
        this.totalAmt,
        this.productDescription,
        this.productImages,
        this.addInfoTitle,
        this.addInfoDesc,
        this.stockStatus,
        this.description,
        this.offerPercent,
        this.productImage,
        this.deliveryTime,
        this.quantityInCart,
        this.wishlistStatus,
        this.catTypeName,
        this.categoryName,
        this.subcategoryName});

  Products.fromJson(Map<String, dynamic> json) {
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
    totalAmt = json['total_amt'];
    productDescription = json['product_description'];
    productImages = json['product_images'];
    addInfoTitle = json['add_info_title'];
    addInfoDesc = json['add_info_desc'];
    stockStatus = json['stock_status'];
    description = json['description'];
    offerPercent = json['offer_percent'];
    productImage = json['product_image'];
    deliveryTime = json['delivery_time'];
    quantityInCart = json['quantity_in_cart'];
    wishlistStatus = json['wishlist_status'];
    catTypeName = json['cat_type_name'];
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
    data['total_amt'] = this.totalAmt;
    data['product_description'] = this.productDescription;
    data['product_images'] = this.productImages;
    data['add_info_title'] = this.addInfoTitle;
    data['add_info_desc'] = this.addInfoDesc;
    data['stock_status'] = this.stockStatus;
    data['description'] = this.description;
    data['offer_percent'] = this.offerPercent;
    data['product_image'] = this.productImage;
    data['delivery_time'] = this.deliveryTime;
    data['quantity_in_cart'] = this.quantityInCart;
    data['wishlist_status'] = this.wishlistStatus;
    data['cat_type_name'] = this.catTypeName;
    data['category_name'] = this.categoryName;
    data['subcategory_name'] = this.subcategoryName;
    return data;
  }
}