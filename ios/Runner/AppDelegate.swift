import UIKit
import Flutter
import GoogleMaps  
import FirebaseCore

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)

    // TODO: Add your Google Maps API key
    GMSServices.provideAPIKey("AIzaSyDPCEN0OmaJQqpUBKorthcMYq9BQpZyfiE")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
