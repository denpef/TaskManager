//
//  TMHomePresenter.swift
//  TaskManager
//
//  Created by Денис Ефимов on 06.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//

import Foundation

class TMHomePresenter {
    
    // MARK: - Properties
    
    var view: TMHomeViewControllerProtocol?
    var wireframe: TMHomeWireframeProtocol?
    
    var tasks: [Task] = []
    var tasksCount: Int {
        return tasks.count
    }
    var currentTask: Task?
    lazy var formatter: DateFormatter = {
        
        let formatter = DateFormatter()
        
        formatter.calendar = Calendar.current
        formatter.locale = Calendar.current.locale
        formatter.dateFormat = "MMM, dd"
        
        return formatter
    }()
    
    init() {
        wireframe = TMHomeWireframe()
    }
    
}

extension TMHomePresenter: TMHomePresenterProtocol {
    
    func task(atIndex indexPath: IndexPath) -> Task? {
        if tasks.indices.contains(indexPath.row) {
            return tasks[indexPath.row]
        } else {
            return nil
        }
    }
    
    func configure(cell: TMTaskTableViewCellProtocol, by indexPath: IndexPath) {
        
        if let task = task(atIndex: indexPath) {
            cell.setTitle(title: task.title ?? "")
            
            if let date = task.completionDate {
                cell.setDateLabelText(text: formatter.string(from: date as Date))
            } else {
                cell.setDateLabelText(text: "No date")
            }
            
            if let colorAsHex = task.colorCategory?.colorAsHex {
                cell.setCategoryColor(by: colorAsHex == "" ? nil : colorAsHex)
            } else {
                cell.setCategoryColor(by: nil)
            }
            
            cell.setCompleteStyle(isCompleted: task.isCompleted)
        }
            
    }
    
    func getData() {
        do {
            self.tasks = try TMPersistentService.context.fetch(Task.fetchRequest())
        } catch {
            self.tasks = []
        }
        view?.reloadData()
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        currentTask = task(atIndex: indexPath)
        
    }
    
    func setupTaskDetailViewController(view: TMTaskDetailViewControllerProtocol) {
        
    }
    
    func setupSettingsDetailViewController(view: TMSettingsViewControllerProtocol) {
        
    }
    
}


