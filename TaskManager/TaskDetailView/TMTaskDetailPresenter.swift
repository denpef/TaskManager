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

    func didDeleted() {
        
    }
    func categoryChange() {
        
    }
    
    func setupView() {
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
        createNewTaskIfNeeded()
        task?.title = text
        
        TMPersistentService.saveContext()

    }
    
    private func createNewTaskIfNeeded() {
        if task != nil { return }
        task = Task(context: TMPersistentService.context)
    }
    
}
