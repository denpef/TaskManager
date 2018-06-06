//
//  ColorCategory+CoreDataProperties.swift
//  TaskManager
//
//  Created by Денис Ефимов on 06.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//
//

import Foundation
import CoreData


extension ColorCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ColorCategory> {
        return NSFetchRequest<ColorCategory>(entityName: "ColorCategory")
    }

    @NSManaged public var color: String?
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var tasks: NSSet?

}

// MARK: Generated accessors for tasks
extension ColorCategory {

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: Task)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: Task)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}
