import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uday_bharat/utils/color.dart';
import 'package:uday_bharat/utils/cutom_text.dart';
import 'package:uday_bharat/vendor_screen/dashboard/add_product/add_product.dart';
import 'package:uday_bharat/vendor_screen/dashboard/profile/edit_vendor_profile.dart';
import 'package:uday_bharat/vendor_screen/vendor_provider/view_model/auth_provider.dart';
import 'package:uday_bharat/vendor_screen/vendor_provider/view_model/product_view_model.dart';
import 'package:uday_bharat/vendor_screen/vendor_provider/view_model/profile_view_model.dart';

import '../../utils/session.dart';
import '../../utils/toast_msg.dart';
import '../auth/login.dart';
import 'added_products/product_list_screen.dart';

class VendorBottomSheet {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _VendorBottomSheetContent(),
    );
  }
}

class _VendorBottomSheetContent extends StatefulWidget {
  const _VendorBottomSheetContent();

  @override
  State<_VendorBottomSheetContent> createState() => _VendorBottomSheetContentState();
}

class _VendorBottomSheetContentState extends State<_VendorBottomSheetContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    Provider.of<ProfileViewModel>(context, listen: false).getVendorProfileApi(context);
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      );
      _slideAnimation =
          Tween(begin: const Offset(0, 1), end: Offset.zero).animate(CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOutCubic,
          ));
      _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey.shade50,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.1),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomText(
                title,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final shopImage = "https://cdn-icons-png.flaticon.com/512/2972/2972185.png";


    return Consumer<ProductViewModel>(builder: (context, provider, child) {
      final profile = provider.getVendorDashboardRes;
      return SlideTransition(
        position: _slideAnimation,
        child: DraggableScrollableSheet(
          initialChildSize: 0.85,
          maxChildSize: 0.95,
          minChildSize: 0.6,
          expand: false,
          builder: (_, controller) => Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: ListView(
              controller: controller,
              children: [
                /// 🏪 Shop Info
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder:  (context) => EditVendorProfileScreen(),));
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      gradient: const LinearGradient(
                        colors: [
                          AppColors.appColor,
                          AppColors.lightAppColor
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            shopImage,
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                  profile.data?.vendorDetails?.shopName??'',
                                  fontSize: 18, fontWeight: FontWeight.bold
                              ),
                              const SizedBox(height: 4),
                              CustomText(
                                  profile.data?.vendorDetails?.fullName??'',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                /// 🧺 Product Section
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                          "🛒 Product Section",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87
                      ),
                      const SizedBox(height: 10),
                      // _buildActionTile(
                      //     icon: Icons.add_box_rounded,
                      //     title: "Add Product",
                      //     color: AppColors.lightAppColor,
                      //     onTap: () {
                      //       final getData=   Provider.of<ProductViewModel>(context,listen: false).getVendorDashboardRes.data?.vendorDetails;
                      //       if(getData?.isVerified=='0'){
                      //         Utils.toastMessage('Your account is under review. Once the admin approves your profile, you will start add Product. Thank you for your patience.');
                      //       }else{
                      //         Navigator.push(context, MaterialPageRoute(builder: (context) => AddProductScreen()));
                      //       }
                      //     }
                      // ),
                      _buildActionTile(
                          icon: Icons.list_alt_rounded,
                          title: "Product List",
                          color: Colors.blue,
                          onTap: () =>Navigator.push(context, MaterialPageRoute(builder: (context) => VendorProductListScreen()))
                      ),

                      const SizedBox(height: 20),

                      /// 💰 Sales Section
                       // const CustomText(
                      //     "💰 Sales",
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.w700,
                      //     color: Colors.black87
                      // ),
                      // const SizedBox(height: 10),
                      //
                      // _buildActionTile(
                      //   icon: Icons.cancel_rounded,
                      //   title: "Cancel Order",
                      //   color: Colors.red,
                      //   onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(content: Text("Cancel Order clicked")),
                      //   ),
                      // ),
                      Consumer<VendorAuthProvider>(builder: (context, value, child) {
                        return _buildActionTile(
                          icon: Icons.logout_rounded,
                          title: "Logout",
                          color: Colors.red,
                          onTap: ()async {
                            await MySharedPreferences.setVendorId('');
                            Utils.toastMessage('Successfully logout');
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => VendorLoginScreen()));
                           // value.vendorLogoutApi(context);
                          },
                        );
                      },)
                    ],),
                )
              ],
            ),
          ),
        ),
      );
    },);
  }
}
