//
//  HomeViewController.swift
//  SmoothBreath_iOS
//
//  Created by Wenchu Du on 2019/10/8.
//  Copyright © 2019 Wenchu Du. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var greetingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
