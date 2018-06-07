//
//  TMSettingsPresenter.swift
//  TaskManager
//
//  Created by Денис Ефимов on 07.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//

import Foundation

class TMSettingsPresenter: TMSettingsPresenterProtocol {
        
    var categories: [ColorCategory] = []
    var view: TMSettingsViewControllerProtocol?
    var wireframe: TMSettingsWireframeProtocol?
    var userNotificationsIsOn: Bool {
        get {
            guard let value = UserDefaults.standard.object(forKey: "userNotificationsIsOn") as? Bool else {
                UserDefaults.standard.set(false, forKey: "userNotificationsIsOn")
                return false
            }
            return value
        }
        set(newUserNotificationsIsOn) {
            UserDefaults.standard.set(newUserNotificationsIsOn, forKey: "userNotificationsIsOn")
        }
    }
    var categoryCount: Int { get {return categories.count} }
    
    private func category(atIndex indexPath: IndexPath) -> ColorCategory? {
        if categories.indices.contains(indexPath.row) {
            return categories[indexPath.row]
        } else {
            return nil
        }
    }
    
    func getData() {
        do {
            self.categories = try TMPersistentService.context.fetch(ColorCategory.fetchRequest())
        } catch {
            self.categories = []
        }
        view?.reloadData()
    }
    
    func setupView() {
        view?.setNotificationSwitch(on: userNotificationsIsOn)
    }
    
    func didChangedNotificationSwitchValue(on value: Bool) {
        userNotificationsIsOn = value
        if value {
            // User Notifications register
            UserNotificationsManager.shared.registerForNotifications(options: [.alert, .badge, .sound])
            
            let tasks = TMPersistentService.getTasksWithADateGreaterThanTheCurrent()
            for taskValue in tasks {
                // Shedule notification
                if let date = taskValue.completionDate {
                    print("shedule: \(date)")
                    UserNotificationsManager.shared.scheduleNotification(identifier: taskValue.id!, title: taskValue.title ?? "", subtitle: "", body: "", date: date as Date)
                }
            }
        } else {
            UserNotificationsManager.shared.removePendingNotifications()
        }
    }
    
    func cellTitleAt(indexPath: IndexPath) -> String {
        if let category = category(atIndex: indexPath) {
            return category.title ?? ""
        }
        return ""
    }
    
    func cellHexAt(indexPath: IndexPath) -> String {
        if let category = category(atIndex: indexPath) {
            return category.colorAsHex ?? ""
        }
        return ""
    }
    
    func setupAddCategoryViewController(categoryView: TMAddCategoryViewControllerProtocol) {
        wireframe?.presentAddCategoryView(view: categoryView)
    }
}
