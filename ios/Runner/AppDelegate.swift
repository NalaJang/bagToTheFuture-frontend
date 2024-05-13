import UIKit
import Flutter
import NaverThirdPartyLogin
import CoreLocation

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    var locationManager: CLLocationManager!
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    NaverThirdPartyLoginConnection.getSharedInstance()?.isNaverAppOauthEnable = true
    NaverThirdPartyLoginConnection.getSharedInstance()?.isInAppOauthEnable = true

    let thirdConn = NaverThirdPartyLoginConnection.getSharedInstance()
    thirdConn?.serviceUrlScheme = "backToTheFuture";
    thirdConn?.consumerKey = "rX3iQpQTYSGHh78IXmKU";
    thirdConn?.consumerSecret = "eNOnm_jXPj";
    thirdConn?.appName = "BackToTheFuture_Test";

    locationManager = CLLocationManager()
    if CLLocationManager.locationServicesEnabled() {
        switch CLLocationManager.authorizationStatus() {
            case .denied, .notDetermined, .restricted:
                locationManager.requestAlwaysAuthorization()
                break
            default:
                break
        }
    }


    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
      var applicationResult = false
      if (!applicationResult) {
         applicationResult = NaverThirdPartyLoginConnection.getSharedInstance().application(app, open: url, options: options)
      }
      // if you use other application url process, please add code here.

      if (!applicationResult) {
         applicationResult = super.application(app, open: url, options: options)
      }
      return applicationResult
  }
}
