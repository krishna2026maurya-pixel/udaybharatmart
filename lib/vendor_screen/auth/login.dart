import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uday_bharat/policy/privacy_policy.dart';
import 'package:uday_bharat/policy/term_and_condition.dart';
import 'package:uday_bharat/user_screen/auth/login.dart';
import 'package:uday_bharat/utils/color.dart';
import 'package:uday_bharat/utils/custom_button.dart';
import 'package:uday_bharat/utils/cutom_text.dart';
import 'package:uday_bharat/utils/size.dart';
import 'package:uday_bharat/vendor_screen/auth/registration.dart';
import 'package:uday_bharat/vendor_screen/vendor_provider/view_model/auth_provider.dart';

class VendorLoginScreen extends StatefulWidget {
  const VendorLoginScreen({super.key});
  @override
  State<VendorLoginScreen> createState() => _VendorLoginScreenState();
}

class _VendorLoginScreenState extends State<VendorLoginScreen> {
  @override
  Widget build(BuildContext context) {
    MyFontSize fontSize = MyFontSize(context);
    return Scaffold(
      body: Consumer<VendorAuthProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  width: fontSize.w,
                  height: fontSize.h / 1.8,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/login_bg.png'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.75),
                        BlendMode.modulate,
                      ),
                    ),
                  ),
                  // optional overlay gradient to get white bottom
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: fontSize.h * 0.09),
                        Image.asset(
                          'assets/appstore-modified.png',
                          height: fontSize.h / 4.5,
                          fit: BoxFit.cover,
                        ),
                        CustomText(
                          "Vendor Portal",
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Archivo Black',
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: fontSize.h * 0.01),
                        CustomText(
                          "Welcome back!",
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                        CustomText(
                          "Sign in to your vendor account ",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColors.grey,
                        ),
                        SizedBox(height: fontSize.h * 0.04),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.11),
                                blurRadius: 15,
                                spreadRadius: 6,
                                offset: const Offset(
                                  0,
                                  4,
                                ), // pushes shadow only downward
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.person, color: AppColors.grey),
                              CustomText(
                                '|',
                                fontSize: 30,
                                fontWeight: FontWeight.w200,
                                color: AppColors.grey,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: StatefulBuilder(
                                  builder: (context, setState) {
                                    return TextFormField(
                                      controller: provider.emailCtrl,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        counterText: "",
                                        hintText: "Enter phone number",
                                        hintStyle: TextStyle(
                                          color: Colors.grey.shade500,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                        ),
                                      ),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                          RegExp(r'[a-zA-Z0-9@._+-]'),
                                        ),
                                      ],
                                      maxLength:
                                          RegExp(
                                            r'^[0-9]+$',
                                          ).hasMatch(provider.emailCtrl.text)
                                          ? 10
                                          : null,
                                      onChanged: (value) {
                                        // When input changes, check if it's a number
                                        final isNumeric = RegExp(
                                          r'^[0-9]+$',
                                        ).hasMatch(value.trim());
                                        // Update maxLength dynamically
                                        setState(() {});
                                      },
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'Please enter email or phone number';
                                        }

                                        final input = value.trim();
                                        final isNumeric = RegExp(
                                          r'^[0-9]+$',
                                        ).hasMatch(input);

                                        if (isNumeric) {
                                          if (input.length != 10) {
                                            return 'Please enter a valid 10-digit phone number';
                                          }
                                        } else {
                                          final emailRegex = RegExp(
                                            r'^[\w\.-]+@[\w\.-]+\.\w+$',
                                          );
                                          if (!emailRegex.hasMatch(input)) {
                                            return 'Please enter a valid email address';
                                          }
                                        }

                                        return null;
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: fontSize.h * 0.02),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.11),
                                blurRadius: 15,
                                spreadRadius: 6,
                                offset: const Offset(
                                  0,
                                  4,
                                ), // pushes shadow only downward
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.lock, color: AppColors.grey),
                              CustomText(
                                '|',
                                fontSize: 30,
                                fontWeight: FontWeight.w200,
                                color: AppColors.grey,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  controller: provider.passwordCtrl,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Enter password",
                                    hintStyle: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: fontSize.h * 0.02),
                        CustomButton(
                          isLoading: provider.isLoading,
                          onPressed: () {
                            provider.vendorLoginApi(context);
                          },
                          title: 'Login',
                        ),
                        SizedBox(height: fontSize.h * 0.02),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    VendorRegistrationScreen(),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.teal,
                                width: 1.5,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  'New Vendor? Register Here  ',
                                  color: Colors.teal,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                Icon(
                                  Icons.person_add_alt_1,
                                  color: Colors.teal,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: fontSize.h * 0.01),
                        InkWell(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                              (Route route) => false,
                            );
                          },
                          child: CustomText(
                            'as a User login',
                            color: AppColors.blue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: fontSize.h * 0.03),
                        TermsText(
                          onTermsTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TermAndCondition(),
                              ),
                            );
                          },
                          onPrivacyTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PrivacyPolicyScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
