import Foundation
import UserNotifications
import UserNotificationsUI

class UserNotificationsManager: NSObject {
    static let shared = UserNotificationsManager()

    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }

    func removePendingNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

    func removePendingNotificationswith(identifiers: [String]) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
    }

    func registerForNotifications(options: UNAuthorizationOptions) {
        UNUserNotificationCenter.current().requestAuthorization(options: options) { granted, _ in
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    }

    func scheduleNotification(identifier: String, title: String, subtitle: String, body: String, date: Date, repeats: Bool = false) {
        let calendar = Calendar.current
        let components = calendar.dateComponents(in: .current, from: date)
        // swiftlint:disable force_cast
        let newComponents = DateComponents(calendar: calendar,
                                           timeZone: .current,
                                           month: components.month,
                                           day: components.day,
                                           hour: components.hour,
                                           minute: components.minute,
                                           second: components.second)

        let trigger = UNCalendarNotificationTrigger(dateMatching: newComponents, repeats: repeats)

        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        content.sound = UNNotificationSound.default()

        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error: \(error)")
            }
        }
    }

    func removeNotification(identifire: [String]) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifire)
    }
}

extension UserNotificationsManager: UNUserNotificationCenterDelegate {
    public func userNotificationCenter(_: UNUserNotificationCenter, willPresent _: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }
}
