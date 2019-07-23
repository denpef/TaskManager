import Foundation

class TMSettingsWireframe: TMSettingsWireframeProtocol {
    // Present for Segue to Add Category View
    func presentAddCategoryView(view: TMAddCategoryViewControllerProtocol) {
        let addCategoryPresenter = TMAddCategoryPresenter()
        addCategoryPresenter.view = view
        view.presenter = addCategoryPresenter
    }
}
