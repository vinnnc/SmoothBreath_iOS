//
//  Record.swift
//  SmoothBreath_iOS
//
//  Created by Wenchu Du on 2019/9/8.
//  Copyright © 2019 Wenchu Du. All rights reserved.
//

import UIKit

class Record: NSObject {
    var dateAndTime: Date?
    var attackLevel: String?
    var stress: String?
    var exercise: String?
    var nearby: String?
    
    init(dateAndTime: Date, attackLevel: String?, stress: String?, exercise: String?, nearby: String?) {
        self.dateAndTime = dateAndTime
        self.attackLevel = attackLevel
        self.stress = stress
        self.exercise = exercise
        self.nearby = nearby
    }
}
