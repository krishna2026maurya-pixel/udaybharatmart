import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uday_bharat/main.dart';
import 'package:uday_bharat/user_screen/provider/view_model/auth_provider.dart';
import 'package:uday_bharat/utils/color.dart';
import 'package:uday_bharat/utils/custom_button.dart';
import 'package:uday_bharat/utils/cutom_text.dart';
import 'package:uday_bharat/utils/size.dart';
import '../../policy/privacy_policy.dart';
import '../../policy/term_and_condition.dart';
import '../dashborad/dashboard.dart';
import '../widgets/bouncing_app_icon.dart';
import 'package:uday_bharat/vendor_screen/auth/login.dart';
import 'package:in_app_update/in_app_update.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    MyFontSize fontSize = MyFontSize(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: fontSize.w,
              height: fontSize.h / 1.8,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/login_bg.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.75),
                    BlendMode.modulate,
                  ),
                ),
              ),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.white],
                    stops: [0.45, 1.0],
                  ),
                ),
              ),
            ),

            Center(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: fontSize.h * 0.09),
                    const BouncingImage(),

                    CustomText(
                      "India's Fast Delivery App",
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Archivo Black',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: fontSize.h * 0.01),

                    const CustomText(
                      "Signup & Login Account",
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                    const CustomText(
                      "and get all access of daily app",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.grey,
                    ),
                    SizedBox(height: fontSize.h * 0.04),

                    // PHONE INPUT BOX
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.11),
                            blurRadius: 15,
                            spreadRadius: 6,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const CustomText(
                            "+91",
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                          const SizedBox(width: 8),

                          Expanded(
                            child: Consumer<AuthProvider>(
                              builder: (context, value, child) {
                                return TextField(
                                  controller: value.mobileController,
                                  keyboardType: TextInputType.phone,
                                  maxLength: 10,
                                  decoration: InputDecoration(
                                    counterText: '',
                                    border: InputBorder.none,
                                    hintText: "Enter your mobile number",
                                    hintStyle: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: fontSize.h / 8),

                    Consumer<AuthProvider>(
                      builder: (context, value, child) {
                        return CustomButton(
                          isLoading: value.isLoading,
                          onPressed: () => value.getOtpApi(context),
                          title: 'Get OTP',
                        );
                      },
                    ),
                    SizedBox(height: fontSize.h * 0.02),
                    if(Platform.isAndroid==true)
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const VendorLoginScreen(),
                          ),
                        );
                      },
                      child: const CustomText(
                        "Vendor Login",
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: AppColors.blue,
                      ),
                    ),
                    SizedBox(height: fontSize.h * 0.03),
                    TermsText(
                      onTermsTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => TermAndCondition()),
                      ),
                      onPrivacyTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => PrivacyPolicyScreen()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if(Platform.isIOS)
            Positioned(
              top: fontSize.h * 0.05,
              right: 10,
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) =>  DashboardScreen()),
                  );
                },
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.11),
                        blurRadius: 15,
                        spreadRadius: 6,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const CustomText(
                    "Skip",
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: AppColors.appColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
