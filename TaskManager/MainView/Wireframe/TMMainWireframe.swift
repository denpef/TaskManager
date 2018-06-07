//
//  TMHomeWireframe.swift
//  TaskManager
//
//  Created by Денис Ефимов on 06.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//

import Foundation

class TMMainWireframe: TMMainWireframeProtocol {
    
    func presentDetailView(with task: Task?, view: TMTaskDetailViewControllerProtocol) {
        
        let detailPresenter = TMTaskDetailPresenter()
        let wireframe = TMTaskDetailWireframe()
        
        wireframe.presenter = detailPresenter
        
        detailPresenter.wireframe = wireframe
        detailPresenter.task = task
        detailPresenter.view = view
        
        view.presenter = detailPresenter
        
    }
    
    func presentSettingsView(view: TMSettingsViewControllerProtocol) {
        let settingsPresenter = TMSettingsPresenter()
        settingsPresenter.view = view
        settingsPresenter.wireframe = TMSettingsWireframe()
        view.presenter = settingsPresenter
    }
    
}
