import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:uday_bharat/service/notification_services.dart';
import 'package:uday_bharat/splash.dart';
import 'package:uday_bharat/user_screen/provider/view_model/auth_provider.dart';
import 'package:uday_bharat/user_screen/provider/view_model/cart_local_provider.dart';
import 'package:uday_bharat/user_screen/provider/view_model/cart_view_model.dart';
import 'package:uday_bharat/user_screen/provider/view_model/category_view_model.dart';
import 'package:uday_bharat/user_screen/provider/view_model/home_provider.dart';
import 'package:uday_bharat/user_screen/provider/view_model/payment_provider.dart';
import 'package:uday_bharat/utils/color.dart';
import 'package:uday_bharat/utils/session.dart';
import 'package:uday_bharat/vendor_screen/vendor_provider/view_model/auth_provider.dart';
import 'package:uday_bharat/vendor_screen/vendor_provider/view_model/product_view_model.dart';
import 'package:uday_bharat/vendor_screen/vendor_provider/view_model/profile_view_model.dart';
import 'location_service/location_provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///  FIREBASE INIT
  await Firebase.initializeApp();

  ///  BACKGROUND HANDLER REGISTER (VERY IMPORTANT)
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  ///  NOTIFICATION INIT
  await NotificationService.init();
  await Hive.initFlutter();
  Hive.openBox('cartBox');
  Hive.openBox('queueBox');
  await Hive.openBox('addedItemsBox');
  MySharedPreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => VendorAuthProvider()),
        ChangeNotifierProvider(create: (context) => LocationProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => ProductViewModel()),
        ChangeNotifierProvider(create: (context) => CategoryViewModel()),
        ChangeNotifierProvider(create: (context) => CartViewModel()),
        ChangeNotifierProvider(create: (context) => ProfileViewModel()),
        ChangeNotifierProvider(create: (_) => PaymentProvider()..init()),
        ChangeNotifierProvider(create: (_) => CartLocalProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ZiplyMart',
        navigatorKey: navigatorKey,
        theme: ThemeData(scaffoldBackgroundColor: AppColors.white),
        home: SplashScreen(),
      ),
    );
  }
}
