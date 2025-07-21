import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let deviceInfoChannel = FlutterMethodChannel(name: "varosa_tech/device_info",
                                               binaryMessenger: controller.binaryMessenger)
    
    deviceInfoChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      switch call.method {
      case "getDeviceInfo":
        self.getDeviceInfo(result: result)
      case "getBatteryLevel":
        self.getBatteryLevel(result: result)
      default:
        result(FlutterMethodNotImplemented)
      }
    }
    
    // Register the native button view factory
    let registrar = self.registrar(forPlugin: "NativeButtonPlugin")
    let factory = NativeButtonViewFactory(messenger: registrar!.messenger())
    registrar!.register(factory, withId: "varosa_tech/native_button")
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  private func getDeviceInfo(result: @escaping FlutterResult) {
    UIDevice.current.isBatteryMonitoringEnabled = true
    
    let batteryLevel = Int(UIDevice.current.batteryLevel * 100)
    let deviceModel = UIDevice.current.model
    let isCharging = UIDevice.current.batteryState == .charging || UIDevice.current.batteryState == .full
    let systemTime = ISO8601DateFormatter().string(from: Date())
    
    let deviceInfo: [String: Any] = [
      "batteryLevel": batteryLevel,
      "deviceModel": deviceModel,
      "isCharging": isCharging,
      "systemTime": systemTime
    ]
    
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: deviceInfo, options: [])
      let jsonString = String(data: jsonData, encoding: .utf8) ?? "{}"
      result(jsonString)
    } catch {
      result(FlutterError(code: "JSON_ERROR", message: "Failed to create JSON", details: error.localizedDescription))
    }
  }
  
  private func getBatteryLevel(result: @escaping FlutterResult) {
    UIDevice.current.isBatteryMonitoringEnabled = true
    let batteryLevel = Int(UIDevice.current.batteryLevel * 100)
    
    if batteryLevel < 0 {
      result(FlutterError(code: "UNAVAILABLE", message: "Battery level not available", details: nil))
    } else {
      result(batteryLevel)
    }
  }
}
