class HomePageModel {
  bool? status;
  String? message;
  Data? data;

  HomePageModel({this.status, this.message, this.data});

  HomePageModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    data = (json['data'] != null && json['data'] is Map<String, dynamic>)
        ? new Data.fromJson(json['data'])
        : null;
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
  String? offset;
  String? limit;
  String? serviceAreaStatus;
  String? pendingOrderStatus;
  PendingOrderDetails? pendingOrderDetails;
  List<CategoriesOnly>? categoriesOnly;
  List<BestsellerVendorProducts>? bestsellerVendorProducts;
  List<CategoriesWithProducts>? categoriesWithProducts;
  List<Banners>? banners;
  String? totalCartItemCount;
  String? totalCartQty;

  Data({
    this.offset,
    this.limit,
    this.serviceAreaStatus,
    this.pendingOrderStatus,
    this.pendingOrderDetails,
    this.categoriesOnly,
    this.bestsellerVendorProducts,
    this.categoriesWithProducts,
    this.banners,
    this.totalCartItemCount,
    this.totalCartQty,
  });

  Data.fromJson(Map<String, dynamic> json) {
    offset = json['offset']?.toString();
    limit = json['limit']?.toString();
    serviceAreaStatus = json['ServiceAreaStatus']?.toString();
    pendingOrderStatus = json['pending_order_status']?.toString();
    pendingOrderDetails = (json['pending_order_details'] != null && json['pending_order_details'] is Map<String, dynamic>)
        ? new PendingOrderDetails.fromJson(json['pending_order_details'])
        : null;
    if (json['categories_only'] != null && json['categories_only'] is List) {
      categoriesOnly = <CategoriesOnly>[];
      json['categories_only'].forEach((v) {
        if (v is Map<String, dynamic>) {
          categoriesOnly!.add(new CategoriesOnly.fromJson(v));
        }
      });
    }
    if (json['bestseller_vendor_products'] != null && json['bestseller_vendor_products'] is List) {
      bestsellerVendorProducts = <BestsellerVendorProducts>[];
      json['bestseller_vendor_products'].forEach((v) {
        if (v is Map<String, dynamic>) {
          bestsellerVendorProducts!.add(new BestsellerVendorProducts.fromJson(v));
        }
      });
    }
    if (json['categories_with_products'] != null && json['categories_with_products'] is List) {
      categoriesWithProducts = <CategoriesWithProducts>[];
      json['categories_with_products'].forEach((v) {
        if (v is Map<String, dynamic>) {
          categoriesWithProducts!.add(new CategoriesWithProducts.fromJson(v));
        }
      });
    }
    if (json['banners'] != null && json['banners'] is List) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        if (v is Map<String, dynamic>) {
          banners!.add(new Banners.fromJson(v));
        }
      });
    }
    totalCartItemCount = json['total_cart_item_count']?.toString();
    totalCartQty = json['total_cart_qty']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offset'] = this.offset;
    data['limit'] = this.limit;
    data['ServiceAreaStatus'] = this.serviceAreaStatus;
    data['pending_order_status'] = this.pendingOrderStatus;
    if (this.pendingOrderDetails != null) {
      data['pending_order_details'] = this.pendingOrderDetails!.toJson();
    }
    if (this.categoriesOnly != null) {
      data['categories_only'] = this.categoriesOnly!
          .map((v) => v.toJson())
          .toList();
    }
    if (this.bestsellerVendorProducts != null) {
      data['bestseller_vendor_products'] = this.bestsellerVendorProducts!
          .map((v) => v.toJson())
          .toList();
    }
    if (this.categoriesWithProducts != null) {
      data['categories_with_products'] = this.categoriesWithProducts!
          .map((v) => v.toJson())
          .toList();
    }
    if (this.banners != null) {
      data['banners'] = this.banners!.map((v) => v.toJson()).toList();
    }
    data['total_cart_item_count'] = this.totalCartItemCount;
    data['total_cart_qty'] = this.totalCartQty;
    return data;
  }
}

class PendingOrderDetails {
  String? orderId;
  String? status;
  DeliveryBoy? deliveryBoy;
  String? eTAStatus;
  String? deliveryEtaMinutes;

  PendingOrderDetails({
    this.orderId,
    this.status,
    this.deliveryBoy,
    this.eTAStatus,
    this.deliveryEtaMinutes,
  });

  PendingOrderDetails.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id']?.toString();
    status = json['status']?.toString();
    deliveryBoy = (json['delivery_boy'] != null && json['delivery_boy'] is Map<String, dynamic>)
        ? new DeliveryBoy.fromJson(json['delivery_boy'])
        : null;
    eTAStatus = json['ETA_status']?.toString();
    deliveryEtaMinutes = json['delivery_eta_minutes']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['status'] = this.status;
    if (this.deliveryBoy != null) {
      data['delivery_boy'] = this.deliveryBoy!.toJson();
    }
    data['ETA_status'] = this.eTAStatus;
    data['delivery_eta_minutes'] = this.deliveryEtaMinutes;
    return data;
  }
}

class DeliveryBoy {
  String? id;
  String? name;
  String? phone;

  DeliveryBoy({this.id, this.name, this.phone});

  DeliveryBoy.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    name = json['name']?.toString();
    phone = json['phone']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    return data;
  }
}

class CategoriesOnly {
  String? id;
  String? categoryTypeName;
  String? slug;
  String? description;
  String? isActive;
  String? image;

  CategoriesOnly({
    this.id,
    this.categoryTypeName,
    this.slug,
    this.description,
    this.isActive,
    this.image,
  });

  CategoriesOnly.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    categoryTypeName = json['category_type_name']?.toString();
    slug = json['slug']?.toString();
    description = json['description']?.toString();
    isActive = json['is_active']?.toString();
    image = json['image']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_type_name'] = this.categoryTypeName;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['is_active'] = this.isActive;
    data['image'] = this.image;
    return data;
  }
}

class BestsellerVendorProducts {
  String? categoryId;
  String? categoryName;
  String? catTypeId;
  String? categoryImage;
  List<Products>? products;

  BestsellerVendorProducts({
    this.categoryId,
    this.categoryName,
    this.catTypeId,
    this.categoryImage,
    this.products,
  });

  BestsellerVendorProducts.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id']?.toString();
    categoryName = json['category_name']?.toString();
    catTypeId = json['cat_type_id']?.toString();
    categoryImage = json['category_image']?.toString();
    if (json['products'] != null && json['products'] is List) {
      products = <Products>[];
      json['products'].forEach((v) {
        if (v is Map<String, dynamic>) {
          products!.add(new Products.fromJson(v));
        }
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['cat_type_id'] = this.catTypeId;
    data['category_image'] = this.categoryImage;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
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
  String? createdAt;
  String? updatedAt;
  String? displayOrder;
  String? bestsellerPriority;
  Vendor? vendor;
  CategoryType? categoryType;
  VendorCategory? vendorCategory;
  SubcategoryList? subcategoryList;
  String? offerPercent;
  String? distanceKm;
  String? deliveryTimeTaken;
  String? quantityInCart;
  String? wishlistStatus;

  Products({
    this.id,
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
    this.createdAt,
    this.updatedAt,
    this.displayOrder,
    this.bestsellerPriority,
    this.vendor,
    this.categoryType,
    this.vendorCategory,
    this.subcategoryList,
    this.offerPercent,
    this.distanceKm,
    this.deliveryTimeTaken,
    this.quantityInCart,
    this.wishlistStatus,
  });

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    vendorId = json['vendor_id']?.toString();
    productName = json['product_name']?.toString();
    catTypeId = json['cat_type_id']?.toString();
    category = json['category']?.toString();
    subcategory = json['subcategory']?.toString();
    lowCategory = json['low_category']?.toString();
    brand = json['brand']?.toString();
    productLabel = json['product_label']?.toString();
    quantity = json['quantity']?.toString();
    volume = json['volume']?.toString();
    mrp = json['mrp']?.toString();
    sellingPrice = json['selling_price']?.toString();
    gst = json['gst']?.toString();
    totalAmt = json['total_amt']?.toString();
    productDescription = json['product_description']?.toString();
    productImages = json['product_images']?.toString();
    addInfoTitle = json['add_info_title']?.toString();
    addInfoDesc = json['add_info_desc']?.toString();
    stockStatus = json['stock_status']?.toString();
    description = json['description']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
    displayOrder = json['display_order']?.toString();
    bestsellerPriority = json['bestseller_priority']?.toString();
    vendor = (json['vendor'] != null && json['vendor'] is Map<String, dynamic>)
        ? new Vendor.fromJson(json['vendor'])
        : null;
    categoryType = (json['category_type'] != null && json['category_type'] is Map<String, dynamic>)
        ? new CategoryType.fromJson(json['category_type'])
        : null;
    vendorCategory = (json['vendor_category'] != null && json['vendor_category'] is Map<String, dynamic>)
        ? new VendorCategory.fromJson(json['vendor_category'])
        : null;
    subcategoryList = (json['subcategory_list'] != null && json['subcategory_list'] is Map<String, dynamic>)
        ? new SubcategoryList.fromJson(json['subcategory_list'])
        : null;
    offerPercent = json['offer_percent']?.toString();
    distanceKm = json['distance_km']?.toString();
    deliveryTimeTaken = json['delivery_time_taken']?.toString();
    quantityInCart = json['quantity_in_cart']?.toString();
    wishlistStatus = json['wishlist_status']?.toString();
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['display_order'] = this.displayOrder;
    data['bestseller_priority'] = this.bestsellerPriority;
    if (this.vendor != null) {
      data['vendor'] = this.vendor!.toJson();
    }
    if (this.categoryType != null) {
      data['category_type'] = this.categoryType!.toJson();
    }
    if (this.vendorCategory != null) {
      data['vendor_category'] = this.vendorCategory!.toJson();
    }
    if (this.subcategoryList != null) {
      data['subcategory_list'] = this.subcategoryList!.toJson();
    }
    data['offer_percent'] = this.offerPercent;
    data['distance_km'] = this.distanceKm;
    data['delivery_time_taken'] = this.deliveryTimeTaken;
    data['quantity_in_cart'] = this.quantityInCart;
    data['wishlist_status'] = this.wishlistStatus;
    return data;
  }
}

class Vendor {
  String? id;
  String? fullName;
  String? email;
  String? mobileNumber;
  String? password;
  String? shopName;
  String? shopCategory;
  String? businessType;
  String? gstNumber;
  String? panNumber;
  String? licenceNumber;
  String? address;
  String? country;
  String? state;
  String? city;
  String? pincode;
  String? landmark;
  String? servicesCoverage;
  String? shopImage;
  String? aadharFront;
  String? aadharBack;
  String? gpsLat;
  String? gpsLong;
  String? gpsLocation;
  String? isVerified;
  String? isBestseller;
  String? walletBalance;
  String? createdAt;
  String? updatedAt;
  String? fiberbaseToken;
  String? handlingCharge;
  String? gstCertificate;
  String? panCard;

  Vendor({
    this.id,
    this.fullName,
    this.email,
    this.mobileNumber,
    this.password,
    this.shopName,
    this.shopCategory,
    this.businessType,
    this.gstNumber,
    this.panNumber,
    this.licenceNumber,
    this.address,
    this.country,
    this.state,
    this.city,
    this.pincode,
    this.landmark,
    this.servicesCoverage,
    this.shopImage,
    this.aadharFront,
    this.aadharBack,
    this.gpsLat,
    this.gpsLong,
    this.gpsLocation,
    this.isVerified,
    this.isBestseller,
    this.walletBalance,
    this.createdAt,
    this.updatedAt,
    this.fiberbaseToken,
    this.handlingCharge,
    this.gstCertificate,
    this.panCard,
  });

  Vendor.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    fullName = json['full_name']?.toString();
    email = json['email']?.toString();
    mobileNumber = json['mobile_number']?.toString();
    password = json['password']?.toString();
    shopName = json['shop_name']?.toString();
    shopCategory = json['shop_category']?.toString();
    businessType = json['business_type']?.toString();
    gstNumber = json['gst_number']?.toString();
    panNumber = json['pan_number']?.toString();
    licenceNumber = json['licence_number']?.toString();
    address = json['address']?.toString();
    country = json['country']?.toString();
    state = json['state']?.toString();
    city = json['city']?.toString();
    pincode = json['pincode']?.toString();
    landmark = json['landmark']?.toString();
    servicesCoverage = json['services_coverage']?.toString();
    shopImage = json['shop_image']?.toString();
    aadharFront = json['aadhar_front']?.toString();
    aadharBack = json['aadhar_back']?.toString();
    gpsLat = json['gps_lat']?.toString();
    gpsLong = json['gps_long']?.toString();
    gpsLocation = json['gps_location']?.toString();
    isVerified = json['is_verified']?.toString();
    isBestseller = json['is_bestseller']?.toString();
    walletBalance = json['wallet_balance']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
    fiberbaseToken = json['fiberbase_token']?.toString();
    handlingCharge = json['handling_charge']?.toString();
    gstCertificate = json['gst_certificate']?.toString();
    panCard = json['pan_card']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['mobile_number'] = this.mobileNumber;
    data['password'] = this.password;
    data['shop_name'] = this.shopName;
    data['shop_category'] = this.shopCategory;
    data['business_type'] = this.businessType;
    data['gst_number'] = this.gstNumber;
    data['pan_number'] = this.panNumber;
    data['licence_number'] = this.licenceNumber;
    data['address'] = this.address;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['pincode'] = this.pincode;
    data['landmark'] = this.landmark;
    data['services_coverage'] = this.servicesCoverage;
    data['shop_image'] = this.shopImage;
    data['aadhar_front'] = this.aadharFront;
    data['aadhar_back'] = this.aadharBack;
    data['gps_lat'] = this.gpsLat;
    data['gps_long'] = this.gpsLong;
    data['gps_location'] = this.gpsLocation;
    data['is_verified'] = this.isVerified;
    data['is_bestseller'] = this.isBestseller;
    data['wallet_balance'] = this.walletBalance;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['fiberbase_token'] = this.fiberbaseToken;
    data['handling_charge'] = this.handlingCharge;
    data['gst_certificate'] = this.gstCertificate;
    data['pan_card'] = this.panCard;
    return data;
  }
}

class CategoryType {
  String? id;
  String? name;
  String? slug;
  String? description;
  String? image;
  String? isActive;
  String? createdAt;
  String? updatedAt;

  CategoryType({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.image,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  CategoryType.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    name = json['name']?.toString();
    slug = json['slug']?.toString();
    description = json['description']?.toString();
    image = json['image']?.toString();
    isActive = json['is_active']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['image'] = this.image;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class VendorCategory {
  String? id;
  String? categoryName;
  String? description;
  String? createdAt;
  String? updatedAt;
  String? categoryImage;
  String? catTypeId;
  String? displayOrder;

  VendorCategory({
    this.id,
    this.categoryName,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.categoryImage,
    this.catTypeId,
    this.displayOrder,
  });

  VendorCategory.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    categoryName = json['category_name']?.toString();
    description = json['description']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
    categoryImage = json['category_image']?.toString();
    catTypeId = json['cat_type_id']?.toString();
    displayOrder = json['display_order']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['category_image'] = this.categoryImage;
    data['cat_type_id'] = this.catTypeId;
    data['display_order'] = this.displayOrder;
    return data;
  }
}

class SubcategoryList {
  String? id;
  String? catTypeId;
  String? categoryId;
  String? name;
  String? image;
  String? discription;
  String? status;
  String? addedDateTime;
  String? createdAt;
  String? updatedAt;

  SubcategoryList({
    this.id,
    this.catTypeId,
    this.categoryId,
    this.name,
    this.image,
    this.discription,
    this.status,
    this.addedDateTime,
    this.createdAt,
    this.updatedAt,
  });

  SubcategoryList.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    catTypeId = json['cat_type_id']?.toString();
    categoryId = json['category_id']?.toString();
    name = json['name']?.toString();
    image = json['image']?.toString();
    discription = json['discription']?.toString();
    status = json['status']?.toString();
    addedDateTime = json['added_date_time']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cat_type_id'] = this.catTypeId;
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['discription'] = this.discription;
    data['status'] = this.status;
    data['added_date_time'] = this.addedDateTime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class CategoriesWithProducts {
  String? categoryId;
  String? categoryName;
  String? categoryImage;
  List<Products>? products;

  CategoriesWithProducts({
    this.categoryId,
    this.categoryName,
    this.categoryImage,
    this.products,
  });

  CategoriesWithProducts.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id']?.toString();
    categoryName = json['category_name']?.toString();
    categoryImage = json['category_image']?.toString();
    if (json['products'] != null && json['products'] is List) {
      products = <Products>[];
      json['products'].forEach((v) {
        if (v is Map<String, dynamic>) {
          products!.add(new Products.fromJson(v));
        }
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['category_image'] = this.categoryImage;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banners {
  String? id;
  String? bannerType;
  String? bannerUrl;
  String? animationType;
  String? vendor_category_id;
  String? autoScroll;
  String? scrollSpeed;

  Banners({
    this.id,
    this.bannerType,
    this.bannerUrl,
    this.animationType,
    this.vendor_category_id,
    this.autoScroll,
    this.scrollSpeed,
  });

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    bannerType = json['banner_type']?.toString();
    bannerUrl = json['banner_url']?.toString();
    animationType = json['animation_type']?.toString();
    vendor_category_id = json['vendor_category_id']?.toString();
    autoScroll = json['auto_scroll']?.toString();
    scrollSpeed = json['scroll_speed']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['banner_type'] = this.bannerType;
    data['banner_url'] = this.bannerUrl;
    data['animation_type'] = this.animationType;
    data['vendor_category_id'] = this.vendor_category_id;
    data['auto_scroll'] = this.autoScroll;
    data['scroll_speed'] = this.scrollSpeed;
    return data;
  }
}
