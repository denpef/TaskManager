//
//  TMTaskDetailViewControllerProtocol.swift
//  TaskManager
//
//  Created by Денис Ефимов on 06.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//

protocol TMTaskDetailViewControllerProtocol: class {
    var presenter: TMTaskDetailPresenterProtocol? { get set }
    
    func setTitle(text: String)
    func setCategoryTitle(text: String)
    func setCategoryColor(hex: String)
    func setDateLabet(text: String)
    func setEmptyCategoryPlaceholder()
    
}
