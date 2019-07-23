import UIKit

class TMSettingsViewController: UIViewController, TMSettingsViewControllerProtocol {
    var presenter: TMSettingsPresenterProtocol?

    // MARK: - Outlets

    @IBOutlet var tableView: UITableView!
    @IBOutlet var notificationSwitch: UISwitch!

    // MARK: - Actions

    @IBAction func addNewCategoryToucjUpInside(_: Any) {
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
            // swiftlint:disable force_cast
            presenter?.setupAddCategoryViewController(categoryView: segue.destination as! TMAddCategoryViewControllerProtocol)
        default:
            return
        }
    }
}

extension TMSettingsViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
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

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 50
    }
}

extension TMSettingsViewController: UITableViewDelegate {}
