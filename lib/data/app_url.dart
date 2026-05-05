class AppUrl {
  // static const String baseUrl = "https://udaybharatmarts.com/api";
  static const String baseUrl =
      "https://mediumblue-zebra-775612.hostingersite.com/api";
  static const String userLoginUrl = "$baseUrl/auth/login";
  static const String userVerifyOtp = "$baseUrl/auth/verify-otp";
  static const String usrHomeUrl = "$baseUrl/user/dashboard";
  static const String usrCategoryUrl = "$baseUrl/get_subcat_product_list";
  static const String usrAddRemoveCartUrl = "$baseUrl/add_remove_cart";
  static const String usrProductDetailUrl = "$baseUrl/get_product_details";
  static const String usrGetCartUrl = "$baseUrl/get_cart_page";
  static const String usrGetCheckoutUrl = "$baseUrl/get_checkout_page";
  static const String usrGetCouponUrl = "$baseUrl/get_coupan_code_list";
  static const String usrAllCategoryUrl = "$baseUrl/get_catby_product_list";
  static const String usrCreateBookingUrl = "$baseUrl/create_order";
  static const String usrAddUpdateUrl = "$baseUrl/add_update_user_address";
  static const String usrOrderListUrl = "$baseUrl/user/get_user_order_list";
  static const String usrOrderDetailUrl =
      "$baseUrl/user/get_user_order_details";
  static const String usrFevUnFaveUrl = "$baseUrl/user/fav_unfav_product";
  static const String usrGetWishListUrl = "$baseUrl/user/get_user_wishlist";
  static const String usrWalletTrUrl = "$baseUrl/wallet/user/transactions";
  static const String usrCreateTrUrl =
      "$baseUrl/wallet/user/create-transaction";
  static const String usrProfileUrl = "$baseUrl/user_get_profile";
  static const String usrSarchItemUrl = "$baseUrl/search_products";

  ///Vendor Registration
  static const String vendorRegisterUrl = "$baseUrl/vendor/register";
  static const String vendorLoginUrl = "$baseUrl/vendor/login";
  static const String vendorLogoutUrl = "$baseUrl/vendor/logout";
  static const String vendorBusinessTypeUrl = "$baseUrl/vendor/business-types";
  static const String vendorShopCategoryUrl = "$baseUrl/vendor/categories";

  ///add product
  static const String vendorAddProductUrl = "$baseUrl/vendor/products/add";
  static const String getDropDownCategoryUrl = "$baseUrl/get_category_list";
  static const String getVendorProductUrl = "$baseUrl/vendor/products/list";
  static const String getVendorProductDeleteUrl =
      "$baseUrl/vendor/products/delete";
  static const String getVendorProfileUrl = "$baseUrl/vendor/profile";
  static const String getVendorDashboardUrl = "$baseUrl/vendor/dashboard";
  static const String getVendorProfiledUrl = "$baseUrl/vendor/profile";
  static const String getVendorOrderListUrl = "$baseUrl/vendor/orders_list";
  static const String getVendorUpdateStatusUrl =
      "$baseUrl/vendor/update_booking_status";
  static const String getVendorProductBYIdUrl =
      "$baseUrl/vendor/get_vendor_product_details";
}
