//
//  FilterViewController.swift
//  SmoothBreath_iOS
//
//  Created by Wenchu Du on 2019/10/7.
//  Copyright © 2019 Wenchu Du. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet weak var fromDatePicker: UIDatePicker!
    @IBOutlet weak var toDatePicker: UIDatePicker!
    
    var delegate: StatisticViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialisation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initialisation()
    }
    
    func initialisation() {
        let calendar = Calendar(identifier: .gregorian)
        
        toDatePicker.maximumDate = calendar.date(byAdding: DateComponents(), to: Date())
        fromDatePicker.maximumDate = calendar.date(byAdding: DateComponents(), to: Date())
    }
    
    @IBAction func confirm(_ sender: Any) {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        
        let fromDateStr = "\(df.string(from: fromDatePicker.date)) 00:00:00"
        let toDateStr = "\(df.string(from: toDatePicker.date)) 23:59:59"

        let df1 = DateFormatter()
        df1.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let fromDate = df1.date(from: fromDateStr)
        let toDate = df1.date(from: toDateStr)
        
        if fromDate!.compare(toDate!).rawValue < 0 {
            delegate?.fromDate = fromDate
            delegate?.toDate = toDate
        } else {
            displayMessage(title: "Filter Failed", message: "From date cannot greater than to date.")
            return
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    func displayMessage(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
