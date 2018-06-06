//
//  TMHomeViewController.swift
//  TaskManager
//
//  Created by Денис Ефимов on 05.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//

import UIKit

class TMHomeViewController: UIViewController, TMHomeViewControllerProtocol {
    
    // MARK:- Propertyes
    
    var presenter: TMHomePresenterProtocol? = {
        var presenter = TMHomePresenter()
        presenter.wireframe = TMHomeWireframe()
        return presenter
    }()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addNewTaskButton: UIBarButtonItem!
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    
    static func storyboardInstance() -> TMHomeViewController? {
        let identifire = String(describing: self)
        let storyboard = UIStoryboard(name: identifire, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifire) as? TMHomeViewController
    }
    
    // MARK: Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getData()
    }
    
    // MARK: TMHomeViewControllerProtocol methods
    
    func reloadData() {
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "TaskDetailSegue":
            presenter?.setupTaskDetailViewController(view: sender as! TMTaskDetailViewControllerProtocol)
        case "SettingSegue":
            presenter?.setupSettingsDetailViewController(view: sender as! TMSettingsViewControllerProtocol)
        default:
            return
        }
    }
    
    
}

extension TMHomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRowAt(indexPath: indexPath)
    }
}

extension TMHomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.tasksCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TMTaskTableViewCell
        presenter?.configure(cell: cell as TMTaskTableViewCellProtocol, by: indexPath)
        return cell
    }
    
}
