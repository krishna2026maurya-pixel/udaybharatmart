

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import '../user_screen/dashborad/dashboard.dart';
import '../user_screen/provider/view_model/home_provider.dart';
class LocationProvider with ChangeNotifier {
  double? latitude;
  double? longitude;
  String? fullAddress;
  bool isLoading = false;
  Future<bool> checkLocationPermission(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  Future<void> fetchCurrentLocation(BuildContext context,{String?status}) async {
    isLoading = true;
    notifyListeners();
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      latitude = position.latitude;
      longitude = position.longitude;
      notifyListeners();

      List<Placemark> placemarks =
      await placemarkFromCoordinates(latitude!, longitude!);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        fullAddress =
        "${place.subLocality}, ${place.locality}, ${place.administrativeArea}";
        print('------------->fullAddress:${fullAddress}');
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (_) => const DashboardScreen()),
        // );
      } else {
        fullAddress = "Address not found";
      }
      if(status==null){
        if (latitude != null && longitude != null) {
          final provider = LocationProvider();
          final lat = latitude!;
          final lng = longitude!;
          // final prediction = placemarks.first;
          // provider.updateLocation(
          //   lat,
          //   lng,
          //   "",
          // );
          //Provider.of<HomeProvider>(context, listen: false).homeApi(context);
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (_) => const DashboardScreen()),
          // );
          // Provider.of<HomeProvider>(context,listen: false).homeApi(context);
        }
      }else {
        Navigator.pop(context);
      }

    } catch (e) {
      debugPrint("❌ Error fetching location: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


  Future<void> fetchCurrentLocation1(BuildContext context,{String?status}) async {
    isLoading = true;
    notifyListeners();
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      latitude = position.latitude;
      longitude = position.longitude;
      notifyListeners();

      List<Placemark> placemarks =
      await placemarkFromCoordinates(latitude!, longitude!);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        fullAddress =
        "${place.subLocality}, ${place.locality}, ${place.administrativeArea}";
        print('------------->fullAddress:${fullAddress}');
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (_) => const DashboardScreen()),
        // );
      } else {
        fullAddress = "Address not found";
      }
      if(status==null){
        if (latitude != null && longitude != null) {
          final provider = LocationProvider();
          final lat = latitude!;
          final lng = longitude!;

          final prediction = placemarks.first;
          provider.updateLocation(
            lat,
            lng,
            "",
          );

          Provider.of<HomeProvider>(context, listen: false).homeApi(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const DashboardScreen()),
          );
          // Provider.of<HomeProvider>(context,listen: false).homeApi(context);
        }
      }else {
        Navigator.pop(context);
      }

    } catch (e) {
      debugPrint("❌ Error fetching location: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void updateLocation(double lat, double lng, String address) {
    latitude = lat;
    longitude = lng;
    fullAddress = address;

    notifyListeners();
  }
}

