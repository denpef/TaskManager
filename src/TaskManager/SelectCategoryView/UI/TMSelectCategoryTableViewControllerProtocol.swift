import Foundation

protocol TMSelectCategoryTableViewControllerProtocol: AnyObject {
    var presenter: TMSelectCategoryPresenterProtocol? { get set }

    // Reload tableView
    func reloadData()

    // Segue back to detail view
    func toPopView()
}
