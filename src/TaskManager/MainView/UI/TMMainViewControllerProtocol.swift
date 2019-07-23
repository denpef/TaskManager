protocol TMMainViewControllerProtocol: AnyObject {
    // Reload tableView
    func reloadData()

    // Segue to Detail View
    func presentTaskDetailView()

    // Segue to Settings View
    func presentSettingsView()
}
