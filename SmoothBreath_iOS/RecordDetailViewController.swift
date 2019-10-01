//
//  RecordDetailViewController.swift
//  SmoothBreath_iOS
//
//  Created by Wenchu Du on 2019/9/8.
//  Copyright © 2019 Wenchu Du. All rights reserved.
//

import UIKit

class RecordDetailViewController: UIViewController {
    
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    @IBOutlet weak var attackLevelLabel: UILabel!
    @IBOutlet weak var stressLabel: UILabel!
    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet weak var nearbyLabel: UILabel!
    
    var record: Record?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy hh:mm a"
        dateAndTimeLabel.text = dateFormatter.string(from: record!.attackDate!)
        
        let attackLevel = Int(record!.attackLevel)
        if attackLevel <= 33{
            attackLevelLabel.text = "Mild"
        } else if attackLevel > 33 && attackLevel <= 66 {
            attackLevelLabel.text = "Moderate"
        } else {
            attackLevelLabel.text = "Severe"
        }
        
        let stress = Int(record!.stress)
        if stress <= 25{
            stressLabel.text = "Slight"
        } else if stress > 25 && stress <= 50 {
            stressLabel.text = "Middle"
        } else if stress > 50 && stress <= 75 {
            stressLabel.text = "High"
        } else {
            stressLabel.text = "Extreme"
        }
        
        let exercise = Int(record!.exercise)
        if exercise <= 25{
            exerciseLabel.text = "Slight"
        } else if exercise > 25 && exercise <= 50 {
            exerciseLabel.text = "Middle"
        } else if exercise > 50 && exercise <= 75 {
            exerciseLabel.text = "High"
        } else {
            exerciseLabel.text = "Extreme"
        }
        
        nearbyLabel.text = record?.nearby
    }
}
