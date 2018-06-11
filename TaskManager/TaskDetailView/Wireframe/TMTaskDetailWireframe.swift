//
//  TMTaskDetailWireframe.swift
//  TaskManager
//
//  Created by Денис Ефимов on 07.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//

import Foundation

class TMTaskDetailWireframe: TMTaskDetailWireframeProtocol {
    
    weak var presenter: TMTaskDetailPresenterProtocol?
    
    func presentSelectSegueViewController(view: TMSelectCategoryTableViewControllerProtocol) {
        let newPresenter = TMSelectCategoryPresenter()
        newPresenter.view = view
        newPresenter.currentTaskPresenter = self.presenter
        view.presenter = newPresenter
    }
    
}
