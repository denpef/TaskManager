//
//  TMTaskTableViewCellProtocol.swift
//  TaskManager
//
//  Created by Денис Ефимов on 06.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//

import UIKit

protocol TMTaskTableViewCellProtocol {
    
    func setTitle(title: String)
    func setDateLabelText(text: String)
    func setCategoryColor(by hex: String?)
    func setCompleteStyle(isCompleted: Bool)
    
}
