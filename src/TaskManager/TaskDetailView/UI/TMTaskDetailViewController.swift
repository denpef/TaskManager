import UIKit

class TMTaskDetailViewController: UITableViewController, TMTaskDetailViewControllerProtocol {
    // MARK: - Properties

    var presenter: TMTaskDetailPresenterProtocol?

    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var categoryImageView: UIView!
    @IBOutlet var dateTextField: UITextField!

    @IBOutlet var deleteBarBurronItem: UIBarButtonItem!
    @IBOutlet var doneBarBurronItem: UIBarButtonItem!

    // MARK: - Actions

    @IBAction func doneBarButtonTouchUpInside(_: Any) {
        view.endEditing(true)
        presenter?.doneButtonTapped()
        navigationController?.popViewController(animated: true)
    }

    @IBAction func deleteBarButtonItemTap(_: Any) {
        // Alert controller
        let alertController = UIAlertController(title: titleTextField.text, message: "will be irretrievably deleted", preferredStyle: .actionSheet)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
        }
        alertController.addAction(cancelAction)

        let destroyAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            self.presenter?.didDeletedTask {
                self.navigationController?.popViewController(animated: true)
            }
        }
        alertController.addAction(destroyAction)

        present(alertController, animated: true, completion: nil)
    }

    // MARK: - TableViewDataSource & delegate

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0, indexPath.section == 1 {
            performSegue(withIdentifier: TMSegue.selectCategorySegue, sender: self)
        }
    }

    // MARK: - Protocol

    func setTitle(text: String) {
        titleTextField.text = text
    }

    func setCategoryTitle(text: String) {
        categoryLabel.text = text
        categoryLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }

    func setCategoryColor(hex: String) {
        categoryImageView.backgroundColor = UIColor(hex: hex)
    }

    func setDateLabet(text: String) {
        dateTextField.text = text
    }

    func setEmptyCategoryPlaceholder() {
        categoryLabel.text = "Tap to select a category..."
        categoryLabel.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup Text fields
        titleTextField.autocapitalizationType = .sentences

        setupDatePicker()

        presenter?.setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.updateView()
    }

    // MARK: Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if segue.identifier == TMSegue.selectCategorySegue {
            // swiftlint:disable force_cast
            presenter?.setupSelectSegueViewController(selectCategoryView: segue.destination as! TMSelectCategoryTableViewControllerProtocol)
        }
    }

    // MARK: Date toolbar

    private func createToolbar(title: String, actionDone: Selector, actionDelete: Selector) -> UIToolbar {
        let delete = UIBarButtonItem(title: "Clear", style: .done, target: self, action: actionDelete)
        delete.tintColor = #colorLiteral(red: 0.9196171467, green: 0.2142267733, blue: 0.2214575526, alpha: 0.9)

        let spaceLeft = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textAlignment = .center

        let titleItem = UIBarButtonItem(customView: titleLabel)

        let spaceRight = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: actionDone)

        let toolbar = UIToolbar()

        toolbar.setItems([delete, spaceLeft, titleItem, spaceRight, done], animated: false)
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        toolbar.isUserInteractionEnabled = true

        return toolbar
    }

    func setupDatePicker() {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 260)

        let toolbar = createToolbar(title: "Completion date", actionDone: #selector(doneDateClick), actionDelete: #selector(cleareDateClick))

        dateTextField.inputAccessoryView = toolbar
        let datePickerView = DatePickerViewController(frame: frame)
        datePickerView.picker.datePickerMode = .dateAndTime
        datePickerView.presenter = presenter
        if let currentDate = presenter?.getCompletionDate() {
            datePickerView.picker.setDate(currentDate as Date, animated: false)
        }
        dateTextField.inputView = datePickerView
    }

    @objc private func doneDateClick() {
        view.endEditing(true)
    }

    @objc private func cleareDateClick() {
        presenter?.didChangedDate(date: nil)
        view.endEditing(true)
    }
}

extension TMTaskDetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if titleTextField == textField {
            presenter?.didChangeTitle(text: textField.text!)
        }
    }
}
