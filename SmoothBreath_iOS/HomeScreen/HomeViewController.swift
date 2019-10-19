//
//  HomeViewController.swift
//  SmoothBreath_iOS
//
//  Created by Wenchu Du on 2019/10/8.
//  Copyright © 2019 Wenchu Du. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {

    @IBOutlet weak var greetingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadMockData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let current = Date()
        let df1 = DateFormatter()
        df1.dateFormat = "yyyy-MM-dd"
        let dateStr = df1.string(from: current)
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm"
        let sixAm = df.date(from: "\(dateStr) 06:00")!
        let twelvePm = df.date(from: "\(dateStr) 12:00")!
        let sixPm = df.date(from: "\(dateStr) 18:00")!
        
        if current.compare(sixAm).rawValue >= 0 && current.compare(twelvePm).rawValue < 0 {
            greetingLabel.text = "Good Morning"
        } else if current.compare(twelvePm).rawValue >= 0 && current.compare(sixPm).rawValue < 0 {
            greetingLabel.text = "Good Afternoon"
        } else {
            greetingLabel.text = "Good Evening"
        }
    }
    
    @IBAction func refWebsiteTap(_ sender: Any) {
        guard let url = URL(string: "https://www.smoothbreath.tk") else { return }
        UIApplication.shared.open(url)
    }
    
    func loadMockData() {
        var allRecords = [Record]()
        
        let mockData = [["AttackDate": "2019-08-18 08:26:00", "AttackLevel": "1", "Exercise": "2", "Latitude": "-36.77459", "Longitude": "144.30464", "Nearby": "Pollen Source, Animal", "Period": "TRUE", "Stress": "0"],
        ["AttackDate": "2019-08-20 08:48:00", "AttackLevel": "2", "Exercise": "1", "Latitude": "-36.77569", "Longitude": "144.30378", "Nearby": "Heavy Wind", "Period": "TRUE", "Stress": "2"],
        ["AttackDate": "2019-08-23 08:35:00", "AttackLevel": "0", "Exercise": "3", "Latitude": "-36.77634", "Longitude": "144.30164", "Nearby": "Dust", "Period": "FALSE", "Stress": "0"],
        ["AttackDate": "2019-08-26 09:01:00", "AttackLevel": "1", "Exercise": "0", "Latitude": "-36.77908", "Longitude": "144.30122", "Nearby": "Dust, Animal", "Period": "FALSE", "Stress": "0"],
        ["AttackDate": "2019-08-31 09:27:00", "AttackLevel": "2", "Exercise": "2", "Latitude": "-36.77771", "Longitude": "144.30307", "Nearby": "Heavy Wind", "Period": "TRUE", "Stress": "1"],
        ["AttackDate": "2019-09-06 09:58:00", "AttackLevel": "2", "Exercise": "1", "Latitude": "-36.77792", "Longitude": "144.30135", "Nearby": "Pollen Source, Heavy Wind", "Period": "FALSE", "Stress": "2"],
        ["AttackDate": "2019-09-11 09:14:00", "AttackLevel": "1", "Exercise": "3", "Latitude": "-36.77772", "Longitude": "144.30438", "Nearby": "Pollen Source, Dust", "Period": "FALSE", "Stress": "0"],
        ["AttackDate": "2019-09-14 10:18:00", "AttackLevel": "2", "Exercise": "2", "Latitude": "-36.77688", "Longitude": "144.30192", "Nearby": "Fire", "Period": "FALSE", "Stress": "0"],
        ["AttackDate": "2019-09-17 10:31:00", "AttackLevel": "1", "Exercise": "0", "Latitude": "-36.77721", "Longitude": "144.29914", "Nearby": "Heavy Wind, Dust", "Period": "FALSE", "Stress": "0"],
        ["AttackDate": "2019-09-18 10:42:00", "AttackLevel": "1", "Exercise": "0", "Latitude": "-36.77724", "Longitude": "144.29685", "Nearby": "Animal", "Period": "TRUE", "Stress": "1"],
        ["AttackDate": "2019-09-01 11:55:00", "AttackLevel": "0", "Exercise": "2", "Latitude": "-36.75778", "Longitude": "144.27870", "Nearby": "Dust", "Period": "FALSE", "Stress": "3"],
        ["AttackDate": "2019-09-09 11:00:00", "AttackLevel": "1", "Exercise": "2", "Latitude": "-36.77477", "Longitude": "144.30500", "Nearby": "Heavy Wind", "Period": "FALSE", "Stress": "0"],
        ["AttackDate": "2019-09-19 11:42:00", "AttackLevel": "2", "Exercise": "3", "Latitude": "-36.77539", "Longitude": "144.30594", "Nearby": "Pollen Source, Dust", "Period": "TRUE", "Stress": "2"],
        ["AttackDate": "2019-09-22 12:26:00", "AttackLevel": "2", "Exercise": "3", "Latitude": "-36.77505", "Longitude": "144.30710", "Nearby": "Animal", "Period": "FALSE", "Stress": "1"],
        ["AttackDate": "2019-09-25 12:47:00", "AttackLevel": "1", "Exercise": "1", "Latitude": "-36.77413", "Longitude": "144.30633", "Nearby": "Dust", "Period": "FALSE", "Stress": "2"],
        ["AttackDate": "2019-09-27 12:50:00", "AttackLevel": "0", "Exercise": "2", "Latitude": "-36.77612", "Longitude": "144.30601", "Nearby": "Heavy Wind, Animal", "Period": "TRUE", "Stress": "1"],
        ["AttackDate": "2019-09-30 13:13:00", "AttackLevel": "1", "Exercise": "1", "Latitude": "-36.75778", "Longitude": "144.27870", "Nearby": "Heavy Wind", "Period": "FALSE", "Stress": "1"],
        ["AttackDate": "2019-07-03 13:36:00", "AttackLevel": "0", "Exercise": "3", "Latitude": "-36.77802", "Longitude": "144.30045", "Nearby": "Dust", "Period": "TRUE", "Stress": "3"],
        ["AttackDate": "2019-07-13 13:49:00", "AttackLevel": "0", "Exercise": "2", "Latitude": "-36.78069", "Longitude": "144.30122", "Nearby": "Pollen Source", "Period": "FALSE", "Stress": "2"],
        ["AttackDate": "2019-07-09 14:06:00", "AttackLevel": "1", "Exercise": "0", "Latitude": "-36.77977", "Longitude": "144.29960", "Nearby": "Heavy Wind", "Period": "FALSE", "Stress": "0"],
        ["AttackDate": "2019-07-15 14:46:00", "AttackLevel": "2", "Exercise": "3", "Latitude": "-36.77958", "Longitude": "144.30085", "Nearby": "Dust", "Period": "TRUE", "Stress": "2"],
        ["AttackDate": "2019-07-17 14:59:00", "AttackLevel": "0", "Exercise": "0", "Latitude": "-36.75778", "Longitude": "144.27870", "Nearby": "Fire, Dust", "Period": "TRUE", "Stress": "1"],
        ["AttackDate": "2019-07-18 15:09:00", "AttackLevel": "2", "Exercise": "2", "Latitude": "-36.77978", "Longitude": "144.29895", "Nearby": "Pollen Source, Animal", "Period": "FALSE", "Stress": "3"],
        ["AttackDate": "2019-07-22 15:36:00", "AttackLevel": "2", "Exercise": "2", "Latitude": "-36.77939", "Longitude": "144.29910", "Nearby": "Heavy Wind, Dust", "Period": "FALSE", "Stress": "1"],
        ["AttackDate": "2019-07-26 15:47:00", "AttackLevel": "2", "Exercise": "2", "Latitude": "-36.77843", "Longitude": "144.29965", "Nearby": "Pollen Source", "Period": "TRUE", "Stress": "0"],
        ["AttackDate": "2019-07-28 16:16:00", "AttackLevel": "1", "Exercise": "3", "Latitude": "-36.78105", "Longitude": "144.29893", "Nearby": "Heavy Wind", "Period": "FALSE", "Stress": "3"],
        ["AttackDate": "2019-07-29 16:27:00", "AttackLevel": "1", "Exercise": "1", "Latitude": "-36.78098", "Longitude": "144.30235", "Nearby": "Pollen Source, Dust", "Period": "TRUE", "Stress": "3"],
        ["AttackDate": "2019-07-31 16:58:00", "AttackLevel": "0", "Exercise": "3", "Latitude": "-36.78074", "Longitude": "144.30359", "Nearby": "Heavy Wind", "Period": "FALSE", "Stress": "0"],
        ["AttackDate": "2019-10-01 17:01:00", "AttackLevel": "1", "Exercise": "2", "Latitude": "-36.77946", "Longitude": "144.30387", "Nearby": "Dust, Animal", "Period": "TRUE", "Stress": "2"],
        ["AttackDate": "2019-10-03 17:29:00", "AttackLevel": "1", "Exercise": "2", "Latitude": "-36.77666", "Longitude": "144.30567", "Nearby": "Pollen Source, Animal", "Period": "TRUE", "Stress": "2"],
        ["AttackDate": "2019-10-06 17:41:00", "AttackLevel": "0", "Exercise": "3", "Latitude": "-36.77739", "Longitude": "144.30545", "Nearby": "Dust", "Period": "FALSE", "Stress": "2"],
        ["AttackDate": "2019-10-08 18:08:00", "AttackLevel": "2", "Exercise": "3", "Latitude": "-36.77836", "Longitude": "144.30491", "Nearby": "Heavy Wind, Animal", "Period": "FALSE", "Stress": "3"],
        ["AttackDate": "2019-10-09 18:36:00", "AttackLevel": "1", "Exercise": "3", "Latitude": "-36.77988", "Longitude": "144.30512", "Nearby": "Dust", "Period": "TRUE", "Stress": "0"],
        ["AttackDate": "2019-10-10 18:00:00", "AttackLevel": "2", "Exercise": "2", "Latitude": "-36.77914", "Longitude": "144.30169", "Nearby": "Pollen Source, Dust", "Period": "FALSE", "Stress": "2"],
        ["AttackDate": "2019-10-13 19:04:00", "AttackLevel": "0", "Exercise": "1", "Latitude": "-36.78011", "Longitude": "144.30108", "Nearby": "Dust", "Period": "FALSE", "Stress": "2"],
        ["AttackDate": "2019-10-14 19:45:00", "AttackLevel": "2", "Exercise": "1", "Latitude": "-36.77946", "Longitude": "144.29666", "Nearby": "Heavy Wind", "Period": "TRUE", "Stress": "1"],
        ["AttackDate": "2019-09-21 20:16:00", "AttackLevel": "0", "Exercise": "1", "Latitude": "-36.78140", "Longitude": "144.29946", "Nearby": "Dust, Fire", "Period": "FALSE", "Stress": "2"],
        ["AttackDate": "2019-08-18 21:38:00", "AttackLevel": "0", "Exercise": "1", "Latitude": "-36.78117", "Longitude": "144.29814", "Nearby": "Heavy Wind, Animal", "Period": "FALSE", "Stress": "1"],
        ["AttackDate": "2019-07-29 22:59:00", "AttackLevel": "0", "Exercise": "0", "Latitude": "-36.78035", "Longitude": "144.297101", "Nearby": "Pollen Source, Animal", "Period": "TRUE", "Stress": "0"]]
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            try allRecords = context.fetch(Record.fetchRequest()) as [Record]
        } catch {
            print("Failed to fetch data.")
        }
        
        if allRecords.count == 0 {
            print("Adding record mock data")
            for data in mockData {
                let newRecord = NSEntityDescription.insertNewObject(forEntityName: "Record", into: context) as! Record
                
                let df = DateFormatter()
                df.dateFormat = "yyyy-MM-dd HH:mm:ss"
                newRecord.attackDate = df.date(from: data["AttackDate"]!)
                newRecord.attackLevel = Int32(data["AttackLevel"]!)!
                newRecord.exercise = Int32(data["Exercise"]!)!
                newRecord.latitude = Float(data["Latitude"]!)!
                newRecord.longitude = Float(data["Longitude"]!)!
                newRecord.nearby = data["Nearby"]
                
                if (data["Persion"] == "TRUE") {
                    newRecord.period = true
                } else {
                    newRecord.period = false
                }
            
                appDelegate.saveContext()
            }
            
            do {
                try allRecords = (context.fetch(Record.fetchRequest()) as? [Record])!
            } catch {
                print("Failed to adding mock data.")
            }
        }
    }

}
