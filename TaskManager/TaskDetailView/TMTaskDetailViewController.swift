//
//  TMTaskDetailViewController.swift
//  TaskManager
//
//  Created by Денис Ефимов on 06.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//

import UIKit

class TMTaskDetailViewController: UITableViewController, TMTaskDetailViewControllerProtocol {
    
    var presenter: TMTaskDetailPresenterProtocol?
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var categoryTextField: UITextField!
    @IBOutlet var dateTextField: UITextField!
    
    @IBOutlet var deleteBarBurronItem: UIBarButtonItem!
    @IBOutlet var doneBarBurronItem: UIBarButtonItem!
    
    @IBAction func doneBarButtonTouchUpInside(_ sender: Any) {
        self.view.endEditing(true)
        presenter?.doneButtonTapped()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteBarButtonItemTap(_ sender: Any) {
        
        // Alert controller
        let alertController = UIAlertController(title: titleTextField.text, message: "will be irretrievably deleted", preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
        }
        alertController.addAction(cancelAction)
        
        let destroyAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            self.presenter?.didDeletedTask {
                self.navigationController?.popViewController(animated: true)
            }
        }
        alertController.addAction(destroyAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func setTitle(text: String) {
        titleTextField.text = text
    }
    
    func setCategoryTitle(text: String) {
        categoryTextField.text = text
    }
    
    func setCategoryColor(hex: String) {
        categoryTextField.backgroundColor = UIColor(hex: hex)
    }
    
    func setDateLabet(text: String) {
        dateTextField.text = text
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Text fields
        titleTextField.autocapitalizationType = .sentences
        
        setupDatePicker()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.setupView()
    }
    
    // MARK: Date toolbar
    
    private func createToolbar(title: String, actionDone: Selector, actionDelete: Selector) -> UIToolbar {
        
        let delete = UIBarButtonItem(title: "Clear", style: .done, target: self, action: actionDelete)
        delete.tintColor = #colorLiteral(red: 0.9196171467, green: 0.2142267733, blue: 0.2214575526, alpha: 0.9)
        
        let spaceLeft = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textAlignment = .center
        
        let titleItem = UIBarButtonItem(customView: titleLabel)

        let spaceRight = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: actionDone)
        
        let toolbar = UIToolbar()
        
        toolbar.setItems([delete, spaceLeft, titleItem, spaceRight, done], animated: false)
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        toolbar.isUserInteractionEnabled = true
        
        return toolbar
    }
    
    func setupDatePicker() {
        
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 260)
        
        let toolbar = createToolbar(title: "Completion date", actionDone: #selector(doneDateClick), actionDelete: #selector(cleareDateClick))
        
        dateTextField.inputAccessoryView = toolbar
        let datePickerView = DatePickerViewController(frame: frame)
        datePickerView.picker.datePickerMode = .date
        datePickerView.presenter = presenter
        dateTextField.inputView = datePickerView
        
    }
    
    @objc private func doneDateClick() {
        self.view.endEditing(true)
    }
    
    
    @objc private func cleareDateClick() {
        presenter?.didChangedDate(date: nil)
        self.view.endEditing(true)
    }

}

extension TMTaskDetailViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        if let dateInputView = textField.inputView as? DatePickerViewController {
//            //dateInputView.picker.setDate(Calendar.current.startOfDay(for: point!.date! as Date), animated: false)
//        }
//    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {

        if titleTextField == textField {
            presenter?.didChangeTitle(text: textField.text!)
        }
    }
    
}

