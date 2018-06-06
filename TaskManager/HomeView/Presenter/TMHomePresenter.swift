//
//  TMHomePresenter.swift
//  TaskManager
//
//  Created by Денис Ефимов on 06.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//

import Foundation

class TMHomePresenter {
    
    var view: TMHomeViewControllerProtocol?
    var tasks: [Task] = []
    var tasksCount: Int {
        return tasks.count
    }
    lazy var formatter: DateFormatter = {
        
        let formatter = DateFormatter()
        
        formatter.calendar = Calendar.current
        formatter.locale = Calendar.current.locale
        formatter.dateFormat = "MMM, dd"
        
        return formatter
    }()
    
}

extension TMHomePresenter: TMHomePresenterProtocol {
    
    func task(atIndex indexPath: IndexPath) -> Task? {
        if tasks.indices.contains(indexPath.row) {
            return tasks[indexPath.row]
        } else {
            return nil
        }
    }
    
    func tasksColorAsHex(atIndex indexPath: IndexPath) -> String? {
        if let task = task(atIndex: indexPath) {
            if let colorAsHex = task.colorCategory?.colorAsHex {
                return colorAsHex == "" ? nil : colorAsHex
            }
        }
        return nil
    }
    
    func tasksName(atIndex indexPath: IndexPath)  -> String {
        if let task = task(atIndex: indexPath) {
            return task.title ?? ""
        }
        return ""
    }
    
    func tasksDate(atIndex indexPath: IndexPath)  -> String {
        if let task = task(atIndex: indexPath) {
            if let date = task.completionDate {
                return formatter.string(from: date as Date)
            }
        }
        return "No date"
    }
    
    func getData() {
        do {
            self.tasks = try TMPersistentService.context.fetch(Task.fetchRequest())
        } catch {
            self.tasks = []
        }
        view?.reloadData()
    }
    
}

