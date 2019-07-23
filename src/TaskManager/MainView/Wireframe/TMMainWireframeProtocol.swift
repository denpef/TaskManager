import Foundation

protocol TMMainWireframeProtocol {
    // Present for Segue to Detail View
    func presentDetailView(with task: Task?, view: TMTaskDetailViewControllerProtocol)

    // Present for Segue to Settings View
    func presentSettingsView(view: TMSettingsViewControllerProtocol)
}
