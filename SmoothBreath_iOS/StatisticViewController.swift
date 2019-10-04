//
//  ReportViewController.swift
//  SmoothBreath_iOS
//
//  Created by Wenchu Du on 2019/9/14.
//  Copyright © 2019 Wenchu Du. All rights reserved.
//

import UIKit
import Charts

class StatisticViewController: UIViewController {

    @IBOutlet weak var monthDistributionLineChartView: LineChartView!
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
    
    var allRecords: [Record] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadData()
        generateTriggerRanking()
        generateMonthDistributionChart()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
        generateTriggerRanking()
        generateMonthDistributionChart()
    }
    
    func generateTriggerRanking() {
        var report: [String: Int] = [:]
        let labels = [firstNameLabel, firstNumberLabel, secondNameLabel, secondNumberLabel, thirdNameLabel, thirdNumberLabel, fourthNameLabel, fourthNumberLabel, fifthNameLabel, fifthNumberLabel, sixthNameLabel, sixthNumberLabel, seventhNameLabel, seventhNumberLabel]
        
        if allRecords.count == 0 {
            report["There is no record in the database."] = 0
        } else {
            for record in allRecords {
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
                
                if record.nearby != "There is no other trigger nearby." {
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
    
    func loadData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            try allRecords = context.fetch(Record.fetchRequest()) as! [Record]
        } catch {
            print("Failed to fetch record data.")
        }
        
        allRecords.sort(by: { $0.attackDate!.compare($1.attackDate! as Date) == ComparisonResult.orderedAscending })
    }
    
    func generateMonthDistributionChart() {
        
        var values = [0.0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        
        for record in allRecords {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.month], from: record.attackDate!)
            let month = components.month
            values[month! - 1] += 1
        }
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0...values.count - 1{
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: "Asthma Attack Amount")
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChartDataSet.drawCirclesEnabled = false
        lineChartDataSet.lineWidth = 3.0
        lineChartDataSet.setColor(UIColor.orange)
        lineChartDataSet.mode = .cubicBezier
        
        let numberFormatter = NumberFormatter()
        numberFormatter.generatesDecimalNumbers = false
        lineChartDataSet.valueFormatter = DefaultValueFormatter(formatter: numberFormatter)
        lineChartDataSet.valueFont = .systemFont(ofSize: 12)
        
        monthDistributionLineChartView.data = lineChartData
        monthDistributionLineChartView.doubleTapToZoomEnabled = false
        monthDistributionLineChartView.rightAxis.drawGridLinesEnabled = false
        monthDistributionLineChartView.rightAxis.drawLabelsEnabled = false
        monthDistributionLineChartView.rightAxis.drawAxisLineEnabled = false
        monthDistributionLineChartView.leftAxis.drawGridLinesEnabled = false
        monthDistributionLineChartView.leftAxis.drawLabelsEnabled = false
        monthDistributionLineChartView.leftAxis.drawAxisLineEnabled = false
        monthDistributionLineChartView.xAxis.drawGridLinesEnabled = false
        monthDistributionLineChartView.xAxis.labelPosition = .bottom
        let xValues = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        monthDistributionLineChartView.xAxis.setLabelCount(12, force: true)
        monthDistributionLineChartView.xAxis.labelFont = .systemFont(ofSize: 12)
        monthDistributionLineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xValues)
        monthDistributionLineChartView.backgroundColor = UIColor(ciColor: .white)
    }
}
