//
//  DatePickerViewController.swift
//  TaskManager
//
//  Created by Денис Ефимов on 07.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//

import UIKit

class DatePickerViewController: UIView {
    
    var presenter: TMTaskDetailPresenterProtocol?
    
    let picker = UIDatePicker()
    
    private let nameButtonDay = " Tomorrow "
    private let nameButtonWeek = " + Week "
    private let nameButtonMonth = " + Month "
    
    let today = Calendar.current.startOfDay(for: Date())
    
    let calendar = Calendar.current
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        picker.center = CGPoint(x: self.center.x, y: self.center.y - 5)
        picker.addTarget(self, action: #selector(setNewDate), for: .valueChanged)
        
        // Setup stack view
        
        let stackView = UIStackView(arrangedSubviews: createButtons(nameButtonDay, nameButtonWeek, nameButtonMonth))
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(picker)
        self.addSubview(stackView)
        
        picker.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: 15.0).isActive = true
        
        stackView.leadingAnchor.constraint(equalTo: picker.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: picker.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8.0).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 55.0).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func plusDayButtonTouchUpInside(_ sender: Any) {
        picker.setDate((calendar.date(byAdding: .day, value: 1, to: today))!, animated: true)
        setNewDate()
        
    }
    
    @objc func plusWeekButtonTouchUpInside(_ sender: Any) {
        picker.setDate((calendar.date(byAdding: .day, value: 7, to: today))!, animated: true)
        setNewDate()
    }
    
    @objc func plusMonthButtonTouchUpInside(_ sender: Any) {
        picker.setDate((calendar.date(byAdding: .month, value: 1, to: today))!, animated: true)
        setNewDate()
    }
    
    // Create help buttons + Week, + Month & Tomorrow
    private func createButtons(_ named: String...) -> [UIButton] {
        return named.map({ name in
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle(name, for: .normal)
            button.backgroundColor = UIColor.clear
            button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
            button.borderWidth = 1.0
            button.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            button.cornerRadius = 5
            button.clipsToBounds = true
            
            switch name {
            case nameButtonDay:
                button.addTarget(self, action: #selector(plusDayButtonTouchUpInside), for: .touchUpInside)
            case nameButtonWeek:
                button.addTarget(self, action: #selector(plusWeekButtonTouchUpInside), for: .touchUpInside)
            case nameButtonMonth:
                button.addTarget(self, action: #selector(plusMonthButtonTouchUpInside), for: .touchUpInside)
            default:
                return button
            }
            
            return button
            
        })
    }
    
    @objc private func setNewDate() {
        presenter?.didChangedDate(date: picker.date as NSDate)
    }
    
}

