//
//  TMSelectCategoryPresenterProtocol.swift
//  TaskManager
//
//  Created by Денис Ефимов on 07.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//

import Foundation

protocol TMSelectCategoryPresenterProtocol {
    
    // Connected view  with presenter
    var view: TMSelectCategoryTableViewControllerProtocol? { get set }
    var categoryCount: Int { get }
    
    // Reload data from storage & gives a signal
    // to view for update elements
    func getData()
    
    func colorHex(atIndex indexPath: IndexPath) -> String?
    func categoryTitle(atIndex indexPath: IndexPath) -> String?
    
    func didSelectedCell(at indexPath: IndexPath)
    
}
