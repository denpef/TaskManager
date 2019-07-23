import Foundation

protocol TMSelectCategoryPresenterProtocol: AnyObject {
    // Connected view  with presenter
    var view: TMSelectCategoryTableViewControllerProtocol? { get set }
    var categoryCount: Int { get }

    // Reload data from storage & gives a signal
    // to view for update elements
    func getData()

    func colorHex(atIndex indexPath: IndexPath) -> String?
    func categoryTitle(atIndex indexPath: IndexPath) -> String?

    func didSelectedCell(at indexPath: IndexPath)
}
