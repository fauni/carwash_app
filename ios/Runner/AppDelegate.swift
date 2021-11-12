import UIKit
import Flutter
import GoogleMaps
import Firebase

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyCrQF0b-qQAUQRJlfcUYlLu9xv17RQNuKM")
    
    let controller: FlutterViewController = window.rootViewController as! FlutterViewController
    let methodChannel = FlutterMethodChannel(name:"app.gghh/share_platform_channel", binaryMessenger: controller.binaryMessenger)
    
    methodChannel.setMethodCallHandler({(call: FlutterMethodCall, result: FlutterResult) -> Void in
        if call.method == "version"{
            let version = UIDevice().systemVersion
            result("iOS \(version)")
        } else {
            result(FlutterMethodNotImplemented)
        }
    })
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    
}

