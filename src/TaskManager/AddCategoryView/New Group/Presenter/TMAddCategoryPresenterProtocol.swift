import Foundation

protocol TMAddCategoryPresenterProtocol {
    // Connected view & wireframe with presenter
    var view: TMAddCategoryViewControllerProtocol? { get set }
    var colorsCount: Int { get }

    // For update table cell
    func colorHex(atIndex indexPath: IndexPath) -> String?
    func colorName(atIndex indexPath: IndexPath) -> String?

    // Check selected/not
    func isSelectedCell(at indexPath: IndexPath) -> Bool

    func selectColor(at indexPath: IndexPath)

    func didSaved(text: String?)
}
