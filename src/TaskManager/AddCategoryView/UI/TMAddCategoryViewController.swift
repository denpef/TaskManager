import UIKit

class TMAddCategoryViewController: UIViewController, TMAddCategoryViewControllerProtocol {
    var presenter: TMAddCategoryPresenterProtocol?

    @IBOutlet var tableView: UITableView!
    @IBOutlet var titleTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        titleTextField.autocapitalizationType = .sentences
    }

    @IBAction func cancellButtonTap(_: Any) {
        backToSettings()
    }

    @IBAction func saveButtonTap(_: Any) {
        presenter?.didSaved(text: titleTextField.text)
    }

    // MARK: - TMAddCategoryViewControllerProtocol

    func reloadData() {
        tableView.reloadData()
    }

    // Alert question
    func noColorSelectedWarning() {
        // Alert controller
        let alertController = UIAlertController(title: "Please choose a color", message: "", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }

    func backToSettings() {
        navigationController?.popViewController(animated: true)
    }
}

extension TMAddCategoryViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return presenter?.colorsCount ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: "ColorCell", for: indexPath) as! TMColorTableViewCell

        // Configure table view cell

        cell.colorNameLabel.text = presenter?.colorName(atIndex: indexPath)
        if let hex = presenter?.colorHex(atIndex: indexPath) {
            cell.colorView.backgroundColor = UIColor(hex: hex)
        }

        if presenter?.isSelectedCell(at: indexPath) ?? false {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        return cell
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 50
    }
}

extension TMAddCategoryViewController: UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selectColor(at: indexPath)
    }
}

extension TMAddCategoryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
}
