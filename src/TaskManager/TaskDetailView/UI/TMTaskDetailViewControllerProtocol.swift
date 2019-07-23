protocol TMTaskDetailViewControllerProtocol: AnyObject {
    var presenter: TMTaskDetailPresenterProtocol? { get set }

    // Metods of update text fields
    func setTitle(text: String)
    func setCategoryTitle(text: String)
    func setCategoryColor(hex: String)
    func setDateLabet(text: String)
    func setEmptyCategoryPlaceholder()
}
