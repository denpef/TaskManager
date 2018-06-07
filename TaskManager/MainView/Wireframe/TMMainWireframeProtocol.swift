//
//  TMHomeWireframeProtocol.swift
//  TaskManager
//
//  Created by Денис Ефимов on 06.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//

import Foundation

protocol TMMainWireframeProtocol {
    
    // Present for Segue to Detail View
    func presentDetailView(with task: Task?, view: TMTaskDetailViewControllerProtocol)
    
    // Present for Segue to Settings View
    func presentSettingsView(view: TMSettingsViewControllerProtocol)
}
