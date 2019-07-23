import Foundation

protocol TMSettingsViewControllerProtocol: AnyObject {
    var presenter: TMSettingsPresenterProtocol? { get set }

    // Notification control
    func setNotificationSwitch(on value: Bool)

    // Update view
    func reloadData()
}
