//
//  TMHomeWireframe.swift
//  TaskManager
//
//  Created by Денис Ефимов on 06.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//

import Foundation

class TMHomeWireframe: TMHomeWireframeProtocol {
    
    func presentDetailView(with task: Task?, view: TMTaskDetailViewControllerProtocol) {
        let detailPresenter = TMTaskDetailPresenter()
        detailPresenter.task = task
        detailPresenter.view = view
        view.presenter = detailPresenter
    }
    
    func presentSettingsView(view: TMSettingsViewControllerProtocol) {
        
    }
    
}
