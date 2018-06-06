//
//  Task+CoreDataProperties.swift
//  TaskManager
//
//  Created by Денис Ефимов on 06.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var completionDate: NSDate?
    @NSManaged public var id: String?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var name: String?
    @NSManaged public var colorCategory: ColorCategory?

}
