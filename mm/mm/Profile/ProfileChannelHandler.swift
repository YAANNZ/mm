import Flutter
import UIKit

class ProfileChannelHandler: NSObject {
    private var methodChannel: FlutterMethodChannel?
    private weak var navigationController: UINavigationController?

    func register(with engine: FlutterEngine, navigationController: UINavigationController?) {
        self.navigationController = navigationController

        methodChannel = FlutterMethodChannel(
            name: "com.aimusic/profile",
            binaryMessenger: engine.binaryMessenger
        )

        methodChannel?.setMethodCallHandler { [weak self] call, result in
            self?.handleMethodCall(call, result: result)
        }
    }

    private func handleMethodCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "openProfile":
            let profileVC = UserProfileViewController()
            navigationController?.pushViewController(profileVC, animated: true)
            result(nil)

        case "openSettings":
            let settingsVC = SettingsViewController()
            navigationController?.pushViewController(settingsVC, animated: true)
            result(nil)

        case "getAuthToken":
            // Read token from UserDefaults (shared with Flutter's SharedPreferences)
            let token = UserDefaults.standard.string(forKey: "flutter.auth_token")
            result(token)

        case "onLogout":
            UserDefaults.standard.removeObject(forKey: "flutter.auth_token")
            result(nil)

        default:
            result(FlutterMethodNotImplemented)
        }
    }

    func notifyProfileUpdated(_ userData: [String: Any]) {
        methodChannel?.invokeMethod("onProfileUpdated", arguments: userData)
    }
}
