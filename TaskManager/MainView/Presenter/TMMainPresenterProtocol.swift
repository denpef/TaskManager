//
//  TMHomePresenterProtocol.swift
//  TaskManager
//
//  Created by Денис Ефимов on 06.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//

import Foundation

protocol TMMainPresenterProtocol {
    
    var tasksCount: Int { get }
    
    // Connected view & wireframe with presenter
    var view: TMMainViewControllerProtocol? { get set }
    var wireframe: TMMainWireframeProtocol? { get set }
    
    // Reload tasks from storage & gives a signal
    // to view for update elements
    func getData()
    
    // Fill cell from presenter data
    func configure(cell: TMTaskTableViewCellProtocol, by indexPath: IndexPath)
    
    // + bar button item apped
    func didAddNewTask()
    
    // Segue to detail of selected cell
    func didSelectRowAt(indexPath: IndexPath)
    
    // Presenter must remove element from the data
    func didSDeleteRowAt(indexPath: IndexPath)
    
    // Prepeare for segue to Detail View
    func setupTaskDetailViewController(detailView: TMTaskDetailViewControllerProtocol)
    
    // Prepeare for segue to Settings View
    func setupSettingsDetailViewController(settingsView: TMSettingsViewControllerProtocol)
    
    // Sets the flag to the opposite value
    func invertedCompleteFlag(at indexPath: IndexPath)

}

