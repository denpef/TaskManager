//
//  TMSelectCategoryTableViewController.swift
//  TaskManager
//
//  Created by Денис Ефимов on 07.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//

import UIKit

class TMSelectCategoryTableViewController: UITableViewController, TMSelectCategoryTableViewControllerProtocol {

    var presenter: TMSelectCategoryPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return presenter?.categoryCount ?? 0
    }

    func reloadData() {
        tableView.reloadData()
    }
    
    func toPopView() {
        navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectedCell(at: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ColorCell", for: indexPath) as! TMColorTableViewCell
        
        cell.colorNameLabel.text = presenter?.categoryTitle(atIndex: indexPath)
        if let hex = presenter?.colorHex(atIndex: indexPath) {
            cell.colorView.backgroundColor = UIColor(hex: hex)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

}
