// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:uday_bharat/utils/color.dart';
// import 'package:uday_bharat/utils/cutom_text.dart';
// import 'package:uday_bharat/utils/cache_image.dart';
// import 'package:lottie/lottie.dart';
// import 'package:uday_bharat/vendor_screen/dashboard/profile/edit_vendor_profile.dart';
// import 'package:uday_bharat/vendor_screen/vendor_provider/view_model/profile_view_model.dart';
//
// class VendorProfileScreen extends StatefulWidget {
//   const VendorProfileScreen({super.key});
//
//   @override
//   State<VendorProfileScreen> createState() => _VendorProfileScreenState();
// }
//
// class _VendorProfileScreenState extends State<VendorProfileScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//     Future.microtask(() =>   Provider.of<ProfileViewModel>(context, listen: false).getVendorProfileApi(context));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       appBar: AppBar(
//         backgroundColor: AppColors.appColor,
//         title: const CustomText("Vendor Profile",
//             color: Colors.white, fontWeight: FontWeight.w500),
//         centerTitle: true,
//       ),
//       body: Consumer<ProfileViewModel>(builder: (context, provider, child) {
//         final getProfile = provider.getProfileRes.data;
//         return SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           child: Column(
//             children: [
//               // 🔹 Profile Header
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: AppColors.appColor,
//                   borderRadius: const BorderRadius.only(
//                     bottomLeft: Radius.circular(25),
//                     bottomRight: Radius.circular(25),
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     Stack(
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => EditVendorProfileScreen(
//                                 ),
//                               ),
//                             );
//                           },
//                           child: CircleAvatar(
//                             radius: 45,
//                             backgroundColor: Colors.white,
//                             child: ClipOval(
//                               child: CustomNetworkImage(
//                                 imageUrl:
//                                 getProfile?.shopImage.toString(),
//                                 height: 85,
//                                 width: 85,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           bottom: 0,
//                           right: 0,
//                           child: Container(
//                             padding: const EdgeInsets.all(3),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               shape: BoxShape.circle,
//                             ),
//                             child: const Icon(Icons.edit,
//                                 color: Colors.blueAccent, size: 18),
//                           ),
//                         )
//                       ],
//                     ),
//                     const SizedBox(height: 10),
//                      CustomText(getProfile?.shopName??'',
//                         fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
//                      CustomText(getProfile?.address??'',
//                         fontSize: 14, color: Colors.white70),
//                     CustomText(getProfile?.mobileNumber??'',
//                         fontSize: 14, color: Colors.white70),
//                     const SizedBox(height: 10),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Icon(Icons.star, color: Colors.yellow, size: 18),
//                         const SizedBox(width: 5),
//                         const CustomText("4.8 (230 reviews)",
//                             color: Colors.white, fontSize: 13),
//                       ],
//                     ),
//                     const SizedBox(height: 15),
//                   ],
//                 ),
//               ),
//
//               // 🔹 Stats Cards
//               Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     _buildStatCard("Products", "120", Icons.inventory_2, Colors.blue),
//                     _buildStatCard("Sales", "₹45.3K", Icons.shopping_bag, Colors.green),
//                     _buildStatCard("Balance", "₹12,400", Icons.account_balance_wallet,
//                         Colors.purple),
//                   ],
//                 ),
//               ),
//
//               // // 🔹 Action Buttons
//               // Padding(
//               //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               //   child: Row(
//               //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               //     children: [
//               //       _actionButton(Icons.edit, "Edit Profile", Colors.orange),
//               //       _actionButton(Icons.add_box, "Add Product", Colors.green),
//               //       _actionButton(Icons.wallet, "Withdraw", Colors.blue),
//               //     ],
//               //   ),
//               // ),
//               //
//               // const SizedBox(height: 20),
//               //
//               // // 🔹 Tab Section
//               // Container(
//               //   margin: const EdgeInsets.symmetric(horizontal: 12),
//               //   decoration: BoxDecoration(
//               //     color: Colors.white,
//               //     borderRadius: BorderRadius.circular(12),
//               //     boxShadow: [
//               //       BoxShadow(
//               //           color: Colors.black12, blurRadius: 4, offset: const Offset(0, 2))
//               //     ],
//               //   ),
//               //   child: Column(
//               //     children: [
//               //       TabBar(
//               //         controller: _tabController,
//               //         labelColor: AppColors.appColor,
//               //         unselectedLabelColor: Colors.grey,
//               //         indicatorColor: AppColors.appColor,
//               //         tabs: const [
//               //           Tab(text: "Products"),
//               //           Tab(text: "Orders"),
//               //           Tab(text: "Reviews"),
//               //         ],
//               //       ),
//               //       SizedBox(
//               //         height: size.height * 0.45,
//               //         child: TabBarView(
//               //           controller: _tabController,
//               //           children: [
//               //             _buildProductsTab(),
//               //             _buildOrdersTab(),
//               //             _buildReviewsTab(),
//               //           ],
//               //         ),
//               //       ),
//               //     ],
//               //   ),
//               // ),
//             ],
//           ),
//         );
//       },)
//     );
//   }
//
//   // 📦 Product Tab
//   Widget _buildProductsTab() {
//     return ListView.builder(
//       itemCount: 3,
//       padding: const EdgeInsets.all(10),
//       itemBuilder: (context, index) {
//         return Card(
//           margin: const EdgeInsets.symmetric(vertical: 6),
//           elevation: 2,
//           shape:
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           child: ListTile(
//             leading: ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: CustomNetworkImage(
//                 imageUrl:
//                 "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBDwL01_EkkC0Zct9gqzEnL_uLB-YwOE5pPg&usqp=CAU",
//                 height: 60,
//                 width: 60,
//               ),
//             ),
//             title: CustomText("Chocolate Truffle Cake", fontWeight: FontWeight.w500),
//             subtitle: CustomText("₹499 • 1kg", color: Colors.grey.shade600),
//             trailing: const Icon(Icons.chevron_right),
//           ),
//         );
//       },
//     );
//   }
//
//   // 📦 Orders Tab
//   Widget _buildOrdersTab() {
//     return ListView.builder(
//       padding: const EdgeInsets.all(10),
//       itemCount: 3,
//       itemBuilder: (context, index) {
//         return Card(
//           margin: const EdgeInsets.symmetric(vertical: 6),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           child: ListTile(
//             leading: Lottie.asset('assets/order.json', height: 40),
//             title: const CustomText("Order #2456", fontWeight: FontWeight.w500),
//             subtitle: const CustomText("Delivered • ₹1,299", color: Colors.green),
//             trailing: const Icon(Icons.chevron_right),
//           ),
//         );
//       },
//     );
//   }
//
//   // ⭐ Reviews Tab
//   Widget _buildReviewsTab() {
//     return ListView.builder(
//       padding: const EdgeInsets.all(10),
//       itemCount: 3,
//       itemBuilder: (context, index) {
//         return Card(
//           margin: const EdgeInsets.symmetric(vertical: 6),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           child: ListTile(
//             leading: const CircleAvatar(
//               backgroundImage: NetworkImage(
//                   "https://cdn-icons-png.flaticon.com/512/147/147142.png"),
//             ),
//             title: const CustomText("Amit Sharma"),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: const [
//                 Row(
//                   children: [
//                     Icon(Icons.star, color: Colors.amber, size: 16),
//                     Icon(Icons.star, color: Colors.amber, size: 16),
//                     Icon(Icons.star, color: Colors.amber, size: 16),
//                     Icon(Icons.star, color: Colors.amber, size: 16),
//                     Icon(Icons.star_half, color: Colors.amber, size: 16),
//                   ],
//                 ),
//                 CustomText("The cake was really fresh and delicious!",
//                     color: Colors.black87, fontSize: 13),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildStatCard(String title, String value, IconData icon, Color color) {
//     return Container(
//       width: 100,
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black12, blurRadius: 4, offset: const Offset(0, 2))
//         ],
//       ),
//       child: Column(
//         children: [
//           Icon(icon, color: color, size: 30),
//           const SizedBox(height: 5),
//           CustomText(value, fontSize: 16, fontWeight: FontWeight.w600),
//           CustomText(title, fontSize: 13, color: Colors.grey.shade600),
//         ],
//       ),
//     );
//   }
//
//   Widget _actionButton(IconData icon, String label, Color color) {
//     return ElevatedButton.icon(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: color,
//         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       ),
//       icon: Icon(icon, color: Colors.white, size: 16),
//       label: CustomText(label, color: Colors.white, fontSize: 10),
//       onPressed: () {
//         Navigator.push(context,MaterialPageRoute(builder: (context) => EditVendorProfileScreen()));
//       },
//     );
//   }
// }
