import 'dart:async';
import 'dart:typed_data';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'package:uday_bharat/utils/session.dart';
import 'package:uday_bharat/vendor_screen/dashboard/vendor_order_list_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import '../main.dart';
import '../vendor_screen/vendor_provider/view_model/product_view_model.dart';

/// 🔥 BACKGROUND HANDLER (Top Level)
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Re-init channels for background process
  await NotificationService.preInitialize();

  debugPrint("🌙 Background Message Received: ${message.data}");

  final status = message.data['status']?.toString();
  // Vendor gets Ring for status 0 (New Order)
  final bool isVendorNewOrder = (status == "0");

  // Show notification manually from data
  await NotificationService.showManualNotification(
    message,
    isVendorNewOrder: isVendorNewOrder,
  );
}

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static String? _lastMessageId;
  static final AudioPlayer _audioPlayer = AudioPlayer();

  // 1. CHANNELS PRE-INIT
  static Future<void> preInitialize() async {
    await AwesomeNotifications().initialize(null, [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        channelDescription: 'Standard notifications',
        importance: NotificationImportance.High,
        playSound: true,
        channelShowBadge: true,
      ),
      NotificationChannel(
        channelKey: 'vendor_ring_v2',
        channelName: 'Vendor Order Alerts',
        channelDescription: 'Loud ringtone for new vendor orders',
        importance: NotificationImportance.Max,
        playSound: true,
        enableVibration: true,
        vibrationPattern: Int64List.fromList([0, 6000]),
        soundSource: 'resource://raw/laworder_svu',
        locked: true,
        criticalAlerts: true,
      ),
    ], debug: false);
  }

  // 2. MAIN INITIALIZATION
  static Future<void> init() async {
    await preInitialize();
    await _requestPermission();

    /// FOREGROUND MESSAGE
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.messageId == _lastMessageId) return;
      _lastMessageId = message.messageId;

      final vendorId = await MySharedPreferences.getVendorId();
      final userId = await MySharedPreferences.getUserId();
      final status = message.data['status']?.toString().trim() ?? "";

      debugPrint("🔔 Foreground FCM Received: ${message.data}");

      // CASE: VENDOR LOGGED IN
      if (vendorId != null && vendorId.isNotEmpty) {
        final ctx = navigatorKey.currentContext;
        if (ctx != null) {
          final provider = Provider.of<ProductViewModel>(ctx, listen: false);
          if (status == "0") {
            provider.showNewOrderAnimation();
            await provider.vendorDashboardApi(ctx);
            provider.vendorOrderListApi(ctx, status: "new");
            // Play sound explicitly in foreground
            _playRingTone();
          }
        }
        showManualNotification(message, isVendorNewOrder: status == "0");
        return;
      }

      // CASE: USER LOGGED IN
      if (userId != null && userId.isNotEmpty) {
        if (status == "0" && message.data['type'] == 'new_order') return;
        showManualNotification(message, isVendorNewOrder: false);
        return;
      }
    });

    /// BACKGROUND & TAP HANDLERS
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageTap);

    String? token = await _messaging.getToken();
    debugPrint("FCM Token: $token");
  }

  static Future<void> _requestPermission() async {
    await Permission.notification.request();
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      criticalAlert: true,
    );
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  // 3. SHOW MANUAL NOTIFICATION
  static Future<void> showManualNotification(
    RemoteMessage message, {
    required bool isVendorNewOrder,
  }) async {
    final String channelKey = isVendorNewOrder
        ? 'vendor_ring_v2'
        : 'basic_channel';

    final String? title =
        message.data['title'] ??
        message.notification?.title ??
        "New Notification";
    final String? body =
        message.data['body'] ?? message.notification?.body ?? "";
    final String? image =
        message.data['image'] ?? message.notification?.android?.imageUrl;

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: channelKey,
        title: title,
        body: body,
        wakeUpScreen: isVendorNewOrder,
        criticalAlert: isVendorNewOrder,
        autoDismissible: false,
        notificationLayout: image != null
            ? NotificationLayout.BigPicture
            : NotificationLayout.Default,
        bigPicture: image,
        payload: message.data.map((k, v) => MapEntry(k, v.toString())),
      ),
    );

    if (isVendorNewOrder) {
      _playRingTone();
    }
  }

  static Future<void> _playRingTone() async {
    try {
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource('laworder_svu.mp3'));
    } catch (e) {
      debugPrint("Error playing ringtone: $e");
    }
  }

  // 4. TAP LOGIC
  static void _handleMessageTap(RemoteMessage message) {
    String statusKey = '';
    final status = message.data['status']?.toString() ?? "";

    switch (status) {
      case '0':
        statusKey = 'new';
        break;
      case '1':
        statusKey = 'confirmed';
        break;
      case '2':
        statusKey = 'allotted';
        break;
      case '3':
        statusKey = 'shipped';
        break;
      case '4':
        statusKey = 'delivered';
        break;
      case '5':
        statusKey = 'cancelled';
        break;
      default:
        statusKey = 'new';
    }

    final ctx = navigatorKey.currentContext;
    if (ctx != null) {
      Navigator.push(
        ctx,
        MaterialPageRoute(
          builder: (context) => VendorOrderListScreen(status: statusKey),
        ),
      );
    }
  }
}
