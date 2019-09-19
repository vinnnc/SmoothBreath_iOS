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
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm a"
        dateAndTimeLabel.text = dateFormatter.string(from: (record?.attackDate! as Date?)!)
        attackLevelLabel.text = record?.attackLevel
        stressLabel.text = record?.stress
        exerciseLabel.text = record?.exercise
        nearbyLabel.text = record?.nearby
    }
}
