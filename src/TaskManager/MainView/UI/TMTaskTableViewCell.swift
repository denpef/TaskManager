import UIKit

class TMTaskTableViewCell: UITableViewCell {
    @IBOutlet var completeTaskImage: UIImageView!
    @IBOutlet var taskNameLabel: UILabel!
    @IBOutlet var completionDateLabel: UILabel!
    @IBOutlet var colorCategoryImage: UIImageView!
    @IBOutlet var completedFlagView: UIView!
}

extension TMTaskTableViewCell: TMTaskTableViewCellProtocol {
    // Set title Text Field
    func setTitle(title: String) {
        taskNameLabel.text = title
    }

    // Set title Text Field
    func setDateLabelText(text: String) {
        completionDateLabel.text = text
    }

    // Set image color
    func setCategoryColor(by hex: String?) {
        if let colorAsHex = hex {
            colorCategoryImage.backgroundColor = UIColor(hex: colorAsHex)
        } else {
            colorCategoryImage.backgroundColor = UIColor.clear
        }
    }

    // Set different values Alpha depending on the flag
    func setCompleteStyle(isCompleted: Bool) {
        let completedAplpha: CGFloat = 0.4
        let notCompletedAplpha: CGFloat = 1

        // Pictures were created in the program Sketch
        completeTaskImage.image = isCompleted ? #imageLiteral(resourceName: "completed") : #imageLiteral(resourceName: "notCompleted")

        completeTaskImage.alpha = isCompleted ? completedAplpha : notCompletedAplpha
        taskNameLabel.alpha = isCompleted ? completedAplpha : notCompletedAplpha
        completionDateLabel.alpha = isCompleted ? completedAplpha : notCompletedAplpha
        colorCategoryImage.alpha = isCompleted ? completedAplpha : notCompletedAplpha
    }
}
