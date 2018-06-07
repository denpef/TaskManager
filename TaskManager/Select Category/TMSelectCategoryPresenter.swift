//
//  TMSelectCategoryPresenter.swift
//  TaskManager
//
//  Created by Денис Ефимов on 07.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//

import Foundation

class TMSelectCategoryPresenter: TMSelectCategoryPresenterProtocol {
    
    var currentTaskPresenter: TMTaskDetailPresenterProtocol?
    var categories: [ColorCategory] = []
    var view: TMSelectCategoryTableViewControllerProtocol?
    var categoryCount: Int { get {
            return categories.count
        }
    }
    
    private func category(atIndex indexPath: IndexPath) -> ColorCategory? {
        if categories.indices.contains(indexPath.row) {
            return categories[indexPath.row]
        } else {
            return nil
        }
    }
    
    func colorHex(atIndex indexPath: IndexPath) -> String? {
        if let category = category(atIndex: indexPath) {
            return category.colorAsHex ?? ""
        }
        return ""
    }
    
    func categoryTitle(atIndex indexPath: IndexPath) -> String? {
        if let category = category(atIndex: indexPath) {
            return category.title ?? ""
        }
        return ""
    }
    
    func didSelectedCell(at indexPath: IndexPath) {
        if let category = category(atIndex: indexPath) {
            currentTaskPresenter?.didChangedCategory(newValue: category)
            view?.toPopView()
        }
    }
    
    func getData() {
        do {
            self.categories = try TMPersistentService.context.fetch(ColorCategory.fetchRequest())
        } catch {
            self.categories = []
        }
        view?.reloadData()
    }
}
