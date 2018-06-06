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
        navigationController?.popViewController(animated: true)
        //dismiss(animated: true)
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.setupView()
    }
    
    

}

extension TMTaskDetailViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        if let dateInputView = textField.inputView as? DatePickerViewController {
//            if dateInputView.modeOfPicker == .date {
//                if point!.dateIsEmpty() {
//                    point?.setDate(date: Calendar.current.startOfDay(for: Date()) as NSDate)
//                }
//                dateInputView.picker.setDate(Calendar.current.startOfDay(for: point!.date! as Date), animated: false)
//            } else if dateInputView.modeOfPicker == .reminderDate{
//                if point!.reminderDateIsEmpty() {
//                    point?.setReminderDate(date: point!.morningDateBy(dateValue: Date()))
//                }
//                dateInputView.picker.setDate(point!.reminderDate! as Date, animated: false)
//            }
//        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if titleTextField == textField {
            presenter?.didChangeTitle(text: textField.text!)
        }
    }
    
}
