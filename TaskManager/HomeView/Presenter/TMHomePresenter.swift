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
    
}

extension TMHomePresenter: TMHomePresenterProtocol {
    
    func task(atIndex indexPath: IndexPath) -> Task? {
        if tasks.indices.contains(indexPath.row) {
            return tasks[indexPath.row]
        } else {
            return nil
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
    
}

