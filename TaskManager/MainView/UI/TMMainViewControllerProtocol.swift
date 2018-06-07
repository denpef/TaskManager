//
//  TMHomeViewControllerProtocol.swift
//  TaskManager
//
//  Created by Денис Ефимов on 06.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//

protocol TMMainViewControllerProtocol {
    
    // Reload tableView
    func reloadData()
    
    // Segue to Detail View
    func presentTaskDetailView()
    
    // Segue to Settings View
    func presentSettingsView()
}
