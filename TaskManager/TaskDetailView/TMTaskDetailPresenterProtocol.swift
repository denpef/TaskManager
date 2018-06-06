//
//  TMTaskDetailPresenterProtocol.swift
//  TaskManager
//
//  Created by Денис Ефимов on 06.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//

import Foundation

protocol TMTaskDetailPresenterProtocol {
    
    var wireframe: TMTaskDetailViewControllerProtocol? { get set }
    var view: TMTaskDetailViewControllerProtocol? { get set }
    
    func setupView()
    
    func didChangedCategory()
    func didChangeTitle(text: String)
    func didChangedDate(date: NSDate?)
    
    func didDeletedTask(completionHandler: () -> ())
    func doneButtonTapped()
    
}
