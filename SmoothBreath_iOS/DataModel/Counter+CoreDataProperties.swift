//
//  Counter+CoreDataProperties.swift
//  SmoothBreath_iOS
//
//  Created by Wenchu Du on 2019/9/17.
//  Copyright © 2019 Wenchu Du. All rights reserved.
//
//

import Foundation
import CoreData


extension Counter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Counter> {
        return NSFetchRequest<Counter>(entityName: "Counter")
    }

    @NSManaged public var remainingUsage: String?
    @NSManaged public var totalUsage: String?
    @NSManaged public var lastChangedDate: String?

}
