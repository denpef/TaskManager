import Foundation

protocol TMTaskDetailWireframeProtocol {
    var presenter: TMTaskDetailPresenterProtocol? { get set }

    func presentSelectSegueViewController(view: TMSelectCategoryTableViewControllerProtocol)
}
