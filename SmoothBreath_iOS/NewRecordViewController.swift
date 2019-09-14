//
//  NewRecordViewController.swift
//  SmoothBreath_iOS
//
//  Created by Wenchu Du on 2019/9/8.
//  Copyright © 2019 Wenchu Du. All rights reserved.
//

import UIKit

protocol addRecordDelegate: AnyObject {
    func addRecord(attackDate: String, attackLevel: String, exercise: String, stress: String, nearby: String) -> Bool
}

class NewRecordViewController: UIViewController {
    
    @IBOutlet weak var dateAndTimeDatePicker: UIDatePicker!
    @IBOutlet weak var attackLevelSlider: UISlider!
    @IBOutlet weak var stressSlider: UISlider!
    @IBOutlet weak var exerciseSlider: UISlider!
    @IBOutlet weak var fireSwitch: UISwitch!
    @IBOutlet weak var animalSwitch: UISwitch!
    @IBOutlet weak var heavyWindSwitch: UISwitch!
    @IBOutlet weak var pollenSourceSwitch: UISwitch!
    @IBOutlet weak var dustSwitch: UISwitch!
    
    var delegate: RecordTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let calandar = Calendar(identifier: .gregorian)
        dateAndTimeDatePicker.maximumDate = calandar.date(byAdding: DateComponents(), to: Date())
    }
    
    @IBAction func save(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy hh:mm a"
        let dateAndTime = dateFormatter.string(from: dateAndTimeDatePicker.date)
        
        var attackLevel = ""
        if attackLevelSlider.value <= 0.33 {
            attackLevel = "Mild"
        } else if attackLevelSlider.value > 0.33 && attackLevelSlider.value <= 0.66 {
            attackLevel = "Moderate"
        } else {
            attackLevel = "Severe"
        }
        
        var stress = ""
        if stressSlider.value < 0.25 {
            stress = "Low"
        } else if stressSlider.value >= 0.25 && stressSlider.value < 0.50 {
            stress = "Middle"
        } else if stressSlider.value >= 0.50 && stressSlider.value < 0.75 {
            stress = "High"
        } else {
            stress = "Extreme"
        }
        
        var exercise = ""
        if exerciseSlider.value < 0.25 {
            exercise = "Low"
        } else if exerciseSlider.value >= 0.25 && exerciseSlider.value < 0.50 {
            exercise = "Middle"
        } else if exerciseSlider.value >= 0.50 && exerciseSlider.value < 0.75 {
            exercise = "Hight"
        } else {
            exercise = "Extreme"
        }
        
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
            nearby = "None"
        }
        
        if ((delegate?.addRecord(attackDate: dateAndTime, attackLevel: attackLevel, exercise: exercise, stress: stress, nearby: nearby))!) {
            navigationController?.popViewController(animated: true)
        } else {
            displayMessage(title: "Time Duplicate", message: "Attack Date and time have alreay exist in database.")
        }

    }
    
    func displayMessage(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
