//
//  RecordTableViewController.swift
//  SmoothBreath_iOS
//
//  Created by Wenchu Du on 2019/9/8.
//  Copyright © 2019 Wenchu Du. All rights reserved.
//

import UIKit

class RecordTableViewController: UITableViewController, addRecordDelegate {
    
    let SECTION_COUNT = 1
    let SECTION_RECORD = 0
    let CELL_COUNT = "countCell"
    let CELL_RECORD = "recordCell"
    
    var allRecords: [Record] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        initalisation()
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
            countCell.textLabel?.text = "\(allRecords.count) records in database"
            
            countCell.selectionStyle = .none
            return countCell
        }
        let recordCell = tableView.dequeueReusableCell(withIdentifier: CELL_RECORD, for: indexPath) as! RecordTableViewCell
        let record = allRecords[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-YYYY HH:MM a"
        recordCell.dateAndTimeLabel.text = dateFormatter.string(from: record.dateAndTime!)
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
            allRecords.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadSections([SECTION_COUNT], with: .automatic)
        }
    }
    
    func addRecord(record: Record) -> Bool {
        allRecords.append(record)
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: allRecords.count - 1, section: SECTION_RECORD)], with: .automatic)
        tableView.endUpdates()
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
    }

    func initalisation() {
        
    }
}
