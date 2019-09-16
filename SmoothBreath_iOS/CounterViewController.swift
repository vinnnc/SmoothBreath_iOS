//
//  CounterViewController.swift
//  SmoothBreath_iOS
//
//  Created by Wenchu Du on 2019/9/4.
//  Copyright © 2019 Wenchu Du. All rights reserved.
//

import UIKit
import CoreData

class CounterViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var remainingUsageLabel: UILabel!
    @IBOutlet weak var totalUsageLabel: UILabel!
    @IBOutlet weak var inhalerProgressView: UIProgressView!
    @IBOutlet weak var percentageRemainingLabel: UILabel!
    @IBOutlet weak var totalUsageTextField: UITextField!
    var counters = [Counter]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerKeyboardNotifications()
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
        loadData()
        updateView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        registerKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)),name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
    
    @IBAction func addUsage(_ sender: Any) {
        var remainingUsage = Int(counters.first!.remainingUsage!)!
        if remainingUsage > 0 {
            remainingUsage -= 1
            counters.first?.setValue(String(remainingUsage), forKey: "remainingUsage")
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            appDelegate.saveContext()
            updateView()
        } else {
            displayMessage(title: "Inhaler Empty", message: "Please reset a new inhaler.")
        }
    }
    
    @IBAction func removeUsage(_ sender: Any) {
        let totalUsage = Int(counters.first!.totalUsage!)!
        var remainingUsage = Int(counters.first!.remainingUsage!)!
        if remainingUsage < totalUsage {
            remainingUsage += 1
            counters.first?.setValue(String(remainingUsage), forKey: "remainingUsage")
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            appDelegate.saveContext()
            updateView()
        } else {
            displayMessage(title: "Cannot Remove Usage", message: "Remaining usage is already same with total usage.")
        }
    }
    
    func updateView() {
        let totalUsage = Int(counters.first!.totalUsage!)!
        let remainingUsage = Int(counters.first!.remainingUsage!)!
        let percentage = Float(remainingUsage) / Float(totalUsage)
        remainingUsageLabel.text = String(remainingUsage)
        totalUsageLabel.text = "/\(totalUsage)"
        inhalerProgressView.progress = percentage
        percentageRemainingLabel.text = "\(percentage * 100)% Remaining"
    }
    
    @IBAction func reset(_ sender: Any) {
        if totalUsageTextField.text != "" {
            guard let number = Int(totalUsageTextField.text!) else {
                displayMessage(title: "Invalid Total Usage", message: "Please enter a number.")
                return
            }
            counters.first?.setValue(String(number), forKey: "totalUsage")
            counters.first?.setValue(String(number), forKey: "remainingUsage")
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            appDelegate.saveContext()
            updateView()
        } else {
            displayMessage(title: "Empty Total Usage", message: "Please enter total usage number.")
        }
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
            try counters = context.fetch(Counter.fetchRequest()) as! [Counter]
        } catch {
            print("Failed to fetch counter data.")
        }
        
        if counters.count == 0 {
            print("Adding Counter")
            
            let counter = NSEntityDescription.insertNewObject(forEntityName: "Counter", into: context) as! Counter
            
            counter.totalUsage = "200"
            counter.remainingUsage = "175"
            
            appDelegate.saveContext()
            
            do {
                try counters = context.fetch(Counter.fetchRequest()) as! [Counter]
            } catch {
                print("Failed to add initial records")
            }
        }
    }
}
