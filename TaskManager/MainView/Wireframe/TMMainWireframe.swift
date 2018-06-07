//
//  TMHomeWireframe.swift
//  TaskManager
//
//  Created by Денис Ефимов on 06.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//

import Foundation

class TMMainWireframe: TMMainWireframeProtocol {
    
    // Present for Segue to Detail View
    func presentDetailView(with task: Task?, view: TMTaskDetailViewControllerProtocol) {
        
        // Create presenter for work with data
        let detailPresenter = TMTaskDetailPresenter()
        
        // Create wireframe for present seguees
        let wireframe = TMTaskDetailWireframe()
        
        // Binding
        wireframe.presenter = detailPresenter
        
        detailPresenter.wireframe = wireframe
        detailPresenter.task = task
        detailPresenter.view = view
        
        view.presenter = detailPresenter
        
    }
    
    
    // Present for Segue to Settings View
    func presentSettingsView(view: TMSettingsViewControllerProtocol) {
        
        // Create presenter for work with data
        let settingsPresenter = TMSettingsPresenter()
        
        // Binding
        settingsPresenter.view = view
        
        // Create wireframe for present seguees
        settingsPresenter.wireframe = TMSettingsWireframe()
        
        view.presenter = settingsPresenter
    }
    
}
