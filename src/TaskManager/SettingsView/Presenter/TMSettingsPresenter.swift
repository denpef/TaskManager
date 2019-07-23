import Foundation

class TMSettingsPresenter: TMSettingsPresenterProtocol {
    // Categories data
    var categories: [ColorCategory] = []
    var categoryCount: Int { return categories.count }

    // Connected view & wireframe with presenter
    weak var view: TMSettingsViewControllerProtocol?
    var wireframe: TMSettingsWireframeProtocol?

    // Notification flag
    var userNotificationsIsOn: Bool {
        get {
            guard let value = UserDefaults.standard.object(forKey: "userNotificationsIsOn") as? Bool else {
                UserDefaults.standard.set(false, forKey: "userNotificationsIsOn")
                return false
            }
            return value
        }
        set(newUserNotificationsIsOn) {
            UserDefaults.standard.set(newUserNotificationsIsOn, forKey: "userNotificationsIsOn")
        }
    }

    // Check category by index in category array
    private func category(atIndex indexPath: IndexPath) -> ColorCategory? {
        if categories.indices.contains(indexPath.row) {
            return categories[indexPath.row]
        } else {
            return nil
        }
    }

    // Reload data from storage & gives a signal
    // to view for update elements
    func getData() {
        do {
            categories = try TMPersistentService.context.fetch(ColorCategory.fetchRequest())
        } catch {
            categories = []
        }
        view?.reloadData()
    }

    // Signal to update
    func setupView() {
        view?.setNotificationSwitch(on: userNotificationsIsOn)
    }

    // A switch that will globally turn off / on all local notifications
    // when deactivated, remove notifications
    // when activated, puts on schedule
    func didChangedNotificationSwitchValue(on value: Bool) {
        userNotificationsIsOn = value
        if value {
            // User Notifications register
            UserNotificationsManager.shared.registerForNotifications(options: [.alert, .badge, .sound])

            // fetch request inside
            let tasks = TMPersistentService.getTasksWithADateGreaterThanTheCurrent()
            for taskValue in tasks {
                // Shedule notification
                if let date = taskValue.completionDate {
                    UserNotificationsManager.shared.scheduleNotification(identifier: taskValue.id!, title: taskValue.title ?? "", subtitle: "", body: "", date: date as Date)
                }
            }
        } else {
            // Remove all notifications when the flag turn off
            UserNotificationsManager.shared.removePendingNotifications()
        }
    }

    func cellTitleAt(indexPath: IndexPath) -> String {
        if let category = category(atIndex: indexPath) {
            return category.title ?? ""
        }
        return ""
    }

    func cellHexAt(indexPath: IndexPath) -> String {
        if let category = category(atIndex: indexPath) {
            return category.colorAsHex ?? ""
        }
        return ""
    }

    func setupAddCategoryViewController(categoryView: TMAddCategoryViewControllerProtocol) {
        wireframe?.presentAddCategoryView(view: categoryView)
    }
}
