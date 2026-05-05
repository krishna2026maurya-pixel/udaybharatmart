import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uday_bharat/utils/color.dart';
import 'package:uday_bharat/utils/custom_button.dart';
import 'package:uday_bharat/utils/cutom_text.dart';
import 'package:uday_bharat/utils/form.dart';
import 'package:uday_bharat/utils/size.dart';
import 'package:uday_bharat/vendor_screen/vendor_provider/view_model/profile_view_model.dart';

import '../../../location_service/pick_vendor_profile_address.dart';

class EditVendorProfileScreen extends StatefulWidget {
  const EditVendorProfileScreen({super.key});

  @override
  State<EditVendorProfileScreen> createState() =>
      _EditVendorProfileScreenState();
}

class _EditVendorProfileScreenState extends State<EditVendorProfileScreen> {
  final _formKey = GlobalKey<FormState>();



@override
  void initState() {
    super.initState();
    Future.microtask(() =>   Provider.of<ProfileViewModel>(context, listen: false)
        .getVendorProfileApi(context));
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MyFontSize fontSize = MyFontSize(context);
    return Scaffold(
      appBar: AppBar(
        title: const CustomText("Edit Profile"),
        backgroundColor: AppColors.appColor,
        centerTitle: true,
      ),
      body:Consumer<ProfileViewModel>(builder: (context, provider, child) {
        return  SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText("Store Logo", fontWeight: FontWeight.w600),
                const SizedBox(height: 8),
                CustomImagePicker(localImage: provider.shopLogo,
                  networkImageUrl: provider.getProfileRes.data?.shopImage??'',
                  onTap: () =>provider.pickUpdateImage('logo'),),
                const SizedBox(height: 10),

                CustomForm(labelText: "Shop Name",controller: provider.shopNameController),
                const SizedBox(height: 10),
                CustomForm(labelText: "Owner Name",controller:  provider.ownerNameController),
                const SizedBox(height: 10),
                CustomForm(labelText: "Phone", controller: provider.phoneController,
                    keyboardType: TextInputType.phone),

                const SizedBox(height: 10),
                CustomForm(labelText: "password", controller: provider.passwordController,
                    keyboardType: TextInputType.visiblePassword),

                const SizedBox(height: 10),
                CustomImagePicker(localImage:provider.gstImage,
                  networkImageUrl: provider.getProfileRes.data?.gstCertificate??'',
                  onTap: () =>provider.pickUpdateImage('gst')),
                const SizedBox(height: 5),
                CustomForm(labelText: "Gst number", controller: provider.gstNumberController,
                    keyboardType: TextInputType.phone),
                const SizedBox(height: 10),
                CustomImagePicker(localImage: provider.panCardImage,
                  networkImageUrl: provider.getProfileRes.data?.panCard??'',
                  onTap: () =>provider.pickUpdateImage('pan_card'),),
                const SizedBox(height: 5),
                CustomForm(labelText: "Pan number", controller: provider.panNumberController,
                    keyboardType: TextInputType.phone),
                const SizedBox(height: 10),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        CustomText("Aadhaar Front", fontWeight: FontWeight.w600),
                        CustomImagePicker(localImage: provider.aadhaarFrontImage,
                          networkImageUrl: provider.getProfileRes.data?.aadharFront??'',
                          onTap: () =>provider.pickUpdateImage('front'),)
                      ],
                    ),
                    Column(
                      children: [
                        CustomText("Aadhaar Back", fontWeight: FontWeight.w600),
                        CustomImagePicker(localImage: provider.aadhaarBackImage,
                          networkImageUrl: provider.getProfileRes.data?.aadharBack??'',
                          onTap: () =>provider.pickUpdateImage('back'),)
                      ],
                    ),
                  ],),
                const SizedBox(height: 5),
                CustomForm(labelText: "Aadhaar number", controller: provider.aadhaarNumberController,
                    keyboardType: TextInputType.phone),
                const SizedBox(height: 10),
                CustomText("Address", fontWeight: FontWeight.w600),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: CustomForm(
                        labelText: "Address",
                        controller: provider.addressController,
                        maxLines: 2,
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.my_location, color: Colors.blue),
                      onPressed: () async {
                        await provider.getCurrentLocation();
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.location_on_outlined, color: Colors.red),
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const PickMapScreen()),
                        );
                      },
                    ),
                  ],
                ),
                // const SizedBox(height: 10),
                // CustomForm(labelText:"Shop Description",
                //     maxLines: 3),
                const SizedBox(height: 20),

                
              ],
            ),
          ),
        );
      },),
      bottomNavigationBar: SafeArea(
        child: Consumer<ProfileViewModel>(builder:  (context, getProfile, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: CustomButton(
              title: "Save Changes",
              isLoading: getProfile.isUpDateLoading,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  getProfile.vendorUpdateProfileApi(context);
                }
              },
            ),
          );
        },   )
      ),
    );
  }

}



class CustomImagePicker extends StatelessWidget {
  final File? localImage;
  final String? networkImageUrl;
  final VoidCallback onTap;

  const CustomImagePicker({
    Key? key,
    required this.localImage,
    required this.networkImageUrl,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyFontSize fontSize = MyFontSize(context);
    return GestureDetector(
      onTap: onTap,
      child: localImage != null
          ? ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.file(
          localImage!,
          height: fontSize.h/8,
          width: fontSize.w/2.5,
          fit: BoxFit.cover,
        ),
      )
          : Container(
        height: fontSize.h/8,
        width: fontSize.w/2.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey),
        ),
        child: networkImageUrl != null && networkImageUrl!.isNotEmpty
            ? ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            networkImageUrl!,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Icon(Icons.add_photo_alternate,
                    color: Colors.grey, size: 40),
              );
            },
          ),
        )
            : const Center(
          child: Icon(Icons.add_photo_alternate,
              color: Colors.grey, size: 40),
        ),
      ),
    );
  }
}
