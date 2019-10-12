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
    @IBOutlet weak var triggerRankingBarChartView: HorizontalBarChartView!

    var allRecords: [Record] = []
    var filteredRecords: [Record] = []
    var fromDate: Date?
    var toDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initialisation()
    }
    
    func initialisation() {
        loadData()

        if (fromDate != nil) && (toDate != nil) {
            filteredData()
        } else {
            filteredRecords = allRecords
        }

        generateMonthDistributionChart()
        generateTriggerRankingBarChart()
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
        
        allRecords.sort(by: { $0.attackDate!.compare($1.attackDate! as Date) == ComparisonResult.orderedDescending })
    }
    
    func filteredData() {
        filteredRecords = []
        for record in allRecords {
            let attackDate = record.attackDate!
            if fromDate!.compare(attackDate).rawValue * attackDate.compare(toDate!).rawValue >= 0 {
                filteredRecords.append(record)
            }
        }
    }
    
    func generateMonthDistributionChart() {
        
        var values = [0.0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        
        for record in filteredRecords {
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
        lineChartDataSet.mode = .horizontalBezier
        
        let numberFormatter = NumberFormatter()
        numberFormatter.generatesDecimalNumbers = false
        lineChartDataSet.valueFormatter = DefaultValueFormatter(formatter: numberFormatter)
        lineChartDataSet.valueFont = .systemFont(ofSize: 13)
        
        monthDistributionLineChartView.data = lineChartData
        monthDistributionLineChartView.doubleTapToZoomEnabled = false
        monthDistributionLineChartView.rightAxis.enabled = false
        monthDistributionLineChartView.leftAxis.enabled = false
        
        let xAxis = monthDistributionLineChartView.xAxis
        xAxis.labelPosition = .bottom
        let xValues = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        xAxis.setLabelCount(12, force: true)
        xAxis.labelFont = .systemFont(ofSize: 13)
        xAxis.valueFormatter = IndexAxisValueFormatter(values: xValues)
        xAxis.drawGridLinesEnabled = false
        xAxis.drawAxisLineEnabled = false
        
        monthDistributionLineChartView.backgroundColor = UIColor(ciColor: .white)
    }
    
    func generateTriggerRankingBarChart() {
        var report = ["Exercise": 0.0, "Fire": 0, "Pollen Source": 0, "Stress": 0, "Animal": 0, "Heavy Wind": 0, "Dust": 0, "Hormone": 0] as Dictionary
        
        for record in filteredRecords {
            if record.stress >= 2 {
                report.updateValue(report["Stress"]! + 1, forKey: "Stress")
            }
            
            if record.exercise >= 2 {
                report.updateValue(report["Exercise"]! + 1, forKey: "Exercise")
            }
            
            if record.nearby != "There is no other trigger nearby." {
                guard let nearbys = record.nearby?.components(separatedBy: ", ") else { return  }
                for nearby in nearbys {
                    report.updateValue(report[nearby]! + 1, forKey: nearby)
                }
            }
            
            if record.period {
                report.updateValue(report["Hormone"]! + 1, forKey: "Hormone")
            }
        }
        
        let sortedReport = report.sorted(by: { $0.value < $1.value })
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0...sortedReport.count - 1{
            let dataEntry = BarChartDataEntry(x: Double(i), yValues: [sortedReport[i].value])
            dataEntries.append(dataEntry)
        }
        
        let barChartDataSet = BarChartDataSet(entries: dataEntries, label: "Tigger occur times")
        let barChartData = BarChartData(dataSet: barChartDataSet)
        barChartDataSet.setColor(UIColor.orange)
        
        triggerRankingBarChartView.data = barChartData
        triggerRankingBarChartView.drawValueAboveBarEnabled = true
        triggerRankingBarChartView.backgroundColor = UIColor(ciColor: .white)
        triggerRankingBarChartView.doubleTapToZoomEnabled = false
        triggerRankingBarChartView.rightAxis.enabled = false
        triggerRankingBarChartView.leftAxis.enabled = false
        
        let numberFormatter = NumberFormatter()
        numberFormatter.generatesDecimalNumbers = false
        barChartDataSet.valueFormatter = DefaultValueFormatter(formatter: numberFormatter)
        barChartDataSet.valueFont = .systemFont(ofSize: 13)
        
        var xValues = [String]()
        for trigger in sortedReport {
            xValues.append(trigger.key)
        }

        let xAxis = triggerRankingBarChartView.xAxis
        xAxis.valueFormatter = IndexAxisValueFormatter(values: xValues)
        xAxis.setLabelCount(8, force: false)
        xAxis.labelFont = .systemFont(ofSize: 13)
        xAxis.labelPosition = .bottom
        xAxis.drawGridLinesEnabled = false
        xAxis.drawAxisLineEnabled = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "filterSegue" {
            let destination = segue.destination as! FilterViewController
            destination.delegate = self
        }
    }
}
