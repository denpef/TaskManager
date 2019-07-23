import UIKit

protocol TMTaskTableViewCellProtocol {
    // Set title Text Field
    func setTitle(title: String)

    // Set data label text
    func setDateLabelText(text: String)

    // Set image color
    func setCategoryColor(by hex: String?)

    // Set different values Alpha depending on the flag
    func setCompleteStyle(isCompleted: Bool)
}
