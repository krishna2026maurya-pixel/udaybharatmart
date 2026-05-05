import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:uday_bharat/user_screen/auth/login.dart';
import 'package:uday_bharat/user_screen/wallet/wallet_screen.dart';
import 'package:uday_bharat/utils/color.dart';
import 'package:uday_bharat/utils/cutom_text.dart';
import 'package:uday_bharat/utils/session.dart';
import 'package:uday_bharat/utils/size.dart';
import 'package:uday_bharat/utils/toast_msg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../order/my_orderd_screen.dart';
import '../wish_list/wish_list_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  Widget _menuItem(
    BuildContext context,
    IconData icon,
    String title, {
    VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: const Color(0xFFF3E2C8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: const Color(0xFF6B4208), size: 22),
      ),
      title: Text(title, style: const TextStyle(fontSize: 15)),
      trailing: const Icon(Icons.chevron_right),
    );
  }

  String? userNumber;
  String? walletAmt;
  String? userId;
  void getUserNumber() async {
    userNumber = await MySharedPreferences.getUserMobileNumberId();
    walletAmt = await MySharedPreferences.getUserWalletAmt();
    userId = await MySharedPreferences.getUserId();
    setState(() {});
    print('----${userNumber}');
  }

  @override
  void initState() {
    super.initState();
    getUserNumber();
  }

  @override
  Widget build(BuildContext context) {
    MyFontSize fontSize = MyFontSize(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.appColor,
              AppColors.appColor,
              AppColors.lightAppColor,
              AppColors.lightOrangeColor,
              AppColors.lightOrangeColor,
              AppColors.white,
            ], // warm brown/orange gradient (can tweak)
            begin: Alignment.topCenter,
            end: Alignment.center,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 18),
              Image.asset(
                'assets/userIcon.png',
                height: fontSize.h / 7.8,
                fit: BoxFit.cover,
                color: AppColors.white,
              ),
              const SizedBox(height: 10),
              const CustomText(
                'Your account',
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 4),
              CustomText('+91 - ${userNumber}', fontSize: 13),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserWalletScreen()),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: AppColors.white,

                    //border: Border.all(color:AppColors.greenColor),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 12,
                        spreadRadius: 2,
                        offset: Offset(0, 6), // X, Y
                      ),
                    ],
                  ),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: AppColors.greenColor,
                      //border: Border.all(color:AppColors.greenColor),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Iconsax.wallet, color: AppColors.white),
                                SizedBox(width: 10),
                                CustomText(
                                  'ZiplyMart Cash',
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                CustomText(
                                  '₹${walletAmt ?? '0'}',
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.white,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 14,
                                  color: AppColors.white,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CustomText(
                                  'Available Balance',
                                  color: AppColors.white,
                                  fontSize: 12,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // White rounded card area
              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _smallActionCard(
                            Iconsax.box,
                            'Your orders',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyOrdersScreen(),
                                ),
                              );
                            },
                          ),
                          _smallActionCard(
                            Icons.favorite_border,
                            'Your wishlist',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WishlistScreen(),
                                ),
                              );
                            },
                          ),
                          // _smallActionCard(Icons.help_outline, 'Need help?'),
                        ],
                      ),
                    ),
                    SizedBox(height: fontSize.h * 0.02),

                    // _menuItem(context, Icons.favorite_border, 'Your wishlist',onTap: (){
                    //   Navigator.push(context, MaterialPageRoute(builder: (context) => WishlistScreen()));
                    // }),
                    SizedBox(height: fontSize.h * 0.02),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12,
                      ),
                      child: InkWell(
                        onTap: () async {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              contentPadding: const EdgeInsets.fromLTRB(
                                20,
                                20,
                                20,
                                10,
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(14),
                                    decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.warning_amber_rounded,
                                      color: Colors.red,
                                      size: 36,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  CustomText(
                                    "Confirm Logout",
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.black,
                                    fontSize: 18,
                                  ),
                                  SizedBox(height: 10),
                                  CustomText(
                                    "Are you sure you want to logout from your account?",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54,
                                    fontSize: 14,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              actionsPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              actions: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          side: BorderSide(color: Colors.grey),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                        ),
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          await MySharedPreferences.setUserId(
                                            '',
                                          );
                                          Utils.toastMessage(
                                            'Successfully Logout',
                                          );
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => LoginScreen(),
                                            ),
                                            (route) => false,
                                          );
                                        },
                                        child: Text(
                                          'Yes, Logout',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFEC1B1B),
                                Color(0xFFEC1B1B),
                                //Color(0xFFB78239)
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 14,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(''),
                              CustomText(
                                'Logout',
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                              Icon(Icons.logout, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: fontSize.h * 0.001),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8,
                      ),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              contentPadding: const EdgeInsets.fromLTRB(
                                20,
                                20,
                                20,
                                10,
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(14),
                                    decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.warning_amber_rounded,
                                      color: Colors.red,
                                      size: 36,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  CustomText(
                                    "Confirm Delete Account",
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.black,
                                    fontSize: 18,
                                  ),
                                  SizedBox(height: 10),
                                  CustomText(
                                    "Are you sure you want to Delete  your account?",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54,
                                    fontSize: 14,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              actionsPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              actions: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          side: BorderSide(color: Colors.grey),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                        ),
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          await MySharedPreferences.setUserId(
                                            '',
                                          );
                                          Utils.toastMessage(
                                            'Successfully Logout',
                                          );
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => LoginScreen(),
                                            ),
                                            (route) => false,
                                          );
                                        },
                                        child: CustomText(
                                          'Yes',
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            // gradient: const LinearGradient(
                            //   colors: [
                            //     Color(0xFFEC1B1B),
                            //     Color(0xFFEC1B1B),
                            //   ],
                            // ),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.red),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 14,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              SizedBox(width: 24),
                              CustomText(
                                'Delete Account',
                                color: Colors.red,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                              Icon(Icons.logout, color: Colors.red),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: fontSize.h * 0.001),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 8,
                      ),
                      child: InkWell(
                        onTap: () {
                          openDialPad('8808840407');
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 12,
                                spreadRadius: 2,
                                offset: Offset(0, 6), // X, Y
                              ),
                            ],
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(color: Colors.grey),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 14,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  'assets/customer-service.png',
                                  height: 30,
                                  color: Colors.blue,
                                ),
                                // SizedBox(width: 24),
                                CustomText(
                                  'Contact Support',
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // const SizedBox(height: 12),
                    //
                    // // Sensitive toggle card style
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    //   child: Container(
                    //     padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                    //     decoration: BoxDecoration(
                    //       color: const Color(0xFF424242),
                    //       borderRadius: BorderRadius.circular(12),
                    //     ),
                    //     child: Row(
                    //       children: [
                    //         Expanded(child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: const [
                    //             Text('Hide sensitive items', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                    //             SizedBox(height: 6),
                    //             Text('Sexual wellness, nicotine products and other sensitive items will be hidden', style: TextStyle(color: Colors.white70, fontSize: 12)),
                    //           ],
                    //         )),
                    //         Switch(value: false, onChanged: (v) {}),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    //
                    // const SizedBox(height: 14),
                    //
                    // // A block of list-style menu cards (Your information)
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    //   child: _sectionCard(context, 'Your information', children: [
                    //     _menuItem(context, Icons.bookmark, 'Address book'),
                    //     _menuItem(context, Icons.bookmark_border, 'Bookmarked recipes'),
                    //     _menuItem(context, Icons.favorite_border, 'Your wishlist'),
                    //   ]),
                    // ),
                    //
                    // const SizedBox(height: 12),
                    //
                    // // Payments and coupons
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    //   child: _sectionCard(context, 'Payments and coupons', children: [
                    //     _menuItem(context, Icons.account_balance_wallet, 'Wallet'),
                    //     _menuItem(context, Icons.monetization_on, 'Your Money'),
                    //     _menuItem(context, Icons.credit_card, 'Payment Settings'),
                    //     _menuItem(context, Icons.star_border, 'Your collected rewards'),
                    //   ]),
                    // ),
                    //
                    // const SizedBox(height: 12),
                    //
                    // // Feeding India
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    //   child: _sectionCard(context, 'Feeding India', children: [
                    //     _menuItem(context, Icons.eco, 'Your impact'),
                    //     _menuItem(context, Icons.receipt_long, 'Get Feeding India receipts'),
                    //   ]),
                    // ),
                    //
                    // const SizedBox(height: 28),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> openDialPad(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);

    await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
  }

  Widget _smallActionCard(
    IconData icon,
    String title, {
    void Function()? onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          padding: const EdgeInsets.symmetric(vertical: 12),

          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12,
                spreadRadius: 2,
                offset: Offset(0, 6), // X, Y
              ),
            ],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(icon, size: 26),
              const SizedBox(height: 8),
              CustomText(title, fontSize: 12, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }

  // section card widget for list groups
  Widget _sectionCard(
    BuildContext context,
    String title, {
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF383838),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
            child: Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white10, height: 1),
          ...children,
        ],
      ),
    );
  }
}
