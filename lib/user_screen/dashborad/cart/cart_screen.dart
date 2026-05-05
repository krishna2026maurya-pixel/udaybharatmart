import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rounded_linear_progress/rounded_linear_progress.dart';
import 'package:uday_bharat/user_screen/dashborad/cart/payment_option_tile.dart';
import 'package:uday_bharat/user_screen/dashborad/cart/select_shadule_widget.dart';
import 'package:uday_bharat/user_screen/dashborad/cart/wallet_unlock_progressbar_widget.dart';
import 'package:uday_bharat/user_screen/provider/view_model/cart_view_model.dart';
import 'package:uday_bharat/user_screen/provider/view_model/home_provider.dart';
import 'package:uday_bharat/user_screen/provider/view_model/payment_provider.dart';
import 'package:uday_bharat/user_screen/widgets/cart_button_widget.dart';
import 'package:uday_bharat/user_screen/widgets/shimmer/cart_shimmer.dart';
import 'package:uday_bharat/utils/cache_image.dart';
import 'package:uday_bharat/utils/color.dart';
import 'package:uday_bharat/utils/cutom_text.dart';
import 'package:uday_bharat/utils/progress_bar.dart';
import 'package:uday_bharat/utils/shadow_container.dart';
import 'package:uday_bharat/utils/size.dart';
import 'package:uday_bharat/utils/toast_msg.dart';
import '../../provider/model/get_cart_model.dart';
import '../../widgets/empty_cart.dart';
import 'address_bottomsheet.dart';
import 'order_place_dilogue.dart';
import 'order_time_validation_widget.dart';

class AppStyle {
  static const Color primary = Color(0xFF0BB7A4);
  static const Color accentDark = Color(0xFF1F3A2D);
  static const Color cardBg = Color(0xFFF8FAFB);
  static const double cardRadius = 16.0;
}

class CartCheckoutScreen extends StatefulWidget {
  const CartCheckoutScreen({super.key});
  @override
  State<CartCheckoutScreen> createState() => _CartCheckoutScreenState();
}

class _CartCheckoutScreenState extends State<CartCheckoutScreen> {
  bool isFirst = true;
  @override
  void initState() {
    super.initState();
    deliveryShadule = '';
    fetchCart();
  }

  void fetchCart() async {
    Future.microtask(() async {
      final getCart = Provider.of<CartViewModel>(context, listen: false);
      await getCart.getCartApi(context);
      await getCart.getCouponApi();
      getCart.isWalletApply = false;
    });
  }

  String deliveryShadule = '';
  @override
  Widget build(BuildContext context) {
    MyFontSize fontSize = MyFontSize(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        centerTitle: true,
        toolbarHeight: fontSize.h * 0.05,
        title: const CustomText('Cart', fontWeight: FontWeight.w600),
      ),
      body: Consumer<CartViewModel>(
        builder: (context, cartValue, child) {
          final getCart = cartValue.getCartRes.data;
          final isLoading = cartValue.isLoading;
          final cartItems = cartValue.getCartRes.data?.cartItemsList ?? [];
          print('-----------------------${getCart?.orderTimingStatus}');
          if (isFirst) {
            if (isLoading) {
              isFirst = false;
              return const Center(child: CartCheckoutShimmer());
            }
          }
          if (cartItems.isEmpty) {
            return EmptyCartWidget();
          }
          return RefreshIndicator(
            color: AppColors.appColor,
            onRefresh: () {
              return Provider.of<CartViewModel>(
                context,
                listen: false,
              ).getCartApi(context);
            },
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 100),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        cartValue.isLoading
                            ? RoundedLinearProgress(
                                width: 100,
                                strokeWidth: 3.0,
                                bgColor: Colors.blue,
                                fgColor: Colors.white,
                                duration: Duration(seconds: 2),
                              )
                            : SizedBox(),
                        const SizedBox(height: 12),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              cartValue.getCouponRes.data?.length ?? 0,
                              (index) {
                                final coupon =
                                    cartValue.getCouponRes.data?[index];
                                // Convert min order -> double
                                final minOrder =
                                    double.tryParse(
                                      coupon?.minOrderValue ?? "0",
                                    ) ??
                                    0;
                                // Convert current cart total -> double
                                final cartTotal =
                                    double.tryParse(
                                      getCart?.netGrandTotal ?? "0",
                                    ) ??
                                    0;
                                // Check if coupon already applied
                                final isApplied =
                                    getCart?.couponCode == coupon?.couponCode &&
                                    getCart?.couponApplyStatus == '1';
                                // Eligibility Check
                                final isEligible =
                                    cartTotal >= minOrder || isApplied;
                                return InkWell(
                                  onTap: isEligible
                                      ? () {
                                          /// APPLY / REMOVE LOGIC
                                          cartValue.getCartApi(
                                            context,
                                            coupon: isApplied
                                                ? ''
                                                : coupon?.couponCode,
                                          );
                                        }
                                      : null,
                                  child: Opacity(
                                    opacity: isEligible ? 1.0 : 0.4,
                                    child: ShadowContainer(
                                      width: fontSize.w / 1.1,
                                      color: isApplied
                                          ? AppColors.greenColor
                                          : AppColors.white,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Image.asset(
                                            'assets/discount.png',
                                            height: 20,
                                            color: isApplied
                                                ? AppColors.white
                                                : AppColors.greenColor,
                                          ),
                                          SizedBox(width: 12),
                                          SizedBox(
                                            width: fontSize.w / 1.8,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                  coupon?.description ?? '',
                                                  color: isApplied
                                                      ? AppColors.white
                                                      : AppColors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                CustomText(
                                                  'Code: ${coupon?.couponCode ?? ''}',
                                                  fontSize: 12,
                                                  color: isApplied
                                                      ? AppColors.white
                                                      : AppColors.grey,
                                                ),
                                              ],
                                            ),
                                          ),

                                          /// APPLY / REMOVE Button
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 5,
                                              vertical: 3,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColors.appColor,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: CustomText(
                                              isApplied ? 'REMOVE' : 'APPLY',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        if (getCart?.walletBalance != '0.00' &&
                            getCart?.walletBalance != '0')
                          WalletUnlockProgressBar(
                            currentAmount:
                                double.tryParse(getCart?.totalAmount ?? '0') ??
                                0,
                            minAmount:
                                double.tryParse(
                                  getCart?.walletMinOrderAmount ?? '100',
                                ) ??
                                100,
                            fullAmount:
                                double.tryParse(
                                  getCart?.walletFullApplyAmount ?? '199',
                                ) ??
                                199,
                            partialWalletAmount:
                                double.tryParse(
                                  getCart?.walletPartialApplyAmount ?? '50',
                                ) ??
                                50,
                            walletMessage: getCart?.walletMessage,
                          ),

                        SizedBox(height: 10),
                        ShadowContainer(
                          child: Column(
                            children: [
                              Column(
                                children: List.generate(
                                  getCart?.cartItemsList?.length ?? 0,
                                  (index) {
                                    final getCartList =
                                        getCart?.cartItemsList?[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 12,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // product image
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                            child: Container(
                                              color: Colors.grey.shade100,
                                              width: 50,
                                              height: 50,
                                              child: CustomNetworkImage(
                                                imageUrl:
                                                    getCartList?.productImage ??
                                                    '',
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                  getCartList?.productName ??
                                                      '',
                                                  fontSize: 10,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                const SizedBox(height: 6),
                                                CustomText(
                                                  '${getCartList?.quantity}${getCartList?.volume ?? ''}',
                                                  color: AppColors.grey,
                                                  fontSize: 10,
                                                ),
                                              ],
                                            ),
                                          ),

                                          // qty selector & price
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              AddToCartWidget(
                                                value: int.parse(
                                                  getCartList?.cartQty ?? "0",
                                                ),
                                                stockStatus:
                                                    getCartList?.stockStatus ??
                                                    "0",
                                                itemImage: '',
                                                productId:
                                                    getCartList?.id
                                                        .toString() ??
                                                    '',
                                                status: 'cart',
                                              ),
                                              const SizedBox(height: 8),
                                              CustomText(
                                                '₹${getCartList?.totalAmt ?? ''}',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 10),
                        // Bill details
                        ShadowContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                'Bill details',
                                fontWeight: FontWeight.w700,
                              ),
                              const SizedBox(height: 12),
                              _billRow(
                                'Items total',
                                '₹${getCart?.totalAmount ?? '0'}',
                              ),
                              const SizedBox(height: 8),
                              _billRow(
                                'Delivery charge',
                                '₹${getCart?.deliveryCharge ?? '0'}',
                              ),
                              const SizedBox(height: 8),
                              _billRow(
                                'Handling charge',
                                '₹${getCart?.handlingCharge ?? '0'}',
                              ),
                              const SizedBox(height: 10),
                              const Divider(),
                              const SizedBox(height: 8),
                              _billRowBold(
                                'Grand total',
                                '₹${getCart?.netGrandTotal ?? '0'}',
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        deliveryShadule != ''
                            ? InkWell(
                                onTap: () async {
                                  deliveryShadule = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          const ScheduleDeliveryPage(),
                                    ),
                                  );
                                  setState(() {});
                                },
                                child: ShadowContainer(
                                  color: AppColors.appColor.withOpacity(0.5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText('Delivery schedule'),
                                      Row(
                                        children: [
                                          Icon(Iconsax.watch),
                                          CustomText(deliveryShadule),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox(),
                        SizedBox(height: 10),
                        // Cancellation policy
                        ShadowContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              CustomText(
                                'Cancellation Policy',
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(height: 8),
                              CustomText(
                                fontSize: 10,
                                'Orders cannot be cancelled once packed for delivery. In case of unexpected delays, a refund will be provided, if applicable.',
                                color: Colors.black54,
                                height: 1.35,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    if (cartValue.showCouponAnimation)
                      Center(
                        child: SizedBox(
                          height: fontSize.h / 5,
                          width: fontSize.w / 1.5,
                          child: Lottie.asset(
                            "assets/apply_couponsuccess.json",
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      // bottom nav + checkout
      bottomNavigationBar: Consumer<CartViewModel>(
        builder: (context, value, child) {
          final double minAmount =
              double.tryParse(
                value.getCartRes.data?.walletMinOrderAmount ?? '0',
              ) ??
              0;

          final double netTotal =
              double.tryParse(value.getCartRes.data?.totalAmount ?? '0') ?? 0;

          final cartItems = value.getCartRes.data?.cartItemsList ?? [];
          List<UserAddressList> allAddresses =
              value.getCartRes.data?.userAddressList ?? [];
          UserAddressList? defaultAddress =
              allAddresses.where((e) => e.isDefault == "1").toList().isNotEmpty
              ? allAddresses.where((e) => e.isDefault == "1").first
              : null;
          UserAddressList? addressType =
              allAddresses.where((e) => e.isDefault == "1").toList().isNotEmpty
              ? allAddresses.where((e) => e.isDefault == "1").first
              : null;
          return cartItems.isEmpty
              ? SizedBox(height: 0)
              : BottomAppBar(
                  height: fontSize.h / 4.8,
                  elevation: 8,
                  color: Colors.white,
                  child: Column(
                    children: [
                      /// select address
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            backgroundColor: AppColors.bgColor,
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (_) => const AddressBottomSheet(),
                          );
                        },
                        child: SafeArea(
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: AppColors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                const Icon(Iconsax.location, size: 14),
                                const SizedBox(width: 6),

                                defaultAddress == null
                                    ? Expanded(
                                        child: CustomText(
                                          "Add New Address",
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        ),
                                      )
                                    : Row(
                                        children: [
                                          /// Address type (Home/Office etc.)
                                          // CustomText(
                                          //   addressType?.addressType ?? '',
                                          //   fontWeight: FontWeight.w600,
                                          //   fontSize: 12,
                                          // ),
                                          SizedBox(width: fontSize.w * 0.02),

                                          /// Address Line
                                          SizedBox(
                                            width: fontSize.w / 1.4,
                                            child: CustomText(
                                              value.selectedAddress ?? '',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                const Icon(Icons.keyboard_arrow_down_sharp),
                              ],
                            ),
                          ),
                        ),
                      ),

                      ///select wallet amount
                      if (value.getCartRes.data?.walletBalance != '0.00' &&
                          value.getCartRes.data?.walletBalance != '0')
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: netTotal > minAmount
                                ? AppColors.greenLightColor.withOpacity(0.6)
                                : AppColors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Visibility(
                                visible: netTotal > minAmount,
                                child: SizedBox(
                                  width: 12,
                                  height: 12,
                                  child: Checkbox(
                                    activeColor: AppColors.greenColor,
                                    shape: ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    value: value.isWalletApply,
                                    onChanged: (chatValue) {
                                      value.setIsWallet(chatValue);
                                      if (chatValue == true) {
                                        value.getCartApi(
                                          context,
                                          isWallet: '1',
                                        );
                                      } else {
                                        value.getCartApi(
                                          context,
                                          isWallet: '0',
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(width: fontSize.w * 0.03),
                              CustomText(
                                'Wallet Amount',
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: netTotal > minAmount
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                              Spacer(),
                              CustomText(
                                '₹${value.getCartRes.data?.walletBalance}',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: netTotal > minAmount
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ],
                          ),
                        ),

                      Row(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/cashless-payment.png',
                                height: 40,
                              ),
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                    ),
                                    builder: (_) => PaymentSelectBottomSheet(),
                                  );
                                },
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        CustomText(
                                          "PAYING VIA",
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.grey,
                                        ),
                                        Icon(Icons.arrow_drop_down_sharp),
                                      ],
                                    ),
                                    CustomText(
                                      value.selectedPaymentMethod,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.only(
                              right: 14.0,
                              top: 12,
                              bottom: 12,
                            ),
                            child: value.isCreateBookingLoading
                                ? Center(
                                    child: CustomProgressBar(
                                      color: AppColors.appColor,
                                    ),
                                  )
                                : InkWell(
                                    onTap: () async {
                                      final getCartData = value.getCartRes.data;
                                      print(
                                        'orderTimingStatus---------------------------${getCartData?.orderTimingStatus}',
                                      );

                                      int orderTimingStatus =
                                          int.tryParse(
                                            getCartData?.orderTimingStatus ??
                                                '0',
                                          ) ??
                                          0;
                                      // ---------------- SCHEDULE REQUIRED FLOW ----------------
                                      if (orderTimingStatus == 0 &&
                                          deliveryShadule == '') {
                                        deliveryShadule = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                const ScheduleDeliveryPage(),
                                          ),
                                        );
                                        setState(() {});
                                        debugPrint(
                                          'Schedule Result => $deliveryShadule',
                                        );
                                        if (deliveryShadule == '') {
                                          Utils.toastMessage(
                                            'Please select delivery time',
                                          );
                                        }
                                        return;
                                      }
                                      final userProfile =
                                          Provider.of<HomeProvider>(
                                            context,
                                            listen: false,
                                          ).usrProfileRes.userProfile;
                                      if (defaultAddress == null) {
                                        Utils.toastMessage(
                                          'Please add Your delivery Address',
                                        );
                                        return;
                                      }
                                      if (value.selectedAddress == '' ||
                                          value.selectedAddress == null) {
                                        Utils.toastMessage(
                                          'Please select your delivery address',
                                        );
                                        return;
                                      }
                                      if (value.selectedPaymentMethod ==
                                          'COD') {
                                        value.createBookingApi(
                                          context,
                                          userAddressId:
                                              value.selectedAddressId ?? '',
                                          paymentMethod: "COD",
                                          couponCode:
                                              getCartData?.couponApplyStatus ==
                                                  '1'
                                              ? getCartData?.couponCode ?? ''
                                              : '',
                                          deliveryCharge:
                                              getCartData?.deliveryCharge == '0'
                                              ? ''
                                              : getCartData?.deliveryCharge ??
                                                    '',
                                          discountValue:
                                              getCartData?.discountValue == '0'
                                              ? ''
                                              : getCartData?.discountValue ??
                                                    '',
                                          netGrandTotal:
                                              getCartData?.netGrandTotal ?? "",
                                          transactionId: 'null',
                                          walletAppliedAmount:
                                              getCartData
                                                      ?.walletAmtApplyStatus ==
                                                  '0'
                                              ? ''
                                              : getCartData
                                                        ?.walletAppliedAmount ??
                                                    '',
                                          isSchedule:
                                              getCartData?.orderTimingStatus ??
                                              '',
                                          scheduledAt: deliveryShadule
                                              .toString(),
                                        );
                                      } else {
                                        Provider.of<PaymentProvider>(
                                          context,
                                          listen: false,
                                        ).openCheckout(
                                          context: context,
                                          addressId:
                                              value.selectedAddressId ?? '',
                                          amount:
                                              getCartData?.netGrandTotal ?? '0',
                                          couponCode:
                                              getCartData?.couponApplyStatus ==
                                                  '1'
                                              ? getCartData?.couponCode ?? ''
                                              : '',
                                          deliveryCharge:
                                              getCartData?.deliveryCharge == '0'
                                              ? ''
                                              : getCartData?.deliveryCharge ??
                                                    '',
                                          discountValue:
                                              getCartData?.discountValue == '0'
                                              ? ''
                                              : getCartData?.discountValue ??
                                                    '',
                                          netGrandTotal:
                                              getCartData?.netGrandTotal ?? '',
                                          walletAppliedAmount:
                                              getCartData
                                                      ?.walletAmtApplyStatus ==
                                                  '0'
                                              ? ''
                                              : getCartData
                                                        ?.walletAppliedAmount ??
                                                    '',
                                          name: "Ziplymart",
                                          number: userProfile?.mobileNo ?? '',
                                          isSchedule:
                                              getCartData?.orderTimingStatus ??
                                              '',
                                          scheduledAt: deliveryShadule ?? '',
                                        );
                                      }
                                    },

                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppStyle.primary,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: CustomText(
                                        'Order Place',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
  // widget for product row

  Widget _billRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(label, fontSize: 13),
        CustomText(value, fontSize: 13),
      ],
    );
  }

  Widget _billRowBold(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(label, fontWeight: FontWeight.w700),
        CustomText(value, fontSize: 16, fontWeight: FontWeight.w700),
      ],
    );
  }
}

class PaymentSelectBottomSheet extends StatelessWidget {
  const PaymentSelectBottomSheet({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartViewModel>(context, listen: false);
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        color: AppColors.bgColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 45,
                height: 5,
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const CustomText(
              "Select Payment Method",
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 20),
            // ✔ Online
            PaymentOptionTile(
              title: "COD Payment",
              icon: Icons.currency_rupee,
              onTap: () {
                provider.setPaymentMethod("COD");
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 12),
            PaymentOptionTile(
              title: "Online Payment",
              icon: Icons.phone_android,
              onTap: () {
                provider.setPaymentMethod("ONLINE");
                Navigator.pop(context);
              },
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
