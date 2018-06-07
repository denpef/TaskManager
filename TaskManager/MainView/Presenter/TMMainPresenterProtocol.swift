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
    var view: TMMainViewControllerProtocol? { get set }
    var wireframe: TMMainWireframeProtocol? { get set }
    
    func task(atIndex indexPath: IndexPath) -> Task?
    func getData()
    func configure(cell: TMTaskTableViewCellProtocol, by indexPath: IndexPath)
    func didAddNewTask()
    func didSelectRowAt(indexPath: IndexPath)
    func didSDeleteRowAt(indexPath: IndexPath)
    func setupTaskDetailViewController(detailView: TMTaskDetailViewControllerProtocol)
    func setupSettingsDetailViewController(settingsView: TMSettingsViewControllerProtocol)
    func invertedCompleteFlag(at indexPath: IndexPath)
}
