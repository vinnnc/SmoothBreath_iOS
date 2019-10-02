//
//  NewRecordViewController.swift
//  SmoothBreath_iOS
//
//  Created by Wenchu Du on 2019/9/8.
//  Copyright © 2019 Wenchu Du. All rights reserved.
//

import UIKit

protocol addRecordDelegate: AnyObject {
    func addRecord(attackDate: Date, attackLevel: Int, exercise: Int, stress: Int, nearby: String) -> Bool
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
            nearby = "There is no other triggers nearby."
        }
        
        if ((delegate?.addRecord(attackDate: dateAndTimeDatePicker!.date, attackLevel: Int(attackLevelSlider!.value), exercise: Int(exerciseSlider!.value), stress: Int(stressSlider!.value), nearby: nearby))!) {
            navigationController?.popViewController(animated: true)
        } else {
            displayMessage(title: "Save Failed", message: "Attack Date and time have alreay exist in database.")
        }

    }
    
    func displayMessage(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
