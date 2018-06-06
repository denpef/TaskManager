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
    
    func task(atIndex indexPath: IndexPath) -> Task?
    func getData() -> ()
    func tasksColorAsHex(atIndex: IndexPath) -> String?
    func tasksName(atIndex: IndexPath) -> String
    func tasksDate(atIndex: IndexPath) -> String
}
