//
//  TMSettingsPresenterProtocol.swift
//  TaskManager
//
//  Created by Денис Ефимов on 07.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//

import Foundation

protocol TMSettingsPresenterProtocol {
    var view: TMSettingsViewControllerProtocol? { get set }
    var categoryCount: Int { get }
    func setupView()
    func didChangedNotificationSwitchValue(on value: Bool)
    func cellTitleAt(indexPath: IndexPath)  -> String
    func cellHexAt(indexPath: IndexPath)  -> String 
}
