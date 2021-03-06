import Foundation

class TMMainPresenter {
    // MARK: - Properties

    weak var view: TMMainViewControllerProtocol?
    var wireframe: TMMainWireframeProtocol?

    var tasks: [Task] = []
    var tasksCount: Int {
        return tasks.count
    }

    var currentTask: Task?
    lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()

        formatter.calendar = Calendar.current
        formatter.locale = Calendar.current.locale
        formatter.dateFormat = "d MMM, HH:mm"

        return formatter
    }()

    init() {
        wireframe = TMMainWireframe()
    }

    private func task(atIndex indexPath: IndexPath) -> Task? {
        if tasks.indices.contains(indexPath.row) {
            return tasks[indexPath.row]
        } else {
            return nil
        }
    }
}

extension TMMainPresenter: TMMainPresenterProtocol {
    // Fill cell from presenter data
    func configure(cell: TMTaskTableViewCellProtocol, by indexPath: IndexPath) {
        if let task = task(atIndex: indexPath) {
            cell.setTitle(title: task.title ?? "")

            if let date = task.completionDate {
                cell.setDateLabelText(text: formatter.string(from: date as Date))
            } else {
                cell.setDateLabelText(text: "No date")
            }

            if let colorAsHex = task.colorCategory?.colorAsHex {
                cell.setCategoryColor(by: colorAsHex == "" ? nil : colorAsHex)
            } else {
                cell.setCategoryColor(by: nil)
            }

            cell.setCompleteStyle(isCompleted: task.isCompleted)
        }
    }

    // Reload tasks from storage & gives a signal
    // to view for update elements
    func getData() {
        do {
            tasks = try TMPersistentService.context.fetch(Task.fetchRequest())
        } catch {
            tasks = []
        }
        view?.reloadData()
    }

    // Segue to detail of selected cell
    func didSelectRowAt(indexPath: IndexPath) {
        currentTask = task(atIndex: indexPath)
        view?.presentTaskDetailView()
    }

    // Segue to detail of selected cell
    func didAddNewTask() {
        view?.presentTaskDetailView()
    }

    // Prepeare for segue to Settings View
    func setupTaskDetailViewController(detailView: TMTaskDetailViewControllerProtocol) {
        wireframe?.presentDetailView(with: currentTask, view: detailView)
        if let _ = currentTask {
            currentTask = nil
        }
    }

    // Prepeare for segue to Detail View
    func setupSettingsDetailViewController(settingsView: TMSettingsViewControllerProtocol) {
        wireframe?.presentSettingsView(view: settingsView)
    }

    // Presenter must remove element from the data
    func didSDeleteRowAt(indexPath: IndexPath) {
        if let task = task(atIndex: indexPath) {
            TMPersistentService.context.delete(task)
            TMPersistentService.saveContext()
        }
        getData()
    }

    // Sets the flag to the opposite value
    func invertedCompleteFlag(at indexPath: IndexPath) {
        if let task = task(atIndex: indexPath) {
            task.isCompleted = !task.isCompleted
            TMPersistentService.saveContext()

            // Notifications
            if task.isCompleted {
                UserNotificationsManager.shared.removeNotification(identifire: [task.id!])
            } else {
                if let date = task.completionDate {
                    if let userNotificationsIsOn = UserDefaults.standard.object(forKey: "userNotificationsIsOn") as? Bool {
                        if userNotificationsIsOn {
                            UserNotificationsManager.shared.scheduleNotification(identifier: task.id!, title: task.title ?? "", subtitle: "", body: "", date: date as Date)
                        }
                    }
                }
            }
        }
        getData()
    }
}
