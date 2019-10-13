//
//  ResetInhalerViewController.swift
//  SmoothBreath_iOS
//
//  Created by Wenchu Du on 2019/10/2.
//  Copyright © 2019 Wenchu Du. All rights reserved.
//

import UIKit

protocol ResetInhalerDelegate {
    func resetInhaler(totalUsage: Int) -> Bool
}

class ResetInhalerViewController: UIViewController {
    
    @IBOutlet weak var totalUsageTextField: UITextField!
    var delegate: CounterViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func save(_ sender: Any) {
        guard let totalUsage = Int(totalUsageTextField.text!) else {
            displayMessage(title: "Save Failed", message: "Please enter a number between 1 to 500.")
            return
        }
        
        if totalUsage < 1 || totalUsage > 500 {
            displayMessage(title: "Save Failed", message: "Please enter a number between 1 to 500.")
            return
        }
        
        guard (delegate?.resetInhaler(totalUsage: totalUsage))! else {
            displayMessage(title: "Save Failed", message: "Error")
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
