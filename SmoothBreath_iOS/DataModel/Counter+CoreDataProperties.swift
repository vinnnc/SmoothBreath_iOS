//
//  Counter+CoreDataProperties.swift
//  SmoothBreath_iOS
//
//  Created by Wenchu Du on 2019/10/1.
//  Copyright © 2019 Wenchu Du. All rights reserved.
//
//

import Foundation
import CoreData


extension Counter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Counter> {
        return NSFetchRequest<Counter>(entityName: "Counter")
    }

    @NSManaged public var lastChangedDate: Date?
    @NSManaged public var remainingUsage: Int32
    @NSManaged public var totalUsage: Int32

}
