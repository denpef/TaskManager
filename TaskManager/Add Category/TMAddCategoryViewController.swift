//
//  TMAddCategoryViewController.swift
//  TaskManager
//
//  Created by Денис Ефимов on 07.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//

import UIKit

class TMAddCategoryViewController: UIViewController, TMAddCategoryViewControllerProtocol {
    
    var presenter: TMAddCategoryPresenterProtocol?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.autocapitalizationType = .sentences
        
    }

    @IBAction func cancellButtonTap(_ sender: Any) {
        backToSettings()
    }
    
    @IBAction func saveButtonTap(_ sender: Any) {
        presenter?.didSaved(text: titleTextField.text)
    }
    
    // MARK: - TMAddCategoryViewControllerProtocol
    
    func reloadData() {
        tableView.reloadData()
    }

    func noColorSelectedWarning() {
        
        // Alert controller
        let alertController = UIAlertController(title: "Please choose a color", message: "", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func backToSettings() {
        navigationController?.popViewController(animated: true)
    }
}

extension TMAddCategoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.colorsCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ColorCell", for: indexPath) as! TMColorTableViewCell
        
        cell.colorNameLabel.text = presenter?.colorName(atIndex: indexPath)
        if let hex = presenter?.colorHex(atIndex: indexPath) {
            cell.colorView.backgroundColor = UIColor(hex: hex)
        }
        
        if presenter?.isSelectedCell(at: indexPath) ?? false {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}

extension TMAddCategoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selectColor(at: indexPath)
    }
}

extension TMAddCategoryViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}
