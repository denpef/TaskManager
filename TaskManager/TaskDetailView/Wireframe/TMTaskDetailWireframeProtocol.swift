//
//  TMTaskDetailWireframeProtocol.swift
//  TaskManager
//
//  Created by Денис Ефимов on 07.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//

import Foundation

protocol TMTaskDetailWireframeProtocol {
    
    var presenter: TMTaskDetailPresenterProtocol? { get set }
    
    func presentSelectSegueViewController(view: TMSelectCategoryTableViewControllerProtocol)
}