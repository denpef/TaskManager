//
//  TMTaskTableViewCell.swift
//  TaskManager
//
//  Created by Денис Ефимов on 06.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//

import UIKit

class TMTaskTableViewCell: UITableViewCell  {

    @IBOutlet weak var completeTaskImage: UIImageView!
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var completionDateLabel: UILabel!
    @IBOutlet weak var colorCategoryImage: UIImageView!
    @IBOutlet weak var completedFlagView: UIView!
}
extension TMTaskTableViewCell: TMTaskTableViewCellProtocol {

    func setTitle(title: String) {
        taskNameLabel.text = title
    }
    
    func setDateLabelText(text: String) {
         completionDateLabel.text = text
    }
    
    func setCategoryColor(by hex: String?) {
        if let colorAsHex = hex {
            colorCategoryImage.backgroundColor = UIColor(hex: colorAsHex)
        } else {
            colorCategoryImage.backgroundColor = UIColor.clear
        }
    }
    
    func setCompleteStyle(isCompleted: Bool) {
        
        let completedAplpha: CGFloat = 0.4
        let notCompletedAplpha: CGFloat = 1
        
        completeTaskImage.image = isCompleted ? #imageLiteral(resourceName: "completed") : #imageLiteral(resourceName: "notCompleted")
        
        completeTaskImage.alpha = isCompleted ? completedAplpha : notCompletedAplpha
        taskNameLabel.alpha = isCompleted ? completedAplpha : notCompletedAplpha
        completionDateLabel.alpha = isCompleted ? completedAplpha : notCompletedAplpha
        colorCategoryImage.alpha = isCompleted ? completedAplpha : notCompletedAplpha
    }

}
