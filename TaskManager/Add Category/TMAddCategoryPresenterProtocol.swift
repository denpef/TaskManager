//
//  TMAddCategoryPresenterProtocol.swift
//  TaskManager
//
//  Created by Денис Ефимов on 07.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//

import Foundation

protocol TMAddCategoryPresenterProtocol {
    var view: TMAddCategoryViewControllerProtocol? { get set }
    var colorsCount: Int { get }
    
    func colorHex(atIndex indexPath: IndexPath) -> String?
    func colorName(atIndex indexPath: IndexPath) -> String?
    
    func selectColor(at indexPath: IndexPath)
    func isSelectedCell(at indexPath: IndexPath) -> Bool
    
    func didSaved(text: String?)
}

