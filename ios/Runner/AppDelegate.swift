import Flutter
import UIKit
import GoogleMaps
import FirebaseCore
import UserNotifications

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      FirebaseApp.configure()

      GMSServices.provideAPIKey("AIzaSyDLCESWG3BinAKTPr4ZqFMbWGULb-9Oe70")

      if #available(iOS 10.0, *) {
          let center  = UNUserNotificationCenter.current()
          center.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
              if error == nil{
                  DispatchQueue.main.async {
                      UIApplication.shared.registerForRemoteNotifications()
                  }

              }
          }
      }
      else {
          UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.sound, .alert, .badge], categories: nil))
          UIApplication.shared.registerForRemoteNotifications()
      }

      UNUserNotificationCenter.current().delegate = self

      UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
          granted, error in
          if let error = error {
              print("Error requesting notifications authorization: \(error)")
          }
      }
      application.registerForRemoteNotifications()

      GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
