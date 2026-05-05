class SearchItemModel {
  bool? status;
  String? message;
  Data? data;

  SearchItemModel({this.status, this.message, this.data});

  SearchItemModel.fromJson(Map<String, dynamic> json) {
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
  String? offset;
  String? limit;
  String? hasMore;
  List<SuggestionList>? suggestionList;
  List<ProductsList>? productsList;

  Data(
      {this.offset,
        this.limit,
        this.hasMore,
        this.suggestionList,
        this.productsList});

  Data.fromJson(Map<String, dynamic> json) {
    offset = json['offset'];
    limit = json['limit'];
    hasMore = json['has_more'];
    if (json['suggestion_list'] != null) {
      suggestionList = <SuggestionList>[];
      json['suggestion_list'].forEach((v) {
        suggestionList!.add(new SuggestionList.fromJson(v));
      });
    }
    if (json['products_list'] != null) {
      productsList = <ProductsList>[];
      json['products_list'].forEach((v) {
        productsList!.add(new ProductsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offset'] = this.offset;
    data['limit'] = this.limit;
    data['has_more'] = this.hasMore;
    if (this.suggestionList != null) {
      data['suggestion_list'] =
          this.suggestionList!.map((v) => v.toJson()).toList();
    }
    if (this.productsList != null) {
      data['products_list'] =
          this.productsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SuggestionList {
  String? productName;
  String? image;

  SuggestionList({this.productName, this.image});

  SuggestionList.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name'] = this.productName;
    data['image'] = this.image;
    return data;
  }
}

class ProductsList {
  String? id;
  String? vendorId;
  String? productName;
  String? catTypeId;
  String? category;
  String? subcategory;
  String? quantity;
  String? volume;
  String? mrp;
  String? sellingPrice;
  String? totalAmt;
  String? offerPercent;
  String? stockStatus;
  String? productImage;
  List<ImageList>? imageList;
  String? quantityInCart;
  String? distance;
  String? deliveryTime;

  ProductsList(
      {this.id,
        this.vendorId,
        this.productName,
        this.catTypeId,
        this.category,
        this.subcategory,
        this.quantity,
        this.volume,
        this.mrp,
        this.sellingPrice,
        this.totalAmt,
        this.offerPercent,
        this.stockStatus,
        this.productImage,
        this.imageList,
        this.quantityInCart,
        this.distance,
        this.deliveryTime});

  ProductsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    productName = json['product_name'];
    catTypeId = json['cat_type_id'];
    category = json['category'];
    subcategory = json['subcategory'];
    quantity = json['quantity'];
    volume = json['volume'];
    mrp = json['mrp'];
    sellingPrice = json['selling_price'];
    totalAmt = json['total_amt'];
    offerPercent = json['offerPercent'];
    stockStatus = json['stock_status'];
    productImage = json['product_image'];
    if (json['image_list'] != null) {
      imageList = <ImageList>[];
      json['image_list'].forEach((v) {
        imageList!.add(new ImageList.fromJson(v));
      });
    }
    quantityInCart = json['quantity_in_cart'];
    distance = json['distance'];
    deliveryTime = json['delivery_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['product_name'] = this.productName;
    data['cat_type_id'] = this.catTypeId;
    data['category'] = this.category;
    data['subcategory'] = this.subcategory;
    data['quantity'] = this.quantity;
    data['volume'] = this.volume;
    data['mrp'] = this.mrp;
    data['selling_price'] = this.sellingPrice;
    data['total_amt'] = this.totalAmt;
    data['offerPercent'] = this.offerPercent;
    data['stock_status'] = this.stockStatus;
    data['product_image'] = this.productImage;
    if (this.imageList != null) {
      data['image_list'] = this.imageList!.map((v) => v.toJson()).toList();
    }
    data['quantity_in_cart'] = this.quantityInCart;
    data['distance'] = this.distance;
    data['delivery_time'] = this.deliveryTime;
    return data;
  }
}

class ImageList {
  String? id;
  String? vendorId;
  String? image;
  String? addedDateTime;

  ImageList({this.id, this.vendorId, this.image, this.addedDateTime});

  ImageList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    image = json['image'];
    addedDateTime = json['added_date_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['image'] = this.image;
    data['added_date_time'] = this.addedDateTime;
    return data;
  }
}