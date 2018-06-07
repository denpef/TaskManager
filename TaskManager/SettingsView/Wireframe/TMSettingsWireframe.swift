//
//  TMSettingsWireframe.swift
//  TaskManager
//
//  Created by Денис Ефимов on 07.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//

import Foundation

class TMSettingsWireframe: TMSettingsWireframeProtocol {
   
    // Present for Segue to Add Category View
    func presentAddCategoryView(view: TMAddCategoryViewControllerProtocol) {
        let addCategoryPresenter = TMAddCategoryPresenter()
        addCategoryPresenter.view = view
        view.presenter = addCategoryPresenter
    }
}
