import UIKit

class TMMainViewController: UIViewController, TMMainViewControllerProtocol {
    // MARK: - Propertyes

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()

        refreshControl.addTarget(self, action: #selector(updateView), for: .valueChanged)

        refreshControl.tintColor = #colorLiteral(red: 0.768627451, green: 0.8588235294, blue: 0.1764705882, alpha: 0.6830586473)
        refreshControl.attributedTitle = NSAttributedString(string: "Updating...", attributes: [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.768627451, green: 0.8588235294, blue: 0.1764705882, alpha: 0.6830586473), NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13.0)])

        return refreshControl
    }()

    var presenter: TMMainPresenterProtocol?

    // MARK: - Outlets

    @IBOutlet var tableView: UITableView!

    @IBOutlet var addNewTaskButton: UIBarButtonItem!

    // MARK: - Actions

    // Gesture recognizer action - set flag Completed/Not
    @IBAction func tapOnView(_ sender: UITapGestureRecognizer) {
        if sender.state != .ended { return }

        let tapLocationInTableView = sender.location(in: tableView)

        // Method is replacement tableView -> didSelectRowAt
        // also we catch tap on view for complete task
        if let tapIndexPath = tableView.indexPathForRow(at: tapLocationInTableView) {
            guard let tappedCell = tableView.cellForRow(at: tapIndexPath) as? TMTaskTableViewCell else { return }
            let tapLocationInCell = sender.location(in: tappedCell)

            if tappedCell.completedFlagView.frame.contains(tapLocationInCell) {
                // change flag isCompleted
                presenter?.invertedCompleteFlag(at: tapIndexPath)

            } else {
                // change flag isCompleted for task by tapIndexPath
                presenter?.didSelectRowAt(indexPath: tapIndexPath)
            }
        }
    }

    @IBAction func addNewTaskBarButtonItemTap(_: Any) {
        presenter?.didAddNewTask()
    }

    // MARK: Override methods

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = TMMainPresenter()
        presenter?.wireframe = TMMainWireframe()

        // Setup Refresh control
        tableView.refreshControl = refreshControl
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.view = self
        presenter?.getData()
    }

    // Method for refreshControl
    @objc
    func updateView() {
        presenter?.getData()
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }

    // MARK: TMHomeViewControllerProtocol methods

    func reloadData() {
        tableView.reloadData()
    }

    // Segue to Detail View
    func presentTaskDetailView() {
        performSegue(withIdentifier: TMSegue.taskDetailSegue, sender: self)
    }

    // Segue to Settings View
    func presentSettingsView() {
        performSegue(withIdentifier: TMSegue.settingSegue, sender: self)
    }

    // MARK: Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        switch segue.identifier {
        case TMSegue.taskDetailSegue:
            // Through presenter to wireframe
            // present for segue to Detail View
            // swiftlint:disable force_cast
            presenter?.setupTaskDetailViewController(detailView: segue.destination as! TMTaskDetailViewControllerProtocol)
        case TMSegue.settingSegue:
            // Through presenter to wireframe
            // present for segue to Settings View
            // swiftlint:disable force_cast
            presenter?.setupSettingsDetailViewController(settingsView: segue.destination as! TMSettingsViewControllerProtocol)
        default:
            return
        }
    }
}

extension TMMainViewController: UITableViewDelegate {
    @available(iOS 11.0, *)
    func tableView(_: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: UIContextualAction.Style.destructive, title: "Delete", handler: { _, _, completion in
            self.presenter?.didSDeleteRowAt(indexPath: indexPath)
            completion(true)
        })

        let config = UISwipeActionsConfiguration(actions: [deleteAction])

        return config
    }

    @available(iOS 10.0, *)
    func tableView(_: UITableView, canEditRowAt _: IndexPath) -> Bool {
        return true
    }

    @available(iOS 10.0, *)
    func tableView(_: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            presenter?.didSDeleteRowAt(indexPath: indexPath)
        }
    }
}

extension TMMainViewController: UITableViewDataSource {
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return presenter?.tasksCount ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TMTaskTableViewCell
        presenter?.configure(cell: cell as TMTaskTableViewCellProtocol, by: indexPath)
        return cell
    }
}
