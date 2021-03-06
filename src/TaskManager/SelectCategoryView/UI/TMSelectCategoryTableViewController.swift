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

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return presenter?.categoryCount ?? 0
    }

    // Reload Table View
    func reloadData() {
        tableView.reloadData()
    }

    // Back to Detail View
    func toPopView() {
        navigationController?.popViewController(animated: true)
    }

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectedCell(at: indexPath)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: "ColorCell", for: indexPath) as! TMColorTableViewCell

        cell.colorNameLabel.text = presenter?.categoryTitle(atIndex: indexPath)
        if let hex = presenter?.colorHex(atIndex: indexPath) {
            cell.colorView.backgroundColor = UIColor(hex: hex)
        }

        return cell
    }

    override func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 50
    }
}
