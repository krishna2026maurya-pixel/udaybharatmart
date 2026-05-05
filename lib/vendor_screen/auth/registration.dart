import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:uday_bharat/data/checkStatus.dart';
import 'package:uday_bharat/utils/custom_dropdown.dart';
import 'package:uday_bharat/utils/cutom_text.dart';
import 'package:uday_bharat/utils/progress_bar.dart';
import 'package:uday_bharat/utils/size.dart';
import 'package:uday_bharat/vendor_screen/vendor_provider/view_model/auth_provider.dart';
import '../../user_screen/widgets/service_radius_widget.dart';
import '../../user_screen/widgets/step_progressbar.dart';
import '../../utils/color.dart';
import '../../utils/form.dart';
import '../location/location_switch_button.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class VendorRegistrationScreen extends StatefulWidget {
  const VendorRegistrationScreen({super.key});

  @override
  State<VendorRegistrationScreen> createState() =>
      _VendorRegistrationScreenState();
}

class _VendorRegistrationScreenState extends State<VendorRegistrationScreen> {
  final PageController _pageController = PageController();
  int currentStep = 0;
  final List<GlobalKey<FormState>> _formKeys = List.generate(
    4,
        (_) => GlobalKey<FormState>(),
  );
  void nextStep() {
    if (_formKeys[currentStep].currentState!.validate()) {
      //final provider = Provider.of<VendorAuthProvider>(context, listen: false);
      goToNextStep();
      // if (currentStep == 0) {
      //   provider.vendorRegistrationApi(context).then((value) {
      //
      //     if (ApiStatus.status == true) {
      //
      //     }
      //   });
      // } else {
      //   goToNextStep();
      //
      // }
    } else {
    }
  }

  void goToNextStep() {

    if (currentStep < 3) {
      setState(() => currentStep++);
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      final provider = Provider.of<VendorAuthProvider>(context, listen: false);
      provider.vendorRegistrationApi(context, currentIndex: '1');
    }
  }



  void prevStep() {
    if (currentStep > 0) {
      setState(() => currentStep--);
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }


  Future<Map<String, dynamic>?> fetchLocationFromPincode(String pincode) async {
    try {
      // Step 1: Fetch address details from Postal API
      final response = await http.get(Uri.parse('https://api.postalpincode.in/pincode/$pincode'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data[0]['Status'] == 'Success') {
          final postOffice = data[0]['PostOffice'][0];

          final area = postOffice['Name'] ?? '';
          final block = postOffice['Block'] ?? '';
          final district = postOffice['District'] ?? '';
          final state = postOffice['State'] ?? '';

          // Combine into full address
          final fullAddress = [
            area,
            if (block.isNotEmpty) block,
            if (district.isNotEmpty) district,
            if (state.isNotEmpty) state,
            pincode
          ].where((e) => e.isNotEmpty).join(', ');

          const googleApiKey = 'AIzaSyDLCESWG3BinAKTPr4ZqFMbWGULb-9Oe70';
          final geoUrl =
              'https://maps.googleapis.com/maps/api/geocode/json?address=${Uri.encodeComponent(fullAddress)}&key=$googleApiKey';

          final geoResponse = await http.get(Uri.parse(geoUrl));
          if (geoResponse.statusCode == 200) {
            final geoData = jsonDecode(geoResponse.body);
            if (geoData['status'] == 'OK') {
              final location = geoData['results'][0]['geometry']['location'];
              final provider = Provider.of<VendorAuthProvider>(context,listen: false);
              final lat = location['lat'];
              final lng = location['lng'];
              provider.setLatitude(lat.toString());
              provider.setLongitude(lng.toString());
              return {
                "address": fullAddress,
                "city": district,
                "state": state,
                "latitude": lat.toString(),
                "longitude": lng.toString(),
              };
            }
          }
        }
      }
    } catch (e) {
      print("❌ Error fetching location: $e");
    }
    return null;
  }

  final List<String> titles = [
    "Personal Information",
    "Business Information",
    "Documents",
    "Address Details",
  ];
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<VendorAuthProvider>(context,listen: false).getVendorBusinessType(context);
      Provider.of<VendorAuthProvider>(context,listen: false).getVendorShopCategoryType(context);

    },);
  }

  @override
  Widget build(BuildContext context) {
    MyFontSize fontSize = MyFontSize(context);
    return Scaffold(
      appBar: AppBar(
        title: CustomText("Vendor Registration",
            fontWeight: FontWeight.w500, color: AppColors.white),
        leading: const BackButton(color: AppColors.white),
        backgroundColor: AppColors.appColor,
        centerTitle: true,
      ),
      body: Consumer<VendorAuthProvider>(
        builder: (context, provider, child) {
          final getBusinessType = provider.getBusinessTypeRes.data;
          final getShopCategory = provider.getShopCategoryRes.data;
          return provider.isLoading?Center(child: CustomProgressBar(color: Colors.black)): Column(
            children: [
              const SizedBox(height: 10),
              StepProgressBar(totalSteps: 4, currentStep: currentStep),
              SizedBox(height: fontSize.h * 0.03),
              Container(
                width: fontSize.w,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: CustomText(
                    titles[currentStep],
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    // 🔹 Step 1 — Personal Info
                    Form(
                      key: _formKeys[0],
                      child: buildStep([
                        CustomForm(
                          labelText: "Full Name",
                          controller: provider.nameCtrl,
                          validator: (value) =>
                          value == null || value.isEmpty
                              ? 'Please enter your name'
                              : null,
                          prefixIcon: const Icon(Icons.drive_file_rename_outline),
                        ),
                        // SizedBox(height: fontSize.h * 0.02),
                        // CustomForm(
                        //   labelText: "Email Address",
                        //   keyboardType: TextInputType.emailAddress,
                        //   controller: provider.emailCtrl,
                        //   validator: (v) {
                        //     if (v == null || v.isEmpty) {
                        //       return 'Enter email';
                        //     }
                        //     // Basic email pattern validation
                        //     final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        //     if (!emailRegex.hasMatch(v)) {
                        //       return 'Enter valid email';
                        //     }
                        //     return null;
                        //   },
                        //   prefixIcon: const Icon(Icons.email_outlined),
                        //   inputFormatters: [
                        //     // Allow only valid email characters while typing
                        //     FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@._-]')),
                        //   ],
                        // ),

                        SizedBox(height: fontSize.h * 0.02),
                        CustomForm(
                            labelText: "Mobile Number",
                            keyboardType: TextInputType.phone,
                            maxLength: 10,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            controller: provider.mobileCtrl,
                            validator: (v) => v == null || v.length != 10
                                ? 'Enter valid number'
                                : null,
                            prefixIcon: const Icon(Icons.phone)),
                        SizedBox(height: fontSize.h * 0.02),
                        CustomForm(
                            labelText: "Password",
                            keyboardType: TextInputType.visiblePassword,
                            controller: provider.passwordCtrl,
                            validator: (v) => v == null || v.length < 6
                                ? 'Password too short'
                                : null,
                            prefixIcon: const Icon(Icons.lock)),
                        SizedBox(height: fontSize.h * 0.02),
                        CustomForm(
                            labelText: "Confirm Password",
                            controller: provider.confirmPasswordCtrl,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (v) => v != provider.passwordCtrl.text
                                ? 'Passwords do not match'
                                : null,
                            prefixIcon: const Icon(Icons.lock)),
                      ]),
                    ),

                    // 🔹 Step 2 — Business Info
                    Form(
                      key: _formKeys[1],
                      child: buildStep([
                        CustomForm(
                            labelText: "Shop Name",
                            controller: provider.shopNameCtrl,
                            validator: (v) =>
                            v == null || v.isEmpty ? 'Enter shop name' : null,
                            prefixIcon: const Icon(Icons.store)),
                        // SizedBox(height: fontSize.h * 0.02),
                        // CustomDropdown(
                        //   label: "Shop Category (e.g. Bakery, Grocery)",
                        //   hintText: "Select shop category",
                        //   items: getShopCategory ?? [], // API data from provider
                        //   value: provider.selectedCategoryType, // store selected value
                        //   getLabel: (item) => item.categoryName ?? 'N/A', // adjust key based on API model
                        //   onChanged: (val) {
                        //     setState(() {
                        //       provider.selectedCategoryType = val; // update selected
                        //       provider.categoryCtrl.text = val?.id.toString() ?? ''; // store in controller if needed
                        //     });
                        //   },
                        //   validator: (val) {
                        //     if (val == null) return "Please select shop category";
                        //     return null;
                        //   },
                        // ),
                        SizedBox(height: fontSize.h * 0.02),
                        CustomDropdown(
                          label: "Business Type",
                          hintText: "Select business type",
                          items: getBusinessType ?? [],
                          value: provider.selectedBusinessType,
                          getLabel: (item) => item.businessTypeName ?? 'N/A',
                          onChanged: (val) {
                            setState(() {
                              provider.selectedBusinessType = val;
                              provider.businessTypeCtrl.text = val?.id.toString() ?? '';
                            });
                          },
                          validator: (val) {
                            if (val == null) return "Please select business type";
                            return null;
                          },
                        ),
                        SizedBox(height: fontSize.h * 0.02),
                        CustomForm(
                          labelText: "GST Number",
                          controller: provider.gstCtrl,
                          prefixIcon: const Icon(Iconsax.status),
                          textCapitalization: TextCapitalization.characters,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9]')),
                            LengthLimitingTextInputFormatter(15),
                          ],
                          validator: (v) {
                            if (v == null || v.isEmpty) return 'Enter GST Number';
                            final gstRegex = RegExp(r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$');
                            if (!gstRegex.hasMatch(v)) return 'Enter valid GST Number';
                            return null;
                          },
                        ),

                        SizedBox(height: fontSize.h * 0.02),

                        CustomForm(
                          labelText: "PAN Number",
                          controller: provider.panCtrl,
                          prefixIcon: const Icon(Iconsax.card),
                          textCapitalization: TextCapitalization.characters,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9]')),
                            LengthLimitingTextInputFormatter(10),
                          ],
                          validator: (v) {
                            if (v == null || v.isEmpty) return 'Enter PAN Number';
                            final panRegex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');
                            if (!panRegex.hasMatch(v)) return 'Enter valid PAN Number';
                            return null;
                          },
                        ),

                        SizedBox(height: fontSize.h * 0.02),

                        CustomForm(
                          labelText: "Aadhaar Number",
                          controller: provider.licenceCtrl,
                          prefixIcon:  Icon(Iconsax.code),
                          maxLength: 12,
                          keyboardType: TextInputType.number,
                          textCapitalization: TextCapitalization.characters,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9-]')),
                            LengthLimitingTextInputFormatter(20), // optional limit
                          ],
                          validator: (v) {
                            if (v == null || v.isEmpty) return 'Enter Licence Number';
                            final licenceRegex = RegExp(r'^[A-Z0-9-]{5,20}$');
                            if (!licenceRegex.hasMatch(v)) return 'Enter valid Licence Number';
                            return null;
                          },
                        ),

                      ]),
                    ),

                    // 🔹 Step 3 — Documents
                    Form(
                      key: _formKeys[2],
                      child: buildStep([
                        const CustomText("Upload shop image/logo", fontSize: 14),
                        imageUploadWidget(provider.shopImage,
                                () => provider.pickImage('shopImage')),
                        const SizedBox(height: 15),
                        const CustomText("Upload Front Aadhaar", fontSize: 14),
                        imageUploadWidget(provider.frontAadhaar,
                                () => provider.pickImage('frontAadhaar')),
                        const SizedBox(height: 15),
                        const CustomText("Upload Back Aadhaar", fontSize: 14),
                        imageUploadWidget(provider.backAadhaar,
                                () => provider.pickImage('backAadhaar')),
                      ]),
                    ),

                    // 🔹 Step 4 — Address
                    Form(
                      key: _formKeys[3],
                      child: buildStep([
                        LocationSwitchWidget(),
                        SizedBox(height: fontSize.h * 0.02),
                        CustomForm(
                          labelText: "Pincode",
                          enabled: provider.useCurrentLocation==true?false:true,
                          keyboardType: TextInputType.number,
                          controller: provider.pinCtrl,
                          prefixIcon: const Icon(Icons.pin_drop_outlined),
                          validator: (v) =>
                          v == null || v.length != 6 ? 'Enter valid pincode' : null,
                          onChanged: (v) async {
                            if (v.length == 6) {
                              final location = await fetchLocationFromPincode(v);
                              if (location != null) {
                                setState(() {
                                  provider.addressCtrl.text = location['address'] ?? '';
                                  provider.cityCtrl.text = location['city'] ?? '';
                                  provider.stateCtrl.text = location['state'] ?? '';
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: CustomText(
                                      "Auto-filled city: ${location['city']}, state: ${location['state']}",
                                      textAlign: TextAlign.center,
                                    ),
                                    backgroundColor: Colors.green.shade600,
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: CustomText("Invalid or unknown pincode"),
                                    backgroundColor: Colors.redAccent,
                                  ),
                                );
                              }
                            }
                          },
                        ),

                        SizedBox(height: fontSize.h * 0.02),
                        CustomForm(
                            labelText: "City",
                            enabled: provider.useCurrentLocation==true?false:true,
                            controller: provider.cityCtrl,
                            validator: (v) =>
                            v == null || v.isEmpty ? 'Enter city' : null,
                            prefixIcon: const Icon(Icons.location_city)),
                        SizedBox(height: fontSize.h * 0.02),
                        CustomForm(
                            labelText: "State",
                            controller: provider.stateCtrl,
                            enabled: provider.useCurrentLocation==true?false:true,
                            validator: (v) =>
                            v == null || v.isEmpty ? 'Enter state' : null,
                            prefixIcon:
                            const Icon(Icons.location_city_rounded)),

                        SizedBox(height: fontSize.h * 0.02),
                        CustomForm(
                          labelText: "Address",
                          maxLines: 3,
                          enabled: provider.useCurrentLocation==true?false:true,
                          controller: provider.addressCtrl,
                          validator: (v) =>
                          v == null || v.isEmpty ? 'Enter address' : null,
                        ),
                        SizedBox(height: fontSize.h * 0.02),
                        const ServiceRadiusSlider(),
                      ]),
                    ),
                  ],
                ),
              ),

              // 🔹 Navigation Buttons
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    if (currentStep > 0)
                      Expanded(
                        child: ElevatedButton(
                          onPressed: prevStep,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade400),
                          child:
                          const CustomText("Back", color: AppColors.black),
                        ),
                      ),
                    if (currentStep > 0) const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: nextStep,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.appColor),
                        child: provider.isRegLoading?CustomProgressBar(): CustomText(
                            currentStep == 3 ? "Submit" : "Next",
                            color: AppColors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildStep(List<Widget> fields) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(children: fields),
      ),
    );
  }

  Widget imageUploadWidget(File? image, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 140,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: image != null
            ? ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.file(image, fit: BoxFit.cover),
        )
            : const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.upload_rounded,
                  size: 35, color: Colors.grey),
              SizedBox(height: 8),
              CustomText("Tap to upload", color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}

