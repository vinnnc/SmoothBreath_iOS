//
//  Record+CoreDataProperties.swift
//  SmoothBreath_iOS
//
//  Created by Wenchu Du on 2019/10/7.
//  Copyright © 2019 Wenchu Du. All rights reserved.
//
//

import Foundation
import CoreData


extension Record {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Record> {
        return NSFetchRequest<Record>(entityName: "Record")
    }

    @NSManaged public var attackDate: Date?
    @NSManaged public var attackLevel: Int32
    @NSManaged public var exercise: Int32
    @NSManaged public var latitude: Float
    @NSManaged public var longitude: Float
    @NSManaged public var nearby: String?
    @NSManaged public var stress: Int32
    @NSManaged public var period: Bool

}
