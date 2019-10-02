//
//  RecordTableViewController.swift
//  SmoothBreath_iOS
//
//  Created by Wenchu Du on 2019/9/8.
//  Copyright © 2019 Wenchu Du. All rights reserved.
//

import UIKit
import CoreData

class RecordTableViewController: UITableViewController, addRecordDelegate {

    let SECTION_COUNT = 1
    let SECTION_RECORD = 0
    let CELL_COUNT = "countCell"
    let CELL_RECORD = "recordCell"
    
    var allRecords = [Record]()

    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == SECTION_COUNT {
            return 1
        }
        
        return allRecords.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == SECTION_COUNT {
            let countCell = tableView.dequeueReusableCell(withIdentifier: CELL_COUNT, for: indexPath)
            if allRecords.count < 2 {
                countCell.textLabel?.text = "\(allRecords.count) record in database"
            } else {
                countCell.textLabel?.text = "\(allRecords.count) records in database"
            }
            
            countCell.selectionStyle = .none
            return countCell
        }
        let recordCell = tableView.dequeueReusableCell(withIdentifier: CELL_RECORD, for: indexPath) as! RecordTableViewCell
        let record = allRecords[indexPath.row]
        
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy HH:mm a"
        recordCell.dateAndTimeLabel.text = df.string(from: record.attackDate!)
        
        let attackLevel = Int(record.attackLevel)
        if attackLevel <= 33{
            recordCell.attackLevelLabel.text = "Attack Level: Mild"
        } else if attackLevel > 33 && attackLevel <= 66 {
            recordCell.attackLevelLabel.text = "Attack Level: Moderate"
        } else {
            recordCell.attackLevelLabel.text = "Attack Level: Severe"
        }
        
        let stress = Int(record.stress)
        if stress <= 25{
            recordCell.stressLabel.text = "Stress: Slight"
        } else if stress > 25 && stress <= 50 {
            recordCell.stressLabel.text = "Stress: Middle"
        } else if stress > 50 && stress <= 75 {
            recordCell.stressLabel.text = "Stress: High"
        } else {
            recordCell.stressLabel.text = "Stress: Extreme"
        }
        
        let exercise = Int(record.exercise)
        if exercise <= 25{
            recordCell.exerciseLabel.text = "Exercise: Slight"
        } else if exercise > 25 && exercise <= 50 {
            recordCell.exerciseLabel.text = "Exercise: Middle"
        } else if exercise > 50 && exercise <= 75 {
            recordCell.exerciseLabel.text = "Exercise: High"
        } else {
            recordCell.exerciseLabel.text = "Exercise: Extreme"
        }
        
        recordCell.nearbyLabel.text = "Nearby: \(record.nearby ?? "")"
        
        return recordCell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        if indexPath.section == SECTION_COUNT {
            return false
        }
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == SECTION_RECORD {
            let record = allRecords[indexPath.row]
            performSegue(withIdentifier: "recordDetailSegue", sender: record)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == SECTION_RECORD {
            return 120
        }
        return 44
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete && indexPath.section == SECTION_RECORD {
            // Delete the row from the data source
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            let context = appDelegate.persistentContainer.viewContext
            context.delete(allRecords[indexPath.row])
            allRecords.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadSections([SECTION_COUNT], with: .automatic)
        }
    }
    
    func addRecord(attackDate: Date, attackLevel: Int, exercise: Int, stress: Int, nearby: String) -> Bool {
        for record in allRecords {
            if record.attackDate == attackDate {
                return false
            }
        }
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let record = NSEntityDescription.insertNewObject(forEntityName: "Record", into: context) as! Record
        
        record.attackDate = attackDate
        record.attackLevel = Int32(attackLevel)
        record.exercise = Int32(exercise)
        record.stress = Int32(stress)
        record.nearby = nearby
        
        appDelegate.saveContext()
        
        allRecords.append(record)
        allRecords.sort(by: { $0.attackDate!.compare($1.attackDate! as Date) == ComparisonResult.orderedAscending })
        tableView.reloadSections([SECTION_RECORD], with: .automatic)
        tableView.reloadSections([SECTION_COUNT], with: .automatic)
        return true
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "recordDetailSegue" {
            let destination = segue.destination as! RecordDetailViewController
            destination.record = sender as? Record
        }
        if segue.identifier == "newRecordSegue" {
            let destination = segue.destination as! NewRecordViewController
            destination.delegate = self
        }
        if segue.identifier == "statisticSegue" {
            let destination = segue.destination as! StatisticViewController
            destination.allRecords = allRecords
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
}
