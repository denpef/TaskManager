//
//  TMAddCategoryViewControllerProtocol.swift
//  TaskManager
//
//  Created by Денис Ефимов on 07.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//

import Foundation

protocol TMAddCategoryViewControllerProtocol: class {
    
    var presenter: TMAddCategoryPresenterProtocol? { get set }
    
    // reload table view
    func reloadData()
    
    // Alert question
    func noColorSelectedWarning()
    
    // Segue back
    func backToSettings()
}
