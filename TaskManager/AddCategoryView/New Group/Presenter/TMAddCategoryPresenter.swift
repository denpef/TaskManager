//
//  TMAddCategoryPresenter.swift
//  TaskManager
//
//  Created by Денис Ефимов on 07.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//

import Foundation

class TMAddCategoryPresenter: TMAddCategoryPresenterProtocol {
    
    // Connected view & wireframe with presenter
    var view: TMAddCategoryViewControllerProtocol?
    
    // Hardcode array frome attachment file
    var colors: [String] {
        get {
            return ["#C6DA02", "#79A700", "#F68B2C", "#E2B400", "#F5522D", "#FF6E83"]
        }
    }
    var colorsNames: [String] {
        get {
            return ["Light green", "Green", "Orange", "Yellow", "Red", "Rose"]
        }
    }
    var colorsCount: Int { get { return colors.count } }
    var selectedColorIndex: Int?
    
    
    
    // Check selected cell or not
    func isSelectedCell(at indexPath: IndexPath) -> Bool {
        return indexPath.row == selectedColorIndex
    }
    
    // Save to context
    func didSaved(text: String?) {
        if let colorIndex = selectedColorIndex {
            let newColorCategory = ColorCategory(context: TMPersistentService.context)
            newColorCategory.colorAsHex = colors[colorIndex]
            if let title = text {
                newColorCategory.title = title
            }
            TMPersistentService.saveContext()
            view?.backToSettings()
        } else {
            view?.noColorSelectedWarning()
        }
    }
    
    func colorHex(atIndex indexPath: IndexPath) -> String? {
        if colors.indices.contains(indexPath.row) {
            return colors[indexPath.row]
        } else {
            return nil
        }
    }
    
    func colorName(atIndex indexPath: IndexPath) -> String? {
        if colorsNames.indices.contains(indexPath.row) {
            return colorsNames[indexPath.row]
        } else {
            return nil
        }
    }
    
    func selectColor(at indexPath: IndexPath) {
        if colors.indices.contains(indexPath.row) {
            selectedColorIndex = indexPath.row
            view?.reloadData()
        }
    }
}
