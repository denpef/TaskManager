import CoreData
import Foundation

class TMPersistentService {
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TaskManager")
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    private init() {}

    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    static func getTasksWithADateGreaterThanTheCurrent() -> [Task] {
        do {
            let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "completionDate >= %@", NSDate())
            let fetchedResults = try TMPersistentService.context.fetch(fetchRequest)

            if let _ = fetchedResults.first {
                return fetchedResults
            }
        } catch {}

        return []
    }

    // MARK: - Core Data Saving support

    static func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
