import CoreData
import Foundation

extension Task {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var completionDate: NSDate?
    @NSManaged public var id: String?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var title: String?
    @NSManaged public var colorCategory: ColorCategory?

    public convenience init() {
        self.init(context: TMPersistentService.context)
        id = UUID().uuidString
    }
}
