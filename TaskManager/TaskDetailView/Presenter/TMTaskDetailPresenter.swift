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
        formatter.dateFormat = "d MMM yyyy HH:mm"
        
        return formatter
    }()
    
    var wireframe: TMTaskDetailWireframeProtocol?
    var view: TMTaskDetailViewControllerProtocol?
    var task: Task?

    var title: String?
    var completionDate: NSDate?
    var colorCategory: ColorCategory?
    
    private func setViewDate(date: NSDate?) {
        if let date = date {
            view?.setDateLabet(text: formatter.string(from: date as Date))
        } else {
            view?.setDateLabet(text: "")
        }
    }
    
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
        
        // Shedule notification
        if let date = task?.completionDate {
            if let userNotificationsIsOn = UserDefaults.standard.object(forKey: "userNotificationsIsOn") as? Bool {
                if userNotificationsIsOn {
                    if let task = task {
                        print("shedule: \(date)")
                        UserNotificationsManager.shared.scheduleNotification(identifier: task.id!, title: task.title ?? "", subtitle: "", body: "", date: date as Date)
                    }
                }
            } else if let task = task {
                UserNotificationsManager.shared.removePendingNotificationswith(identifiers: [task.id!])
            }
        }
    }
    
    func didChangedCategory(newValue: ColorCategory) {
        colorCategory = newValue
        updateView()
    }
    
    func didChangedDate(date: NSDate?) {
        completionDate = date
        
        setViewDate(date: completionDate)
    }
    
    func setupView() {
        
        // Cash task data
        title = task?.title
        completionDate = task?.completionDate
        colorCategory = task?.colorCategory
    }
    
    func updateView() {
        // set view fields value
        view?.setTitle(text: title ?? "")
        if let category = colorCategory {
            view?.setCategoryTitle(text: category.title ?? "")
            view?.setCategoryColor(hex: category.colorAsHex ?? "")
        } else {
            view?.setEmptyCategoryPlaceholder()
        }
        setViewDate(date: completionDate)
        
    }
    
    func didChangeTitle(text: String) {
        if text == "" { return }
        title = text
        view?.setTitle(text: text)
    }
    
    private func createNewTaskIfNeeded() {
        if task != nil { return }
        task = Task()
    }
    
    func didDeletedTask(completionHandler: () -> ()) {
        if let task = task {
            TMPersistentService.context.delete(task)
            TMPersistentService.saveContext()
        }
        completionHandler()
    }
    
    func setupSelectSegueViewController(selectCategoryView: TMSelectCategoryTableViewControllerProtocol) {
        wireframe?.presentSelectSegueViewController(view: selectCategoryView)
    }
}
