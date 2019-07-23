import Foundation

protocol TMSettingsPresenterProtocol {
    // Connected view & wireframe with presenter
    var view: TMSettingsViewControllerProtocol? { get set }
    var wireframe: TMSettingsWireframeProtocol? { get set }

    // Count of categories for table view
    var categoryCount: Int { get }

    // Reload data from storage & gives a signal
    // to view for update elements
    func getData()
    func setupView()

    // Notification enable/disable flag
    func didChangedNotificationSwitchValue(on value: Bool)

    // send data to table view cell
    func cellTitleAt(indexPath: IndexPath) -> String
    func cellHexAt(indexPath: IndexPath) -> String

    func setupAddCategoryViewController(categoryView: TMAddCategoryViewControllerProtocol)
}
