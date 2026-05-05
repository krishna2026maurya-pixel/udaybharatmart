import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:uday_bharat/user_screen/provider/view_model/auth_provider.dart';
import 'package:uday_bharat/utils/cutom_text.dart';
import 'package:uday_bharat/utils/session.dart';
import 'location_service/location_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _moveController;
  late AnimationController _bounceController;
  late Animation<double> _moveAnimation;
  late Animation<double> _bounceAnimation;
  @override
  void initState() {
    super.initState();
    getFcmToken();
    _initializeAnimations();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final locationProvider = Provider.of<LocationProvider>(
        context,
        listen: false,
      );

      /// 1️⃣ Permission check first (FAST)
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      /// 2️⃣ Agar permission mili tabhi location lo
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        await locationProvider.fetchCurrentLocation(context);
      } else {
        debugPrint("❌ Location permission not granted");
      }

      /// 3️⃣ Login check (independent)
      Provider.of<AuthProvider>(
        context,
        listen: false,
      ).checkUserLoginRepo(context);
    });
  }

  Future<void> getFcmToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    await MySharedPreferences.setFcmToken(token.toString());
    print("🔹 FCM Token: $token");
  }

  void _initializeAnimations() {
    _moveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _moveAnimation = Tween<double>(
      begin: 300,
      end: 0,
    ).animate(CurvedAnimation(parent: _moveController, curve: Curves.easeOut));

    _moveController.forward();

    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _bounceAnimation = Tween<double>(
      begin: 0,
      end: -20,
    ).chain(CurveTween(curve: Curves.easeOut)).animate(_bounceController);

    _moveController.addStatusListener((status) {
      if (status == AnimationStatus.completed) _bounceController.forward();
    });

    _bounceController.addStatusListener((status) {
      if (status == AnimationStatus.completed) _bounceController.reverse();
    });
  }

  @override
  void dispose() {
    _moveController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: Listenable.merge([_moveController, _bounceController]),
              builder: (context, child) {
                double moveY = _moveAnimation.value + _bounceAnimation.value;
                return Transform.translate(
                  offset: Offset(0, moveY),
                  child: Center(
                    child: Image.asset(
                      'assets/appstore-modified.png',
                      height: 250,
                      width: 250,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
