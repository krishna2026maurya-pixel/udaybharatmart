// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:provider/provider.dart';
// import 'package:uday_bharat/user_screen/provider/view_model/cart_view_model.dart';
// import 'package:uday_bharat/user_screen/provider/view_model/payment_provider.dart';
// import 'package:uday_bharat/user_screen/widgets/shimmer/checkout_process_shimmer.dart';
// import 'package:uday_bharat/utils/color.dart';
// import 'package:uday_bharat/utils/custom_button.dart';
// import 'package:uday_bharat/utils/cutom_text.dart';
// import 'package:uday_bharat/utils/shadow_container.dart';
// import 'add_new_address_screen.dart';
//
// class CheckoutProcessScreen extends StatefulWidget {
//   const CheckoutProcessScreen({super.key});
//   @override
//   State<CheckoutProcessScreen> createState() => _CheckoutProcessScreenState();
// }
//
// class _CheckoutProcessScreenState extends State<CheckoutProcessScreen> {
//   bool showOtherAddresses = false;
//   final List<String> paymentMethods = [
//     "Online",
//     "Wallet Balance (Rs.)",
//     "Cash on Delivery",
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() {
//       final cartVM = Provider.of<CartViewModel>(context, listen: false);
//       cartVM.getCheckoutApi().then((value) {
//         final getData = cartVM.getCheckOutRes.data;
//         final defaultAddress = getData?.userAddressList
//             ?.where((e) => e.isDefault == "1")
//             .firstOrNull;
//         if (defaultAddress != null) {
//           setState(() {
//             cartVM.selectedAddressId = defaultAddress.id;
//             cartVM.selectedAddress = defaultAddress.addressType;
//           });
//         }
//       });
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const CustomText("Complete Checkout", fontWeight: FontWeight.w600),
//         backgroundColor: AppColors.white,
//       ),
//
//       body: Consumer<CartViewModel>(builder: (context, provider, child) {
//         final getData = provider.getCheckOutRes.data;
//
//         if (provider.isLoading) {
//           return const Center(child: CheckoutProcessShimmer());
//         }
//
//         return SingleChildScrollView(
//           padding: const EdgeInsets.all(10),
//           child: Column(
//             children: [
//               // ---------------- ADDRESS SECTION ----------------
//               ShadowContainer(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const CustomText("Select Delivery Address",
//                         fontWeight: FontWeight.bold, fontSize: 15),
//                     const SizedBox(height: 10),
//
//                     if (provider.selectedAddressId != null)
//                       RadioListTile<String>(
//                         dense: true,
//                         visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
//                         contentPadding: EdgeInsets.zero,
//                         controlAffinity: ListTileControlAffinity.leading,
//                         value: provider.selectedAddressId!,
//                         groupValue: provider.selectedAddressId,
//                         onChanged: (_) {},
//                         title: CustomText(
//                           getData!.userAddressList!
//                               .firstWhere((e) => e.id == provider.selectedAddressId)
//                               .gpsAddress
//                               .toString(),
//                           fontSize: 12,
//                         ),
//                         activeColor: AppColors.appColor,
//                       ),
//
//                     GestureDetector(
//                       onTap: () {
//                         setState(() => showOtherAddresses = !showOtherAddresses);
//                       },
//                       child: Row(
//                         children: [
//                           const SizedBox(width: 15),
//                           CustomText(
//                             showOtherAddresses
//                                 ? "Hide other addresses"
//                                 : "Change / Select Other Address",
//                             color: AppColors.appColor,
//                             fontWeight: FontWeight.w600,
//                           ),
//                           Icon(
//                             showOtherAddresses ? Icons.expand_less : Icons.expand_more,
//                             color: AppColors.appColor,
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     if (showOtherAddresses)
//                       ...List.generate(getData?.userAddressList?.length??0, (index) {
//                         final addr = getData?.userAddressList![index];
//                         if (addr?.id == provider.selectedAddressId) return const SizedBox.shrink();
//
//                         return RadioListTile<String>(
//                           dense: true,
//                           visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
//                           value: addr?.id ?? '',
//                           groupValue: provider.selectedAddressId,
//                           onChanged: (val) {
//                             setState(() {
//                               provider.selectedAddressId = val;
//                               provider.selectedAddress = addr?.addressType ?? '';
//                               provider.selectedUserName = addr?.addressName ?? '';
//                               provider.selectedUserNumber = addr?.addressMobileNumber ?? '';
//                               showOtherAddresses = false;
//                             });
//                           },
//                           title: CustomText(
//                             '${addr?.addressType ?? ''} '
//                                 '${addr?.landmark ?? ''} '
//                                 '${addr?.street ?? ''}, '
//                                 '${addr?.city ?? ''}',
//                             fontSize: 12,
//                           ),
//                           activeColor: AppColors.appColor,
//                         );
//                       }),
//
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: TextButton.icon(
//                         onPressed: () async {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const AddNewAddressScreen(),
//                             ),
//                           );
//                         },
//                         icon: const Icon(Icons.add_location_alt_outlined,
//                             color: AppColors.appColor),
//                         label: const CustomText(
//                           "Add New Address",
//                           color: AppColors.appColor,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 10),
//
//               // ---------------- PAYMENT SECTION ----------------
//               ShadowContainer(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const CustomText("Select Payment Method",
//                         fontWeight: FontWeight.bold, fontSize: 15),
//
//                     // ------- 🔥 Wallet Beautiful UI Added BELOW -------
//                     _walletSection(provider),
//                     // --------------------------------------------------
//
//                     ...paymentMethods.map((pay) {
//                       return pay == "Wallet Balance (Rs.)"
//                           ? const SizedBox()
//                           : SizedBox(
//                         height: 35,
//                         child: RadioListTile<String>(
//                           value: pay,
//                           groupValue: provider.selectedPayment,
//                           onChanged: (val) {
//                             setState(() {
//                               provider.selectedPayment = val;
//                             });
//                           },
//                           title: CustomText(pay, fontSize: 14),
//                           contentPadding: EdgeInsets.zero,
//                           controlAffinity: ListTileControlAffinity.leading,
//                           activeColor: AppColors.appColor,
//                         ),
//                       );
//                     }),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 10),
//
//               // ---------------- ORDER SUMMARY ----------------
//               ShadowContainer(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const CustomText("Order Summary",
//                         fontWeight: FontWeight.bold, fontSize: 15),
//                     const SizedBox(height: 8),
//                     _summaryRow("Item total", "₹${getData?.totalAmount}"),
//                     _summaryRow("Delivery fee", "₹${getData?.deliveryCharge}"),
//                     _summaryRow("Handling fee", "₹${getData?.handlingCharge}"),
//                     const Divider(),
//                     _summaryRow("Grand Total", "₹${getData?.grandTotal ?? 0}",
//                         bold: true),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       }),
//
//       // ---------------- PLACE ORDER BUTTON ----------------
//       bottomNavigationBar:
//       Consumer<CartViewModel>(builder: (context, provider, child) {
//         return SafeArea(
//           child:
//           Consumer<PaymentProvider>(builder: (context, paymentProvider, _) {
//             final getData = provider.getCheckOutRes.data;
//
//             return BottomAppBar(
//               color: AppColors.white,
//               child: CustomButton(
//                 isLoading: provider.isCreateBookingLoading,
//                 title: "Place Order",
//                 onPressed: () {
//                   if (provider.selectedPayment == null) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                           content: Text("Please select payment method")),
//                     );
//                     return;
//                   }
//
//                   // COD
//                   if (provider.selectedPayment == "COD Payment") {
//                     provider.createBookingApi(
//                       context,
//                       userAddressId: provider.selectedAddressId ?? '',
//                       paymentMethod: "COD",
//                     );
//                   }
//
//                   // ONLINE PAYMENT
//                   else if (provider.selectedPayment == "Online Payment") {
//                     paymentProvider.openCheckout(
//                       context: context,
//                       amount: getData?.grandTotal.toString() ?? "0",
//                       name: provider.selectedUserName.toString(),
//                       number: provider.selectedUserNumber.toString(),
//                     );
//                   }
//
//                   // WALLET PAYMENT
//                   else if (provider.selectedPayment == "Wallet") {
//                   //  provider?.walletPay(context);
//                   }
//                 },
//               ),
//             );
//           }),
//         );
//       }),
//     );
//   }
//
//   // ---------------- WALLET UI WIDGET ----------------
//   Widget _walletSection(CartViewModel provider) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           provider.selectedPayment = "Wallet";
//         });
//       },
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 6),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Color(0xffF1F9FF),
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: provider.selectedPayment == "Wallet"
//                 ? AppColors.appColor
//                 : Colors.grey.shade300,
//           ),
//         ),
//         child: Row(
//           children: [
//             Icon(Iconsax.wallet,
//                 color: provider.selectedPayment == "Wallet"
//                     ? AppColors.appColor
//                     : Colors.black54),
//             const SizedBox(width: 10),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CustomText("Wallet Balance",
//                       fontWeight: FontWeight.bold, fontSize: 14),
//                   CustomText("₹500",
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.grey),
//                 ],
//               ),
//             ),
//             Radio<String>(
//               value: "Wallet",
//               groupValue: provider.selectedPayment,
//               activeColor: AppColors.appColor,
//               onChanged: (v) {
//                 setState(() => provider.selectedPayment = v);
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
//   Widget _summaryRow(String label, String value, {bool bold = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           CustomText(label,
//               color: AppColors.grey,
//               fontWeight: bold ? FontWeight.bold : FontWeight.w500),
//           CustomText(value,
//               fontWeight: bold ? FontWeight.bold : FontWeight.w500),
//         ],
//       ),
//     );
//   }
//
// }
