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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        recordCell.dateAndTimeLabel.text = df.string(from: record.attackDate! as Date)
        recordCell.attackLevelLabel.text = record.attackLevel
        
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
    
    func addRecord(attackDate: NSDate, attackLevel: String, exercise: String, stress: String, nearby: String) -> Bool {
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
        record.attackLevel = attackLevel
        record.exercise = exercise
        record.stress = stress
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
//        let newRecords = [
//            [
//                "attackDate": "01-09-2019 08:14 AM",
//                "attackLevel": "Mild",
//                "exercise": "Low",
//                "stress": "Middle",
//                "nearby": "None"
//            ],
//            [
//                "attackDate": "03-09-2019 08:23 AM",
//                "attackLevel": "Mild",
//                "exercise": "Middle",
//                "stress": "Low",
//                "nearby": "Pollen Source, Dust"
//            ],
//            [
//                "attackDate": "06-09-2019 09:09 AM",
//                "attackLevel": "Moderate",
//                "exercise": "Low",
//                "stress": "Low",
//                "nearby": "Animal, Heavy Wind"
//            ],
//            [
//                "attackDate": "08-09-2019 08:06 AM",
//                "attackLevel": "Mild",
//                "exercise": "Low",
//                "stress": "Low",
//                "nearby": "Animal, Heavy Wind, Pollen Source, Dust"
//            ],
//            [
//                "attackDate": "09-09-2019 09:16 AM",
//                "attackLevel": "Severe",
//                "exercise": "Low",
//                "stress": "Middle",
//                "nearby": "None"
//            ],
//            [
//                "attackDate": "11-09-2019 04:16 PM",
//                "attackLevel": "Moderate",
//                "exercise": "Low",
//                "stress": "Extreme",
//                "nearby": "Animal"
//            ]
//        ]
    
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            try allRecords = context.fetch(Record.fetchRequest()) as! [Record]
        } catch {
            print("Failed to fetch record data.")
        }
        
//        if allRecords.count == 0 {
//            print("Adding Records")
//
//            for recordObj in newRecords {
//                let record = NSEntityDescription.insertNewObject(forEntityName: "Record", into: context) as! Record
//                
//                let df = DateFormatter()
//                df.dateFormat = "dd/MM/yyyy HH:mm a"
//                record.attackDate = df.date(from: recordObj["attackDate"]!) as NSDate?
//                record.attackLevel = recordObj["attackLevel"]
//                record.exercise = recordObj["exercise"]
//                record.stress = recordObj["stress"]
//                record.nearby = recordObj["nearby"]
//            }
//
//            appDelegate.saveContext()
//
//            do {
//                try allRecords = context.fetch(Record.fetchRequest()) as! [Record]
//            } catch {
//                print("Failed to add initial records")
//            }
//        }
        
        allRecords.sort(by: { $0.attackDate!.compare($1.attackDate! as Date) == ComparisonResult.orderedAscending })
    }
}
