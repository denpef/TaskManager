import Foundation

protocol TMAddCategoryViewControllerProtocol: AnyObject {
    var presenter: TMAddCategoryPresenterProtocol? { get set }

    // reload table view
    func reloadData()

    // Alert question
    func noColorSelectedWarning()

    // Segue back
    func backToSettings()
}
