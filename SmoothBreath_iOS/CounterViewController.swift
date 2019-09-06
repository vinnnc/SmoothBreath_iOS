//
//  CounterViewController.swift
//  SmoothBreath_iOS
//
//  Created by Wenchu Du on 2019/9/4.
//  Copyright © 2019 Wenchu Du. All rights reserved.
//

import UIKit

class CounterViewController: UIViewController {
    @IBOutlet weak var remainingUsageLabel: UILabel!
    @IBOutlet weak var todaysUsageLabel: UILabel!
    @IBOutlet weak var averageDailyUsageLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var daysTillItEndsLabel: UILabel!
    @IBOutlet weak var lastChangeDateLabel: UILabel!
    @IBOutlet weak var expectedChangeDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
