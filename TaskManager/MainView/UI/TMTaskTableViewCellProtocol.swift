//
//  TMTaskTableViewCellProtocol.swift
//  TaskManager
//
//  Created by Денис Ефимов on 06.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//

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
