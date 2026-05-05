import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uday_bharat/utils/cutom_text.dart';
import 'package:uday_bharat/utils/progress_bar.dart';
import 'package:uday_bharat/vendor_screen/vendor_provider/view_model/auth_provider.dart';

class LocationSwitchWidget extends StatefulWidget {
  const LocationSwitchWidget({super.key});

  @override
  State<LocationSwitchWidget> createState() => _LocationSwitchWidgetState();
}

class _LocationSwitchWidgetState extends State<LocationSwitchWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<VendorAuthProvider>(builder: (context, provider, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (provider.isLocationLoading)
            Row(
              children: [
                const CustomText('Fetching Current Location...   '),
                const SizedBox(width: 10),
                const CustomProgressBar(color: Colors.black),
              ],
            ),
          if (!provider.isLocationLoading)
            SwitchListTile(
              title: const CustomText("Use Current Location"),
              value: provider.useCurrentLocation,
              onChanged: (val) {
                provider.setUseCurrentLocation(val);
                if (val) {
                  provider.getCurrentLocation();
                } else {
                  provider.currentAddress = null;
                }
              },
            ),
        ],
      );
    });
  }
}
