import 'package:android_intent_plus/android_intent.dart';

Future<void> openAlarmPermissionSettings() async {
  final intent = AndroidIntent(
    action: 'android.settings.REQUEST_SCHEDULE_EXACT_ALARM',
  );
  await intent.launch();
}