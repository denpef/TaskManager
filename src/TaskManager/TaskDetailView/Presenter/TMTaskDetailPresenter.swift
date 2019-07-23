import Foundation

class TMTaskDetailPresenter: TMTaskDetailPresenterProtocol {
    lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()

        formatter.calendar = Calendar.current
        formatter.locale = Calendar.current.locale
        formatter.dateFormat = "d MMM yyyy HH:mm"

        return formatter
    }()

    // Connected view & wireframe with presenter
    var wireframe: TMTaskDetailWireframeProtocol?
    weak var view: TMTaskDetailViewControllerProtocol?

    var task: Task?

    var title: String?
    var completionDate: NSDate?
    weak var colorCategory: ColorCategory?

    // Gives the view command the update data
    private func setViewDate(date: NSDate?) {
        if let date = date {
            view?.setDateLabet(text: formatter.string(from: date as Date))
        } else {
            view?.setDateLabet(text: "")
        }
    }

    // Saving context
    func doneButtonTapped() -> Task? {
        if let newTitle = title {
            if newTitle != "" {
                createNewTaskIfNeeded()
                task?.title = newTitle
            }
        }

        task?.completionDate = completionDate
        task?.colorCategory = colorCategory

        TMPersistentService.saveContext()

        // If the task has a deadline in the future
        // then it is necessary to put it on hold
        if let date = task?.completionDate {
            if let userNotificationsIsOn = UserDefaults.standard.object(forKey: "userNotificationsIsOn") as? Bool {
                if userNotificationsIsOn {
                    if let task = task {
                        UserNotificationsManager.shared.scheduleNotification(identifier: task.id!, title: task.title ?? "", subtitle: "", body: "", date: date as Date)
                    }
                }
            } else if let task = task {
                // If the task has a empty date -
                // cleare notification
                UserNotificationsManager.shared.removePendingNotificationswith(identifiers: [task.id!])
            }
        }

        return task
    }

    // Work with view actions, when need change data
    func didChangedCategory(newValue: ColorCategory) {
        colorCategory = newValue
        updateView()
    }

    func didChangedDate(date: NSDate?) {
        completionDate = date

        setViewDate(date: completionDate)
    }

    // Reload tasks from storage & gives a signal
    // to view for update elements
    func setupView() {
        // Cash task data
        title = task?.title
        completionDate = task?.completionDate
        colorCategory = task?.colorCategory
    }

    // For update from date
    func updateView() {
        // set view fields value
        view?.setTitle(text: title ?? "")
        if let category = colorCategory {
            view?.setCategoryTitle(text: category.title ?? "")
            view?.setCategoryColor(hex: category.colorAsHex ?? "")
        } else {
            view?.setEmptyCategoryPlaceholder()
        }
        setViewDate(date: completionDate)
    }

    func didChangeTitle(text: String) {
        if text == "" { return }
        title = text
        view?.setTitle(text: text)
    }

    private func createNewTaskIfNeeded() {
        if task != nil { return }
        task = Task()
    }

    func didDeletedTask(completionHandler: () -> Void) {
        if let task = task {
            TMPersistentService.context.delete(task)
            TMPersistentService.saveContext()
        }
        completionHandler()
    }

    func setupSelectSegueViewController(selectCategoryView: TMSelectCategoryTableViewControllerProtocol) {
        wireframe?.presentSelectSegueViewController(view: selectCategoryView)
    }

    func getCompletionDate() -> NSDate? {
        return task?.completionDate
    }
}
