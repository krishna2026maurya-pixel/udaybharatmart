import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:uday_bharat/user_screen/auth/login.dart';
import 'package:uday_bharat/user_screen/wallet/wallet_screen.dart';
import 'package:uday_bharat/utils/color.dart';
import 'package:uday_bharat/utils/cutom_text.dart';
import 'package:uday_bharat/utils/session.dart';

import '../provider/view_model/home_provider.dart';

class WalletBalanceWidget extends StatefulWidget {
  String? userId ;
   WalletBalanceWidget({super.key,this.userId});

  @override
  State<WalletBalanceWidget> createState() => _WalletBalanceWidgetState();
}

class _WalletBalanceWidgetState extends State<WalletBalanceWidget> {
  String balance = "0";

  @override
  Widget build(BuildContext context) {
    return (widget.userId==''||widget.userId==null)?InkWell(
      onTap: (){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen(),), (Route route) => false);
      },
        child: Icon(Iconsax.user)): GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserWalletScreen()),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.appColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            const Icon(Iconsax.wallet, color: Colors.white, size: 20),
         Consumer<HomeProvider>(
            builder: (context, value, child) {
              return CustomText(
                "₹${value.usrProfileRes.userProfile?.walletBalance??''}",
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              );
            },
      )

          ],
        ),
      ),
    );
  }
}
