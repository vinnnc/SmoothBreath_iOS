//
//  NewRecordViewController.swift
//  SmoothBreath_iOS
//
//  Created by Wenchu Du on 2019/9/8.
//  Copyright © 2019 Wenchu Du. All rights reserved.
//

import UIKit
import CoreData
import MapKit

class NewRecordViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var dateAndTimeDatePicker: UIDatePicker!
    @IBOutlet weak var attackLevelSlider: UISlider!
    @IBOutlet weak var stressSlider: UISlider!
    @IBOutlet weak var exerciseSlider: UISlider!
    @IBOutlet weak var periodSwitch: UISwitch!
    @IBOutlet weak var fireSwitch: UISwitch!
    @IBOutlet weak var animalSwitch: UISwitch!
    @IBOutlet weak var heavyWindSwitch: UISwitch!
    @IBOutlet weak var pollenSourceSwitch: UISwitch!
    @IBOutlet weak var dustSwitch: UISwitch!

    var locationManager: CLLocationManager = CLLocationManager()
    var currentLocation: CLLocationCoordinate2D?
    var allRecords: [Record] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initialisation()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 10
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initialisation()
        locationManager.startUpdatingLocation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        locationManager.stopUpdatingLocation()
    }
    
    func initialisation() {
        let calandar = Calendar(identifier: .gregorian)
        dateAndTimeDatePicker.maximumDate = calandar.date(byAdding: DateComponents(), to: Date())
        dateAndTimeDatePicker.date = dateAndTimeDatePicker.maximumDate!
        loadData()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        currentLocation = location.coordinate
    }
    @IBAction func attackLevelSliderConfig(_ sender: UISlider) {
        sender.value = roundf(sender.value)
    }
    
    @IBAction func stressSliderConfig(_ sender: UISlider) {
        sender.value = roundf(sender.value)
    }
    
    @IBAction func exerciseSliderConfig(_ sender: UISlider) {
        sender.value = roundf(sender.value)
    }
    
    @IBAction func save(_ sender: Any) {
        var nearby = ""
        if fireSwitch.isOn {
            nearby += "Fire, "
        }
        if animalSwitch.isOn {
            nearby += "Animal, "
        }
        if heavyWindSwitch.isOn {
            nearby += "Heavy Wind, "
        }
        if pollenSourceSwitch.isOn {
            nearby += "Pollen Source, "
        }
        if dustSwitch.isOn {
            nearby += "Dust, "
        }
        
        if nearby.count > 2 {
            nearby = String(nearby.dropLast(2))
        } else {
            nearby = "There is no other trigger nearby."
        }
        
        if currentLocation != nil {
            if addRecord(attackDate: dateAndTimeDatePicker!.date, attackLevel: Int(attackLevelSlider!.value), exercise: Int(exerciseSlider!.value), stress: Int(stressSlider!.value), period: periodSwitch.isOn, nearby: nearby, longitude: Float(currentLocation!.longitude), latitude: Float(currentLocation!.latitude)) {
                displayMessage(title: "Save Secussfully", message: "New record has been saved in the database.")
                tabBarController?.selectedIndex = 2
                return
            } else {
                displayMessage(title: "Save Failed", message: "Attack Date and time have alreay existed in database.")
                return
            }
        } else {
            displayMessage(title: "Save Failed", message: "Attack Date and time have alreay existed in database.")
        }
    }
    
    func addRecord(attackDate: Date, attackLevel: Int, exercise: Int, stress: Int, period: Bool, nearby: String, longitude: Float, latitude: Float) -> Bool {
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
        record.period = period
        record.nearby = nearby
        record.latitude = latitude
        record.longitude = longitude
        
        appDelegate.saveContext()
        
        allRecords.append(record)
        return true
    }
    
    func displayMessage(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
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
    }
}
