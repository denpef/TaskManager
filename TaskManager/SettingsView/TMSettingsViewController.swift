//
//  TMSettingsViewController.swift
//  TaskManager
//
//  Created by Денис Ефимов on 07.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//

import UIKit

class TMSettingsViewController: UIViewController, TMSettingsViewControllerProtocol {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: TMSettingsPresenterProtocol?
    
    @IBOutlet weak var notificationSwitch: UISwitch!
    
    @IBAction func notificationSwitchValueChanged(_ sender: UISwitch) {
        presenter?.didChangedNotificationSwitchValue(on: sender.isOn)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.setupView()
    }
    
    func setNotificationSwitch(on value: Bool) {
        notificationSwitch.setOn(value, animated: true)
    }


    func reloadData() {
        
    }
    
}

extension TMSettingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.categoryCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = presenter?.cellTitleAt(indexPath: indexPath)
        if let colorHex = presenter?.cellHexAt(indexPath: indexPath) {
            cell.backgroundColor = UIColor(hex: colorHex)
        }
        
        return cell
    }
    
    
}

extension TMSettingsViewController: UITableViewDelegate {
    
}
