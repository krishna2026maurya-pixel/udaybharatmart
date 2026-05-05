class GetUserWishlistModel {
  bool? status;
  String? message;
  int? wishlistCount;
  List<Wishlist>? wishlist;
  String? totalCartItemCount;
  String? totalCartQty;

  GetUserWishlistModel(
      {this.status,
        this.message,
        this.wishlistCount,
        this.wishlist,
        this.totalCartItemCount,
        this.totalCartQty});

  GetUserWishlistModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    wishlistCount = json['wishlist_count'];
    if (json['wishlist'] != null) {
      wishlist = <Wishlist>[];
      json['wishlist'].forEach((v) {
        wishlist!.add(new Wishlist.fromJson(v));
      });
    }
    totalCartItemCount = json['total_cart_item_count'];
    totalCartQty = json['total_cart_qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['wishlist_count'] = this.wishlistCount;
    if (this.wishlist != null) {
      data['wishlist'] = this.wishlist!.map((v) => v.toJson()).toList();
    }
    data['total_cart_item_count'] = this.totalCartItemCount;
    data['total_cart_qty'] = this.totalCartQty;
    return data;
  }
}

class Wishlist {
  String? productId;
  String? productName;
  String? categoryName;
  String? subcategoryName;
  String? brand;
  String? volume;
  String? quantity;
  String? gst;
  String? sellingPrice;
  String? mrp;
  String? offerPercent;
  String? stockStatus;
  String? productImage;
  String? productDescription;
  String? addedDateTime;
  String? isWishlist;
  String? cartQty;
  String? totalCartItemCount;
  String? totalCartQty;
  String? distanceKm;
  String? deliveryTimeTaken;
  VendorDetails? vendorDetails;

  Wishlist(
      {this.productId,
        this.productName,
        this.categoryName,
        this.subcategoryName,
        this.brand,
        this.volume,
        this.quantity,
        this.gst,
        this.sellingPrice,
        this.mrp,
        this.offerPercent,
        this.stockStatus,
        this.productImage,
        this.productDescription,
        this.addedDateTime,
        this.isWishlist,
        this.cartQty,
        this.totalCartItemCount,
        this.totalCartQty,
        this.distanceKm,
        this.deliveryTimeTaken,
        this.vendorDetails});

  Wishlist.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    categoryName = json['category_name'];
    subcategoryName = json['subcategory_name'];
    brand = json['brand'];
    volume = json['volume'];
    quantity = json['quantity'];
    gst = json['gst'];
    sellingPrice = json['selling_price'];
    mrp = json['mrp'];
    offerPercent = json['offer_percent'];
    stockStatus = json['stock_status'];
    productImage = json['product_image'];
    productDescription = json['product_description'];
    addedDateTime = json['added_date_time'];
    isWishlist = json['is_wishlist'];
    cartQty = json['cart_qty'];
    totalCartItemCount = json['total_cart_item_count'];
    totalCartQty = json['total_cart_qty'];
    distanceKm = json['distance_km'];
    deliveryTimeTaken = json['delivery_time_taken'];
    vendorDetails = json['vendor_details'] != null
        ? new VendorDetails.fromJson(json['vendor_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['category_name'] = this.categoryName;
    data['subcategory_name'] = this.subcategoryName;
    data['brand'] = this.brand;
    data['volume'] = this.volume;
    data['quantity'] = this.quantity;
    data['gst'] = this.gst;
    data['selling_price'] = this.sellingPrice;
    data['mrp'] = this.mrp;
    data['offer_percent'] = this.offerPercent;
    data['stock_status'] = this.stockStatus;
    data['product_image'] = this.productImage;
    data['product_description'] = this.productDescription;
    data['added_date_time'] = this.addedDateTime;
    data['is_wishlist'] = this.isWishlist;
    data['cart_qty'] = this.cartQty;
    data['total_cart_item_count'] = this.totalCartItemCount;
    data['total_cart_qty'] = this.totalCartQty;
    data['distance_km'] = this.distanceKm;
    data['delivery_time_taken'] = this.deliveryTimeTaken;
    if (this.vendorDetails != null) {
      data['vendor_details'] = this.vendorDetails!.toJson();
    }
    return data;
  }
}

class VendorDetails {
  String? vendorId;
  String? fullName;
  String? shopName;
  String? mobileNumber;
  String? email;
  String? gpsLat;
  String? gpsLong;
  String? shopAddress;
  String? city;
  String? state;
  String? pincode;
  String? isVerified;
  String? isBestseller;
  String? shopImage;

  VendorDetails(
      {this.vendorId,
        this.fullName,
        this.shopName,
        this.mobileNumber,
        this.email,
        this.gpsLat,
        this.gpsLong,
        this.shopAddress,
        this.city,
        this.state,
        this.pincode,
        this.isVerified,
        this.isBestseller,
        this.shopImage});

  VendorDetails.fromJson(Map<String, dynamic> json) {
    vendorId = json['vendor_id'];
    fullName = json['full_name'];
    shopName = json['shop_name'];
    mobileNumber = json['mobile_number'];
    email = json['email'];
    gpsLat = json['gps_lat'];
    gpsLong = json['gps_long'];
    shopAddress = json['shop_address'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
    isVerified = json['is_verified'];
    isBestseller = json['is_bestseller'];
    shopImage = json['shop_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor_id'] = this.vendorId;
    data['full_name'] = this.fullName;
    data['shop_name'] = this.shopName;
    data['mobile_number'] = this.mobileNumber;
    data['email'] = this.email;
    data['gps_lat'] = this.gpsLat;
    data['gps_long'] = this.gpsLong;
    data['shop_address'] = this.shopAddress;
    data['city'] = this.city;
    data['state'] = this.state;
    data['pincode'] = this.pincode;
    data['is_verified'] = this.isVerified;
    data['is_bestseller'] = this.isBestseller;
    data['shop_image'] = this.shopImage;
    return data;
  }
}
