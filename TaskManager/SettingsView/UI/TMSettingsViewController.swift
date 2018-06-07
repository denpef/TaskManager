//
//  TMSettingsViewController.swift
//  TaskManager
//
//  Created by Денис Ефимов on 07.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//

import UIKit

class TMSettingsViewController: UIViewController, TMSettingsViewControllerProtocol {

    var presenter: TMSettingsPresenterProtocol?
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var notificationSwitch: UISwitch!
    
    // MARK: - Actions
    @IBAction func addNewCategoryToucjUpInside(_ sender: Any) {
        performSegue(withIdentifier: TMSegue.addCategorySegue, sender: self)
    }
    
    @IBAction func notificationSwitchValueChanged(_ sender: UISwitch) {
        presenter?.didChangedNotificationSwitchValue(on: sender.isOn)
    }
    
    // MARK: - Override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getData()
        presenter?.setupView()
    }
    
    func setNotificationSwitch(on value: Bool) {
        notificationSwitch.setOn(value, animated: true)
    }

    // Update view
    func reloadData() {
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier {
        case TMSegue.addCategorySegue:
            presenter?.setupAddCategoryViewController(categoryView: segue.destination as! TMAddCategoryViewControllerProtocol)
        default:
            return
        }
        
    }
    
}

extension TMSettingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.categoryCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ColorCell", for: indexPath) as! TMColorTableViewCell
        
        cell.colorNameLabel.text = presenter?.cellTitleAt(indexPath: indexPath)
        if let hex = presenter?.cellHexAt(indexPath: indexPath) {
            cell.colorView.backgroundColor = UIColor(hex: hex)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension TMSettingsViewController: UITableViewDelegate {
    
}
