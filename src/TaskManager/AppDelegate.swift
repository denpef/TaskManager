import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    func applicationDidFinishLaunching(_: UIApplication) {
        if let _ = UserDefaults.standard.object(forKey: "userNotificationsIsOn") {}
        else {
            UserDefaults.standard.set(false, forKey: "userNotificationsIsOn")
        }
    }

    func applicationWillTerminate(_: UIApplication) {
        TMPersistentService.saveContext()
    }
}
