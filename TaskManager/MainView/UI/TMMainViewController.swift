//
//  TMHomeViewController.swift
//  TaskManager
//
//  Created by Денис Ефимов on 05.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//

import UIKit

class TMMainViewController: UIViewController, TMMainViewControllerProtocol {
    
    // MARK:- Propertyes
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(updateView), for: .valueChanged)
        
        refreshControl.tintColor = #colorLiteral(red: 0.768627451, green: 0.8588235294, blue: 0.1764705882, alpha: 0.6830586473)
        refreshControl.attributedTitle = NSAttributedString(string: "Updating...", attributes: [NSAttributedStringKey.foregroundColor : #colorLiteral(red: 0.768627451, green: 0.8588235294, blue: 0.1764705882, alpha: 0.6830586473), NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13.0)])
        
        return refreshControl
    }()
    
    var presenter: TMMainPresenterProtocol? = {
        var presenter = TMMainPresenter()
        presenter.wireframe = TMMainWireframe()
        return presenter
    }()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addNewTaskButton: UIBarButtonItem!
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    
    @IBAction func tapOnView(_ sender: UITapGestureRecognizer) {
        
        if sender.state != .ended { return }
        
        let tapLocationInTableView = sender.location(in: tableView)
        
        if let tapIndexPath = tableView.indexPathForRow(at: tapLocationInTableView) {
            
            guard let tappedCell = tableView.cellForRow(at: tapIndexPath) as? TMTaskTableViewCell else { return }
            let tapLocationInCell = sender.location(in: tappedCell)
            
            if tappedCell.completedFlagView.frame.contains(tapLocationInCell) {
                presenter?.invertedCompleteFlag(at: tapIndexPath)
            } else {
                presenter?.didSelectRowAt(indexPath: tapIndexPath)
            }
        }
        
    }
    
    @IBAction func settingsBarButtonItemTap(_ sender: Any) {
    }
    
    @IBAction func addNewTaskBarButtonItemTap(_ sender: Any) {
        presenter?.didAddNewTask()
    }
    
    // MARK: Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Refresh control
        if #available(iOS 10, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.view = self
        presenter?.getData()
    }
    
    @objc
    func updateView() {
        presenter?.getData()
        if self.refreshControl.isRefreshing {
            self.refreshControl.endRefreshing()
        }
    }
    
    // MARK: TMHomeViewControllerProtocol methods
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func presentTaskDetailView() {
        performSegue(withIdentifier: TMSegue.taskDetailSegue, sender: self)
    }
    
    func presentSettingsView() {
        performSegue(withIdentifier: TMSegue.settingSegue, sender: self)
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier {
        case TMSegue.taskDetailSegue:
            presenter?.setupTaskDetailViewController(detailView: segue.destination as! TMTaskDetailViewControllerProtocol)
        case TMSegue.settingSegue:
            presenter?.setupSettingsDetailViewController(settingsView: segue.destination as! TMSettingsViewControllerProtocol)
        default:
            return
        }
    }
    
    
}

extension TMMainViewController: UITableViewDelegate {
    
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction.init(style: UIContextualAction.Style.destructive, title: "Delete", handler: { (action, view, completion) in
            self.presenter?.didSDeleteRowAt(indexPath: indexPath)
            completion(true)
        })
        
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return config
    }
    
    @available(iOS 10.0, *)
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    @available(iOS 10.0, *)
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            self.presenter?.didSDeleteRowAt(indexPath: indexPath)
        }
    }
    
}

extension TMMainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.tasksCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TMTaskTableViewCell
        presenter?.configure(cell: cell as TMTaskTableViewCellProtocol, by: indexPath)
        return cell
    }
    
}
