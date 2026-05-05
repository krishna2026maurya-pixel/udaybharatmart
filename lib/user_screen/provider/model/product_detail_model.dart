class ProductDetailModel {
  bool? status;
  String? message;
  Data? data;

  ProductDetailModel({this.status, this.message, this.data});

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
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
  ProductDetails? productDetails;
  List<SimilarProducts>? similarProducts;
  String? totalCartItemCount;
  String? totalCartQty;

  Data(
      {this.productDetails,
        this.similarProducts,
        this.totalCartItemCount,
        this.totalCartQty});

  Data.fromJson(Map<String, dynamic> json) {
    productDetails = json['product_details'] != null
        ? new ProductDetails.fromJson(json['product_details'])
        : null;
    if (json['similar_products'] != null) {
      similarProducts = <SimilarProducts>[];
      json['similar_products'].forEach((v) {
        similarProducts!.add(new SimilarProducts.fromJson(v));
      });
    }
    totalCartItemCount = json['total_cart_item_count'];
    totalCartQty = json['total_cart_qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.productDetails != null) {
      data['product_details'] = this.productDetails!.toJson();
    }
    if (this.similarProducts != null) {
      data['similar_products'] =
          this.similarProducts!.map((v) => v.toJson()).toList();
    }
    data['total_cart_item_count'] = this.totalCartItemCount;
    data['total_cart_qty'] = this.totalCartQty;
    return data;
  }
}

class ProductDetails {
  String? id;
  String? vendorId;
  String? productName;
  String? catTypeId;
  String? catTypeName;
  String? catTypeImage;
  String? category;
  String? categoryName;
  String? subcategory;
  String? subcategoryName;
  String? lowCategory;
  String? brand;
  String? brandName;
  String? productLabel;
  String? quantity;
  String? volume;
  String? mrp;
  String? sellingPrice;
  String? gst;
  String? totalAmt;
  String? offerPercent;
  String? productDescription;
  String? addInfoTitle;
  String? addInfoDesc;
  String? stockStatus;
  String? description;
  List<ImageList>? imageList;
  String? distance;
  String? deliveryTime;
  VendorDetails? vendorDetails;
  String? quantityInCart;
  String? wishlistStatus;

  ProductDetails(
      {this.id,
        this.vendorId,
        this.productName,
        this.catTypeId,
        this.catTypeName,
        this.catTypeImage,
        this.category,
        this.categoryName,
        this.subcategory,
        this.subcategoryName,
        this.lowCategory,
        this.brand,
        this.brandName,
        this.productLabel,
        this.quantity,
        this.volume,
        this.mrp,
        this.sellingPrice,
        this.gst,
        this.totalAmt,
        this.offerPercent,
        this.productDescription,
        this.addInfoTitle,
        this.addInfoDesc,
        this.stockStatus,
        this.description,
        this.imageList,
        this.distance,
        this.deliveryTime,
        this.vendorDetails,
        this.quantityInCart,
        this.wishlistStatus});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    productName = json['product_name'];
    catTypeId = json['cat_type_id'];
    catTypeName = json['cat_type_name'];
    catTypeImage = json['cat_type_image'];
    category = json['category'];
    categoryName = json['category_name'];
    subcategory = json['subcategory'];
    subcategoryName = json['subcategory_name'];
    lowCategory = json['low_category'];
    brand = json['brand'];
    brandName = json['brand_name'];
    productLabel = json['product_label'];
    quantity = json['quantity'];
    volume = json['volume'];
    mrp = json['mrp'];
    sellingPrice = json['selling_price'];
    gst = json['gst'];
    totalAmt = json['total_amt'];
    offerPercent = json['offerPercent'];
    productDescription = json['product_description'];
    addInfoTitle = json['add_info_title'];
    addInfoDesc = json['add_info_desc'];
    stockStatus = json['stock_status'];
    description = json['description'];
    if (json['image_list'] != null) {
      imageList = <ImageList>[];
      json['image_list'].forEach((v) {
        imageList!.add(new ImageList.fromJson(v));
      });
    }
    distance = json['distance'];
    deliveryTime = json['delivery_time'];
    vendorDetails = json['vendor_details'] != null
        ? new VendorDetails.fromJson(json['vendor_details'])
        : null;
    quantityInCart = json['quantity_in_cart'];
    wishlistStatus = json['wishlist_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['product_name'] = this.productName;
    data['cat_type_id'] = this.catTypeId;
    data['cat_type_name'] = this.catTypeName;
    data['cat_type_image'] = this.catTypeImage;
    data['category'] = this.category;
    data['category_name'] = this.categoryName;
    data['subcategory'] = this.subcategory;
    data['subcategory_name'] = this.subcategoryName;
    data['low_category'] = this.lowCategory;
    data['brand'] = this.brand;
    data['brand_name'] = this.brandName;
    data['product_label'] = this.productLabel;
    data['quantity'] = this.quantity;
    data['volume'] = this.volume;
    data['mrp'] = this.mrp;
    data['selling_price'] = this.sellingPrice;
    data['gst'] = this.gst;
    data['total_amt'] = this.totalAmt;
    data['offerPercent'] = this.offerPercent;
    data['product_description'] = this.productDescription;
    data['add_info_title'] = this.addInfoTitle;
    data['add_info_desc'] = this.addInfoDesc;
    data['stock_status'] = this.stockStatus;
    data['description'] = this.description;
    if (this.imageList != null) {
      data['image_list'] = this.imageList!.map((v) => v.toJson()).toList();
    }
    data['distance'] = this.distance;
    data['delivery_time'] = this.deliveryTime;
    if (this.vendorDetails != null) {
      data['vendor_details'] = this.vendorDetails!.toJson();
    }
    data['quantity_in_cart'] = this.quantityInCart;
    data['wishlist_status'] = this.wishlistStatus;
    return data;
  }
}

class ImageList {
  String? id;
  String? image;
  String? addedDateTime;

  ImageList({this.id, this.image, this.addedDateTime});

  ImageList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    addedDateTime = json['added_date_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['added_date_time'] = this.addedDateTime;
    return data;
  }
}

class VendorDetails {
  String? id;
  String? vendorName;
  String? shopName;
  String? mobile;
  String? email;
  String? address;
  String? gpsLat;
  String? gpsLong;
  String? isVerified;
  String? isBestseller;

  VendorDetails(
      {this.id,
        this.vendorName,
        this.shopName,
        this.mobile,
        this.email,
        this.address,
        this.gpsLat,
        this.gpsLong,
        this.isVerified,
        this.isBestseller});

  VendorDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorName = json['vendor_name'];
    shopName = json['shop_name'];
    mobile = json['mobile'];
    email = json['email'];
    address = json['address'];
    gpsLat = json['gps_lat'];
    gpsLong = json['gps_long'];
    isVerified = json['is_verified'];
    isBestseller = json['is_bestseller'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_name'] = this.vendorName;
    data['shop_name'] = this.shopName;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['address'] = this.address;
    data['gps_lat'] = this.gpsLat;
    data['gps_long'] = this.gpsLong;
    data['is_verified'] = this.isVerified;
    data['is_bestseller'] = this.isBestseller;
    return data;
  }
}

class SimilarProducts {
  String? id;
  String? vendorId;
  String? productName;
  String? shopName;
  String? catTypeId;
  String? catTypeName;
  String? catTypeImage;
  String? category;
  String? categoryName;
  String? subcategory;
  String? subcategoryName;
  String? lowCategory;
  String? brand;
  String? brandName;
  String? productLabel;
  String? quantity;
  String? volume;
  String? mrp;
  String? sellingPrice;
  String? gst;
  String? totalAmt;
  String? offerPercent;
  String? productDescription;
  String? addInfoTitle;
  String? addInfoDesc;
  String? stockStatus;
  String? description;
  String? imageList;
  String? distance;
  String? deliveryTime;
  VendorDetails? vendorDetails;
  String? quantityInCart;
  String? wishlistStatus;

  SimilarProducts(
      {this.id,
        this.vendorId,
        this.productName,
        this.shopName,
        this.catTypeId,
        this.catTypeName,
        this.catTypeImage,
        this.category,
        this.categoryName,
        this.subcategory,
        this.subcategoryName,
        this.lowCategory,
        this.brand,
        this.brandName,
        this.productLabel,
        this.quantity,
        this.volume,
        this.mrp,
        this.sellingPrice,
        this.gst,
        this.totalAmt,
        this.offerPercent,
        this.productDescription,
        this.addInfoTitle,
        this.addInfoDesc,
        this.stockStatus,
        this.description,
        this.imageList,
        this.distance,
        this.deliveryTime,
        this.vendorDetails,
        this.quantityInCart,
        this.wishlistStatus});

  SimilarProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    productName = json['product_name'];
    shopName = json['shop_name'];
    catTypeId = json['cat_type_id'];
    catTypeName = json['cat_type_name'];
    catTypeImage = json['cat_type_image'];
    category = json['category'];
    categoryName = json['category_name'];
    subcategory = json['subcategory'];
    subcategoryName = json['subcategory_name'];
    lowCategory = json['low_category'];
    brand = json['brand'];
    brandName = json['brand_name'];
    productLabel = json['product_label'];
    quantity = json['quantity'];
    volume = json['volume'];
    mrp = json['mrp'];
    sellingPrice = json['selling_price'];
    gst = json['gst'];
    totalAmt = json['total_amt'];
    offerPercent = json['offerPercent'];
    productDescription = json['product_description'];
    addInfoTitle = json['add_info_title'];
    addInfoDesc = json['add_info_desc'];
    stockStatus = json['stock_status'];
    description = json['description'];
    imageList = json['image_list'];
    distance = json['distance'];
    deliveryTime = json['delivery_time'];
    vendorDetails = json['vendor_details'] != null
        ? new VendorDetails.fromJson(json['vendor_details'])
        : null;
    quantityInCart = json['quantity_in_cart'];
    wishlistStatus = json['wishlist_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['product_name'] = this.productName;
    data['shop_name'] = this.shopName;
    data['cat_type_id'] = this.catTypeId;
    data['cat_type_name'] = this.catTypeName;
    data['cat_type_image'] = this.catTypeImage;
    data['category'] = this.category;
    data['category_name'] = this.categoryName;
    data['subcategory'] = this.subcategory;
    data['subcategory_name'] = this.subcategoryName;
    data['low_category'] = this.lowCategory;
    data['brand'] = this.brand;
    data['brand_name'] = this.brandName;
    data['product_label'] = this.productLabel;
    data['quantity'] = this.quantity;
    data['volume'] = this.volume;
    data['mrp'] = this.mrp;
    data['selling_price'] = this.sellingPrice;
    data['gst'] = this.gst;
    data['total_amt'] = this.totalAmt;
    data['offerPercent'] = this.offerPercent;
    data['product_description'] = this.productDescription;
    data['add_info_title'] = this.addInfoTitle;
    data['add_info_desc'] = this.addInfoDesc;
    data['stock_status'] = this.stockStatus;
    data['description'] = this.description;
    data['image_list'] = this.imageList;
    data['distance'] = this.distance;
    data['delivery_time'] = this.deliveryTime;
    if (this.vendorDetails != null) {
      data['vendor_details'] = this.vendorDetails!.toJson();
    }
    data['quantity_in_cart'] = this.quantityInCart;
    data['wishlist_status'] = this.wishlistStatus;
    return data;
  }
}
