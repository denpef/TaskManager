//
//  TMTaskDetailPresenterProtocol.swift
//  TaskManager
//
//  Created by Денис Ефимов on 06.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//

import Foundation

protocol TMTaskDetailPresenterProtocol: class {
    
    // Connected view & wireframe with presenter
    var wireframe: TMTaskDetailWireframeProtocol? { get set }
    var view: TMTaskDetailViewControllerProtocol? { get set }
    
    var task: Task? { get set }
    
    // Reload tasks from storage & gives a signal
    // to view for update elements
    func setupView()
    
    // For update from date
    func updateView()
    
    // Work with view actions, when need change data
    func didChangeTitle(text: String)
    func didChangedDate(date: NSDate?)
    func didDeletedTask(completionHandler: () -> ())
    
    // Save the data end return
    func doneButtonTapped()
    
    // Prepeare for segue to select category view
    func setupSelectSegueViewController(selectCategoryView: TMSelectCategoryTableViewControllerProtocol)
    
    // When category was changed
    func didChangedCategory(newValue: ColorCategory)
    
    // For init DatePicker
    func getCompletionDate() -> NSDate?
    
}
