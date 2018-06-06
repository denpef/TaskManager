//
//  TMTaskDetailPresenter.swift
//  TaskManager
//
//  Created by Денис Ефимов on 06.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//

import Foundation

class TMTaskDetailPresenter: TMTaskDetailPresenterProtocol {
   
    lazy var formatter: DateFormatter = {
        
        let formatter = DateFormatter()
        
        formatter.calendar = Calendar.current
        formatter.locale = Calendar.current.locale
        formatter.dateFormat = "MMM, dd"
        
        return formatter
    }()
    
    var wireframe: TMTaskDetailViewControllerProtocol?
    var view: TMTaskDetailViewControllerProtocol?
    var task: Task?

    var title: String?
    var completionDate: NSDate?
    var colorCategory: ColorCategory?
    
    func doneButtonTapped() {
        
        if let newTitle = title {
            if newTitle != "" {
                createNewTaskIfNeeded()
                task?.title = title
            }
        }
        
        task?.completionDate = completionDate
        task?.colorCategory = colorCategory
        
        TMPersistentService.saveContext()
    }
    
    func categoryChange() {
        
    }
    
    func setupView() {
        
        // Cash task data
        title = task?.title
        completionDate = task?.completionDate
        colorCategory = task?.colorCategory
        
        //
        view?.setTitle(text: task?.title ?? "")
        view?.setCategoryTitle(text: task?.colorCategory?.title ?? "")
        view?.setCategoryColor(hex: task?.colorCategory?.colorAsHex ?? "")
        if let date = task?.completionDate {
            view?.setDateLabet(text: formatter.string(from: date as Date))
        } else {
            view?.setDateLabet(text: "")
        }
    }
    
    func didChangeTitle(text: String) {
        if text == "" { return }
        title = text
    }
    
    private func createNewTaskIfNeeded() {
        if task != nil { return }
        task = Task(context: TMPersistentService.context)
    }
    
    func didDeletedTask(completionHandler: () -> ()) {
        if let task = task {
            TMPersistentService.context.delete(task)
            TMPersistentService.saveContext()
        }
        completionHandler()
    }
}
