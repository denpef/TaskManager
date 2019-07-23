import Foundation

class TMTaskDetailWireframe: TMTaskDetailWireframeProtocol {
    weak var presenter: TMTaskDetailPresenterProtocol?

    func presentSelectSegueViewController(view: TMSelectCategoryTableViewControllerProtocol) {
        let newPresenter = TMSelectCategoryPresenter()
        newPresenter.view = view
        newPresenter.currentTaskPresenter = presenter
        view.presenter = newPresenter
    }
}
