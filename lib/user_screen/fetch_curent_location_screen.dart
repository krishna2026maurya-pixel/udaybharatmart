import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../location_service/location_provider.dart';
class FetchCurrentLocationScreen extends StatefulWidget {
  const FetchCurrentLocationScreen({super.key});

  @override
  State<FetchCurrentLocationScreen> createState() => _FetchCurrentLocationScreenState();
}

class _FetchCurrentLocationScreenState extends State<FetchCurrentLocationScreen> {
  @override
  void initState() {
    super.initState();
   Future.microtask(() =>  _getLocationAndNavigate(),);
  }
  Future<void> _getLocationAndNavigate() async {
Provider.of<LocationProvider>(context, listen: false).fetchCurrentLocation(context);

  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);

    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/Product delivery in time.json'),
      ),
    );
  }
}
