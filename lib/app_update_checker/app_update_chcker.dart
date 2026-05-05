import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';

class UpdateChecker {
  static Future<void> checkForUpdate(BuildContext context) async {
    try {
      AppUpdateInfo updateInfo = await InAppUpdate.checkForUpdate();

      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        // IMMEDIATE UPDATE
        InAppUpdate.performImmediateUpdate();
        // FLEXIBLE UPDATE (if you want)
        // InAppUpdate.startFlexibleUpdate().then((_) {
        //   InAppUpdate.completeFlexibleUpdate();
        // });
      }
    } catch (e) {
      print("Update Check Error: $e");
    }
  }
}
