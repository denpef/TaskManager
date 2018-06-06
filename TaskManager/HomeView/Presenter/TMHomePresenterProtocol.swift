//
//  TMHomePresenterProtocol.swift
//  TaskManager
//
//  Created by Денис Ефимов on 06.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//

import Foundation

protocol TMHomePresenterProtocol {
    
    var tasksCount: Int { get }
    var view: TMHomeViewControllerProtocol? { get set }
    var wireframe: TMHomeWireframeProtocol? { get set }
    
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
