//
//  TMAddCategoryPresenterProtocol.swift
//  TaskManager
//
//  Created by Денис Ефимов on 07.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//

import Foundation

protocol TMAddCategoryPresenterProtocol {
    
    // Connected view & wireframe with presenter
    var view: TMAddCategoryViewControllerProtocol? { get set }
    var colorsCount: Int { get }
    
    // For update table cell
    func colorHex(atIndex indexPath: IndexPath) -> String?
    func colorName(atIndex indexPath: IndexPath) -> String?
    
    // Check selected/not
    func isSelectedCell(at indexPath: IndexPath) -> Bool
    
    func selectColor(at indexPath: IndexPath)
    
    func didSaved(text: String?)
}

