//
//  Record+CoreDataProperties.swift
//  SmoothBreath_iOS
//
//  Created by Wenchu Du on 2019/9/17.
//  Copyright © 2019 Wenchu Du. All rights reserved.
//
//

import Foundation
import CoreData


extension Record {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Record> {
        return NSFetchRequest<Record>(entityName: "Record")
    }

    @NSManaged public var attackDate: String?
    @NSManaged public var attackLevel: String?
    @NSManaged public var exercise: String?
    @NSManaged public var nearby: String?
    @NSManaged public var stress: String?

}
