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
        
        let mockData = [["AttackDate": "2019-08-18 08:26:00", "AttackLevel": "1", "Exercise": "2", "Latitude": "-36.75778", "Longitude": "144.27870", "Nearby": "Pollen Source, Animal", "Period": "TRUE"] ,
        ["AttackDate": "2019-08-20 08:48:00", "AttackLevel": "0", "Exercise": "1", "Latitude": "-37.92364", "Longitude": "146.98489", "Nearby": "Heavy Wind", "Period": "TRUE"] ,
        ["AttackDate": "2019-08-23 08:35:00", "AttackLevel": "1", "Exercise": "1", "Latitude": "-38.16332", "Longitude": "147.08621", "Nearby": "Dust", "Period": "FALSE"] ,
        ["AttackDate": "2019-08-26 09:01:00", "AttackLevel": "1", "Exercise": "2", "Latitude": "-36.37707", "Longitude": "146.31787", "Nearby": "Dust, Animal", "Period": "FALSE"] ,
        ["AttackDate": "2019-08-31 09:27:00", "AttackLevel": "2", "Exercise": "2", "Latitude": "-35.05349", "Longitude": "142.88318", "Nearby": "Heavy Wind", "Period": "TRUE"] ,
        ["AttackDate": "2019-09-06 09:58:00", "AttackLevel": "0", "Exercise": "3", "Latitude": "-37.92364", "Longitude": "146.98489", "Nearby": "Pollen Source, Heavy Wind", "Period": "FALSE"] ,
        ["AttackDate": "2019-09-11 09:14:00", "AttackLevel": "0", "Exercise": "2", "Latitude": "-36.25546", "Longitude": "142.38529", "Nearby": "Pollen Source, Dust", "Period": "FALSE"] ,
        ["AttackDate": "2019-09-14 10:18:00", "AttackLevel": "0", "Exercise": "1", "Latitude": "-38.16332", "Longitude": "147.08621", "Nearby": "Fire", "Period": "FALSE"] ,
        ["AttackDate": "2019-09-17 10:31:00", "AttackLevel": "2", "Exercise": "1", "Latitude": "-37.92364", "Longitude": "146.98489", "Nearby": "Heavy Wind, Dust", "Period": "FALSE"] ,
        ["AttackDate": "2019-09-18 10:42:00", "AttackLevel": "2", "Exercise": "2", "Latitude": "-39.03075", "Longitude": "146.32727", "Nearby": "Animal", "Period": "TRUE"] ,
        ["AttackDate": "2019-09-01 11:55:00", "AttackLevel": "1", "Exercise": "0", "Latitude": "-36.75778", "Longitude": "144.27870", "Nearby": "Dust", "Period": "FALSE"] ,
        ["AttackDate": "2019-09-09 11:00:00", "AttackLevel": "1", "Exercise": "1", "Latitude": "-35.05349", "Longitude": "142.88318", "Nearby": "Heavy Wind", "Period": "FALSE"] ,
        ["AttackDate": "2019-09-19 11:42:00", "AttackLevel": "2", "Exercise": "3", "Latitude": "-37.92364", "Longitude": "146.98489", "Nearby": "Pollen Source, Dust", "Period": "TRUE"] ,
        ["AttackDate": "2019-09-22 12:26:00", "AttackLevel": "1", "Exercise": "2", "Latitude": "-38.16332", "Longitude": "147.08621", "Nearby": "Animal", "Period": "FALSE"] ,
        ["AttackDate": "2019-09-25 12:47:00", "AttackLevel": "1", "Exercise": "2", "Latitude": "-38.17076", "Longitude": "144.71862", "Nearby": "Dust", "Period": "FALSE"] ,
        ["AttackDate": "2019-09-27 12:50:00", "AttackLevel": "1", "Exercise": "1", "Latitude": "-39.03075", "Longitude": "146.32727", "Nearby": "Heavy Wind, Animal", "Period": "TRUE"] ,
        ["AttackDate": "2019-09-30 13:13:00", "AttackLevel": "1", "Exercise": "0", "Latitude": "-36.75778", "Longitude": "144.27870", "Nearby": "Heavy Wind", "Period": "FALSE"] ,
        ["AttackDate": "2019-07-03 13:36:00", "AttackLevel": "1", "Exercise": "0", "Latitude": "-38.19675", "Longitude": "144.70397", "Nearby": "Dust", "Period": "TRUE"] ,
        ["AttackDate": "2019-07-13 13:49:00", "AttackLevel": "1", "Exercise": "3", "Latitude": "-37.92364", "Longitude": "146.98489", "Nearby": "Pollen Source", "Period": "FALSE"] ,
        ["AttackDate": "2019-07-09 14:06:00", "AttackLevel": "0", "Exercise": "2", "Latitude": "-35.05349", "Longitude": "142.88318", "Nearby": "Heavy Wind", "Period": "FALSE"] ,
        ["AttackDate": "2019-07-15 14:46:00", "AttackLevel": "0", "Exercise": "1", "Latitude": "-38.16332", "Longitude": "147.08621", "Nearby": "Dust", "Period": "TRUE"] ,
        ["AttackDate": "2019-07-17 14:59:00", "AttackLevel": "2", "Exercise": "0", "Latitude": "-36.75778", "Longitude": "144.27870", "Nearby": "Fire, Dust", "Period": "TRUE"] ,
        ["AttackDate": "2019-07-18 15:09:00", "AttackLevel": "1", "Exercise": "1", "Latitude": "-38.17076", "Longitude": "144.71862", "Nearby": "Pollen Source, Animal", "Period": "FALSE"] ,
        ["AttackDate": "2019-07-22 15:36:00", "AttackLevel": "0", "Exercise": "0", "Latitude": "-38.16332", "Longitude": "147.08621", "Nearby": "Heavy Wind, Dust", "Period": "FALSE"] ,
        ["AttackDate": "2019-07-26 15:47:00", "AttackLevel": "0", "Exercise": "1", "Latitude": "-37.92364", "Longitude": "146.98489", "Nearby": "Pollen Source", "Period": "TRUE"] ,
        ["AttackDate": "2019-07-28 16:16:00", "AttackLevel": "1", "Exercise": "0", "Latitude": "-38.28524", "Longitude": "144.48656", "Nearby": "Heavy Wind", "Period": "FALSE"] ,
        ["AttackDate": "2019-07-29 16:27:00", "AttackLevel": "1", "Exercise": "0", "Latitude": "-38.16332", "Longitude": "147.08621", "Nearby": "Pollen Source, Dust", "Period": "TRUE"] ,
        ["AttackDate": "2019-07-31 16:58:00", "AttackLevel": "1", "Exercise": "3", "Latitude": "-36.75778", "Longitude": "144.27870", "Nearby": "Heavy Wind", "Period": "FALSE"] ,
        ["AttackDate": "2019-10-01 17:01:00", "AttackLevel": "1", "Exercise": "3", "Latitude": "-39.03075", "Longitude": "146.32727", "Nearby": "Dust, Animal", "Period": "TRUE"] ,
        ["AttackDate": "2019-10-03 17:29:00", "AttackLevel": "1", "Exercise": "1", "Latitude": "-36.25546", "Longitude": "142.38529", "Nearby": "Pollen Source, Animal", "Period": "TRUE"] ,
        ["AttackDate": "2019-10-06 17:41:00", "AttackLevel": "0", "Exercise": "3", "Latitude": "-37.92364", "Longitude": "146.98489", "Nearby": "Dust", "Period": "FALSE"] ,
        ["AttackDate": "2019-10-08 18:08:00", "AttackLevel": "0", "Exercise": "1", "Latitude": "-38.19675", "Longitude": "144.70397", "Nearby": "Heavy Wind, Animal", "Period": "FALSE"] ,
        ["AttackDate": "2019-10-09 18:36:00", "AttackLevel": "1", "Exercise": "0", "Latitude": "-36.75778", "Longitude": "144.27870", "Nearby": "Dust", "Period": "TRUE"] ,
        ["AttackDate": "2019-10-10 18:00:00", "AttackLevel": "2", "Exercise": "2", "Latitude": "-38.17076", "Longitude": "144.71862", "Nearby": "Pollen Source, Dust", "Period": "FALSE"] ,
        ["AttackDate": "2019-10-13 19:04:00", "AttackLevel": "2", "Exercise": "3", "Latitude": "-37.92364", "Longitude": "146.98489", "Nearby": "Dust", "Period": "FALSE"] ,
        ["AttackDate": "2019-10-14 19:45:00", "AttackLevel": "0", "Exercise": "2", "Latitude": "-36.25546", "Longitude": "142.38529", "Nearby": "Heavy Wind", "Period": "TRUE"] ,
        ["AttackDate": "2019-09-21 20:16:00", "AttackLevel": "2", "Exercise": "3", "Latitude": "-36.75778", "Longitude": "144.27870", "Nearby": "Dust, Fire", "Period": "FALSE"] ,
        ["AttackDate": "2019-08-18 21:38:00", "AttackLevel": "0", "Exercise": "1", "Latitude": "-35.05349", "Longitude": "142.88318", "Nearby": "Heavy Wind, Animal", "Period": "FALSE"] ,
        ["AttackDate": "2019-07-29 22:59:00", "AttackLevel": "2", "Exercise": "2", "Latitude": "-38.16332", "Longitude": "147.08621", "Nearby": "Pollen Source, Animal", "Period": "TRUE"]]
        
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
            
            print(allRecords)
        }
    }

}
