//
//  TMTaskDetailPresenterProtocol.swift
//  TaskManager
//
//  Created by Денис Ефимов on 06.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//

import Foundation

protocol TMTaskDetailPresenterProtocol {
    
    var wireframe: TMTaskDetailWireframeProtocol? { get set }
    var view: TMTaskDetailViewControllerProtocol? { get set }
    
    func setupView()
    func updateView()
    
    func didChangeTitle(text: String)
    func didChangedDate(date: NSDate?)
    
    func didDeletedTask(completionHandler: () -> ())
    func doneButtonTapped()
    
    func setupSelectSegueViewController(selectCategoryView: TMSelectCategoryTableViewControllerProtocol)
    
    func didChangedCategory(newValue: ColorCategory)
    
}
