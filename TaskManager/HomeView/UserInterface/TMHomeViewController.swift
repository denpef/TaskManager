//
//  TMHomeViewController.swift
//  TaskManager
//
//  Created by Денис Ефимов on 05.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//

import UIKit

class TMHomeViewController: UIViewController, TMHomeViewControllerProtocol {
    
    var presenter: TMHomePresenterProtocol?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addNewTaskButton: UIBarButtonItem!
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    
    static func storyboardInstance() -> TMHomeViewController? {
        let identifire = String(describing: self)
        let storyboard = UIStoryboard(name: identifire, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifire) as? TMHomeViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getData()
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}

extension TMHomeViewController: UITableViewDelegate {
    
}

extension TMHomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.tasksCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TMTaskTableViewCell
        let task = presenter?.task(atIndex: indexPath)
        
        cell.colorCategoryImage.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        cell.taskNameLabel.text = task?.name ?? ""
        
        return cell
    }
    
}