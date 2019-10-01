//
//  ReportViewController.swift
//  SmoothBreath_iOS
//
//  Created by Wenchu Du on 2019/9/14.
//  Copyright © 2019 Wenchu Du. All rights reserved.
//

import UIKit

class StatisticViewController: UIViewController {

    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var firstNumberLabel: UILabel!
    @IBOutlet weak var secondNameLabel: UILabel!
    @IBOutlet weak var secondNumberLabel: UILabel!
    @IBOutlet weak var thirdNameLabel: UILabel!
    @IBOutlet weak var thirdNumberLabel: UILabel!
    @IBOutlet weak var fourthNameLabel: UILabel!
    @IBOutlet weak var fourthNumberLabel: UILabel!
    @IBOutlet weak var fifthNameLabel: UILabel!
    @IBOutlet weak var fifthNumberLabel: UILabel!
    @IBOutlet weak var sixthNameLabel: UILabel!
    @IBOutlet weak var sixthNumberLabel: UILabel!
    @IBOutlet weak var seventhNameLabel: UILabel!
    @IBOutlet weak var seventhNumberLabel: UILabel!
    
    var allRecords: [Record]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        generateTriggerRanking()
    }
    
    func generateTriggerRanking() {
        var report: [String: Int] = [:]
        let labels = [firstNameLabel, firstNumberLabel, secondNameLabel, secondNumberLabel, thirdNameLabel, thirdNumberLabel, fourthNameLabel, fourthNumberLabel, fifthNameLabel, fifthNumberLabel, sixthNameLabel, sixthNumberLabel, seventhNameLabel, seventhNumberLabel]
        
        if allRecords?.count == 0 {
            report["There is no record in database."] = 0
        } else {
            for record in allRecords! {
                if record.stress > 50 {
                    if report["Stress"] != nil {
                        report.updateValue(report["Stress"]! + 1, forKey: "Stress")
                    } else {
                        report["Stress"] = 1
                    }
                }
                
                if record.exercise > 50 {
                    if report["Exercise"] != nil {
                        report.updateValue(report["Exercise"]! + 1, forKey: "Exercise")
                    } else {
                        report["Exercise"] = 1
                    }
                }
                
                if record.nearby != "None" {
                    guard let nearbys = record.nearby?.components(separatedBy: ", ") else { return  }
                    for nearby in nearbys {
                        if report[nearby] != nil {
                            report.updateValue(report[nearby]! + 1, forKey: nearby)
                        } else {
                            report[nearby] = 1
                        }
                    }
                }
            }
        }
        
        let sortedReport = report.sorted(by: { $0.value > $1.value })
        var labelIndex = 0
        for trigger in sortedReport {
            labels[labelIndex]?.text = trigger.key
            if trigger.value == 0 {
                labels[labelIndex + 1]?.text = ""
            } else {
                labels[labelIndex + 1]?.text = String(trigger.value)
            }
            labelIndex += 2
        }
        
        if labelIndex < labels.count {
            for index in labelIndex...labels.count - 1 {
                labels[index]?.text = ""
            }
        }
    }
}
