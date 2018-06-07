//
//  TMSettingsViewControllerProtocol.swift
//  TaskManager
//
//  Created by Денис Ефимов on 07.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//

import Foundation

protocol TMSettingsViewControllerProtocol: class {
    var presenter: TMSettingsPresenterProtocol? { get set }
    
    func setNotificationSwitch(on value: Bool)
    func reloadData()
}
