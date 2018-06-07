//
//  TMSelectCategoryTableViewControllerProtocol.swift
//  TaskManager
//
//  Created by Денис Ефимов on 07.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//

import Foundation

protocol TMSelectCategoryTableViewControllerProtocol: class {
    
    var presenter: TMSelectCategoryPresenterProtocol? { get set }
    
    // Reload tableView
    func reloadData()
    
    // Segue back to detail view
    func toPopView()
    
}
