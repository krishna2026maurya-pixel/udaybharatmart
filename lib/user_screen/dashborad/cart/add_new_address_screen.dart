import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:iconsax/iconsax.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart' hide LatLng;
import 'package:provider/provider.dart';
import 'package:uday_bharat/user_screen/provider/view_model/cart_view_model.dart';
import 'package:uday_bharat/utils/color.dart';
import 'package:uday_bharat/utils/custom_button.dart';
import 'package:uday_bharat/utils/cutom_text.dart';
import 'package:uday_bharat/utils/form.dart';
import 'package:uday_bharat/utils/progress_bar.dart';
import 'package:uday_bharat/utils/shadow_container.dart';

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({super.key});

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}
class _AddNewAddressScreenState extends State<AddNewAddressScreen> {


  LatLng? selectedPosition;
  GoogleMapController? mapController;
  late FlutterGooglePlacesSdk places;
  List<AutocompletePrediction> suggestions = [];
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    places = FlutterGooglePlacesSdk("AIzaSyDLCESWG3BinAKTPr4ZqFMbWGULb-9Oe70");
    _goToCurrentLocation();
  }

  Future<void> _goToCurrentLocation() async {
    var permission = await Permission.location.request();
    if (!permission.isGranted) return;

    Position pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    selectedPosition = LatLng(pos.latitude, pos.longitude);
    setState(() {});
    _updateAddressFromLatLng(selectedPosition!.latitude, selectedPosition!.longitude);

    mapController?.animateCamera(CameraUpdate.newLatLngZoom(selectedPosition!, 16));
  }


  Future<void> _updateAddressFromLatLng(double lat, double lng) async {
    final getProvider = Provider.of<CartViewModel>(context,listen: false);
    final placemarks = await placemarkFromCoordinates(lat, lng);
    final p = placemarks.first;

    setState(() {
      getProvider.addressController.text = "${p.street}, ${p.locality}, ${p.administrativeArea}";
      getProvider.houseNoController.text = p.name ?? "";
      getProvider.cityController.text = p.locality ?? "";
      getProvider.areaController = p.subLocality ?? "";
      getProvider.street = p.street ?? "";
      getProvider.stateController.text = p.administrativeArea ?? "";
      getProvider. pincodeController.text = p.postalCode ?? "";
    });
  }

  void _onSearchChanged(String value) async {
    if (value.isEmpty) {
      setState(() {
        suggestions = [];
      });
      return;
    }

    final result = await places.findAutocompletePredictions(
      value,
      countries: ["IN"],
    );

    setState(() {
      suggestions = List.from(result.predictions);
      isSearching = true;
    });
  }

  void animateTo(LatLng target, {double zoom = 16}) {
    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: target,
          zoom: zoom,
          tilt: 0,
          bearing: 0,
        ),
      ),
    );
  }

  Future<void> _selectPlace(AutocompletePrediction prediction) async {
    FocusScope.of(context).unfocus(); // close keyboard

    setState(() {
      suggestions = [];
      isSearching = false;
    });

    final detail = await places.fetchPlace(
      prediction.placeId,
      fields: [PlaceField.Location, PlaceField.AddressComponents],
    );

    final loc = detail.place?.latLng;
    if (loc == null) return;

    selectedPosition = LatLng(loc.lat, loc.lng);
    await _updateAddressFromLatLng(loc.lat, loc.lng);

    // mapController?.animateCamera(CameraUpdate.newLatLngZoom(selectedPosition!, 16));
    animateTo(selectedPosition!);

  }


  void _onMapTap(LatLng pos) {
    selectedPosition = pos;
    setState(() {});
    _updateAddressFromLatLng(pos.latitude, pos.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
          title: const CustomText("Add New Address",color: Colors.black,)),
      body: Consumer<CartViewModel>(builder: (context, provider, child) {
        return Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CustomForm(
                    hintText: "Search your location...",
                    controller: provider.searchController,
                    prefixIcon: Icon(Icons.search),
                    onChanged: _onSearchChanged,
                    onTap: () => setState(() => isSearching = true),
                  ),
                  // 🟢 Suggestions
                  if (suggestions.isNotEmpty && isSearching)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: suggestions.length,
                        itemBuilder: (_, i) {
                          return ListTile(
                            title: Text(suggestions[i].fullText),
                            onTap: () => _selectPlace(suggestions[i]),
                          );
                        },
                      ),
                    ),

                  const SizedBox(height: 12),

                  // 🗺️ Map
                  Stack(
                    children: [
                      SizedBox(
                          height: 260,
                          child: selectedPosition == null
                              ? const Center(child: CircularProgressIndicator())
                              : GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: selectedPosition!,
                              zoom: 15,
                            ),
                            onMapCreated: (c) => mapController = c,
                            onTap: _onMapTap,

                            zoomGesturesEnabled: true,
                            scrollGesturesEnabled: true,
                            rotateGesturesEnabled: true,
                            tiltGesturesEnabled: true,
                            myLocationEnabled: true,
                            myLocationButtonEnabled: false,

                            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                              Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer()),
                            },

                            markers: {
                              Marker(markerId: const MarkerId("m"), position: selectedPosition!)
                            },

                            onCameraMove: (position) {
                              selectedPosition = position.target;
                            },
                            onCameraIdle: () {
                              if (selectedPosition != null) {
                                _updateAddressFromLatLng(
                                  selectedPosition!.latitude,
                                  selectedPosition!.longitude,
                                );
                              }
                            },
                          )


                      ),
                      Positioned(
                        right: 20,
                        bottom: 10,
                        child: FloatingActionButton(
                          backgroundColor: AppColors.appColor,
                          onPressed: _goToCurrentLocation,
                          child: const Icon(Icons.my_location, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ShadowContainer(
                    child: Column(children: [
                      CustomForm(controller: provider.nameController, labelText: "Name"),
                      SizedBox(height: 10,),
                      CustomForm(controller: provider.phoneController,
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          labelText: "Phone"),
                      SizedBox(height: 10,),
                      CustomForm(controller: provider.houseNoController, labelText: "House / Flat"),
                      SizedBox(height: 10),
                     Row(children: [
                       Expanded(child: CustomForm(controller: provider.cityController, labelText: "City")),
                       SizedBox(width: 10),
                       Expanded(child: CustomForm(controller: provider.stateController, labelText: "State")),
                     ],),
                      SizedBox(height: 10),
                      SizedBox(height: 10),
                      CustomForm(controller: provider.landmarkController, labelText: "Landmark"),
                      SizedBox(height: 10),
                      CustomForm(controller: provider.addressController, labelText: "Full Address"),
                      SizedBox(height: 10),

                      CustomForm(controller: provider.pincodeController, labelText: "Pincode"),
                    ]),
                  ),
                  const SizedBox(height: 15),
                  ShadowContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          "Address Type",
                          fontWeight: FontWeight.bold, fontSize: 16,
                        ),
                        Row(
                          children: [
                            Radio<String>(
                              value: "Home",
                              activeColor: AppColors.appColor,
                              groupValue: provider.selectedAddressType,
                              onChanged: (value) {
                                setState(() =>provider. selectedAddressType = value!);
                              },
                            ),
                            const CustomText("Home"),
                            Radio<String>(
                              value: "Office",
                              activeColor: AppColors.appColor,
                              groupValue: provider.selectedAddressType,
                              onChanged: (value) {
                                setState(() => provider.selectedAddressType = value!);
                              },
                            ),
                            const CustomText("Office"),
                            Radio<String>(
                              value: "Other",
                              activeColor: AppColors.appColor,
                              groupValue: provider.selectedAddressType,
                              onChanged: (value) {
                                setState(() => provider.selectedAddressType = value!);
                              },
                            ),
                            const Text("Other"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            // 📍 Floating Current Location Button
          ],
        );
      },),
      bottomNavigationBar: Consumer<CartViewModel>(builder: (context, provider, child) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: SafeArea(
              child: CustomButton(
                isLoading: provider.isLoading,
                  onPressed: () {
                if (selectedPosition == null) return;
                provider.addUpdateAddressApi(
                    context,
                    lat:selectedPosition!.latitude.toString() ,
                    long: selectedPosition!.longitude.toString()
                );
                print("🟢 SAVED ADDRESS DETAILS:");
                print("Name: ${provider.nameController.text}");
                print("Phone: ${provider.phoneController.text}");
                print("House No: ${provider.houseNoController.text}");
                print("Landmark: ${provider.landmarkController.text}");
                print("Full Address: ${provider.addressController.text}");
                print("Pincode: ${provider.pincodeController.text}");
                print("📍Latitude: ${selectedPosition!.latitude}");
                print(" Longitude: ${selectedPosition!.longitude}");
              }, title: 'Save Address'),
            )
          ),
        );
      },)
    );
  }
}

