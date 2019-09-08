//
//  NewRecordViewController.swift
//  SmoothBreath_iOS
//
//  Created by Wenchu Du on 2019/9/8.
//  Copyright © 2019 Wenchu Du. All rights reserved.
//

import UIKit

protocol addRecordDelegate: AnyObject {
    func addRecord(record: Record) -> Bool
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
        let dateAndTime = dateAndTimeDatePicker.date
        
        var attackLevel = ""
        if attackLevelSlider.value < 25 {
            attackLevel = "Slight"
        } else if attackLevelSlider.value >= 25 && attackLevelSlider.value < 50 {
            attackLevel = "Medium"
        } else if attackLevelSlider.value >= 50 && attackLevelSlider.value < 75 {
            attackLevel = "High"
        } else {
            attackLevel = "Serious"
        }
        
        var stress = ""
        if stressSlider.value < 25 {
            stress = "Slight"
        } else if stressSlider.value >= 25 && stressSlider.value < 50 {
            stress = "Medium"
        } else if stressSlider.value >= 50 && stressSlider.value < 75 {
            stress = "High"
        } else {
            stress = "Serious"
        }
        
        var exercise = ""
        if exerciseSlider.value < 25 {
            exercise = "Slight"
        } else if exerciseSlider.value >= 25 && exerciseSlider.value < 50 {
            exercise = "Medium"
        } else if exerciseSlider.value >= 50 && exerciseSlider.value < 75 {
            exercise = "High"
        } else {
            exercise = "Serious"
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
        
        let record = Record(dateAndTime: dateAndTime, attackLevel: attackLevel, stress: stress, exercise: exercise, nearby: nearby)
        
        if (delegate?.addRecord(record: record))! {
            navigationController?.popViewController(animated: true)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
