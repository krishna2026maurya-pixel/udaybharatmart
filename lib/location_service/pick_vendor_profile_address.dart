import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import 'package:uday_bharat/utils/custom_button.dart';
import 'package:uday_bharat/vendor_screen/vendor_provider/view_model/profile_view_model.dart';

import '../utils/cutom_text.dart';

class PickMapScreen extends StatefulWidget {
  const PickMapScreen({super.key});

  @override
  State<PickMapScreen> createState() => _PickMapScreenState();
}

class _PickMapScreenState extends State<PickMapScreen> {
  LatLng? selectedLocation;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProfileViewModel>(context);

    LatLng startLatLng = LatLng(
      double.tryParse(provider.getLatitude ?? "25.3176") ?? 25.3176,
      double.tryParse(provider.getLongitude ?? "82.9739") ?? 82.9739,
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
          title: const CustomText("Select Location")),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(target: startLatLng, zoom: 14),
            onTap: (LatLng pos) async {
              setState(() => selectedLocation = pos);
              List<Placemark> placemarks = await placemarkFromCoordinates(pos.latitude, pos.longitude);
              Placemark place = placemarks.first;
              provider.addressController.text =
              "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
              provider.setLatitude(pos.latitude.toString());
              provider.setLongitude(pos.longitude.toString());
            },
            markers: selectedLocation == null
                ? {}
                : {
              Marker(markerId: const MarkerId('selected'), position: selectedLocation!)
            },
          ),
          if (selectedLocation != null)
            Positioned(
              bottom: 0,
                left: 10,
                right: 10,
                child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(8),
                    child: CustomText(provider.addressController.text))),

        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: CustomButton(onPressed: () {
            Navigator.pop(context);
          }, title: 'Done')
        ),
      ),
    );
  }
}
