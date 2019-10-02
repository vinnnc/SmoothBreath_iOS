//
//  CounterViewController.swift
//  SmoothBreath_iOS
//
//  Created by Wenchu Du on 2019/9/4.
//  Copyright © 2019 Wenchu Du. All rights reserved.
//

import UIKit
import CoreData

class CounterViewController: UIViewController, ResetInhalerDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var remainingUsageLabel: UILabel!
    @IBOutlet weak var totalUsageLabel: UILabel!
    @IBOutlet weak var inhalerProgressView: UIProgressView!
    @IBOutlet weak var leftDayLabel: UILabel!
    @IBOutlet weak var lastDateLabel: UILabel!
    @IBOutlet weak var expectedDateLabel: UILabel!
    @IBOutlet weak var changeUsageStepper: UIStepper!
    
    var counter: Counter?
    var previousValue: Double = 0

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

    @IBAction func stepperChangeUsage(_ sender: UIStepper) {
        if sender.value < previousValue {
            addUsage()
        } else {
            removeUsage()
        }
        previousValue = sender.value
    }
    
    func addUsage() {
        var remainingUsage = Int(counter!.remainingUsage)

        if remainingUsage > 0 {
            remainingUsage -= 1
            counter!.setValue(Int32(remainingUsage), forKey: "remainingUsage")
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }

            appDelegate.saveContext()
            updateView()
        }
    }

    func removeUsage() {
        let totalUsage = Int(counter!.totalUsage)
        var remainingUsage = Int(counter!.remainingUsage)

        if remainingUsage < totalUsage {
            remainingUsage += 1
            counter!.setValue(Int32(remainingUsage), forKey: "remainingUsage")
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }

            appDelegate.saveContext()
            updateView()
        }
    }

    func updateView() {
        let totalUsage = Int(counter!.totalUsage)
        let remainingUsage = Int(counter!.remainingUsage)
        let percentage = Float(remainingUsage) / Float(totalUsage)
        
        remainingUsageLabel.text = String(remainingUsage)
        totalUsageLabel.text = "/\(totalUsage)"
        inhalerProgressView.progress = percentage
        
        let df = DateFormatter()
        df.dateFormat = "dd-MM-yyyy"
        lastDateLabel.text = df.string(from: counter!.lastChangedDate!)
        
        let calendar = Calendar.current
        let currentDate = calendar.startOfDay(for: Date())
        let lastChangedDate = calendar.startOfDay(for: counter!.lastChangedDate!)
        let duration = calendar.dateComponents([.day], from: lastChangedDate, to: currentDate).day! + 1
        let dailyUsage = Float(totalUsage - remainingUsage) / Float(duration)
        if dailyUsage == 0 {
            leftDayLabel.text = "Left day will be shown after the usage"
            expectedDateLabel.text = "New inhaler"
            return
        }
        
        let expectedLeftDay = Int(Float(remainingUsage) / dailyUsage)
        
        if expectedLeftDay <= 1 {
            leftDayLabel.text = "About \(expectedLeftDay) day left to the end"
        } else {
            leftDayLabel.text = "About \(expectedLeftDay) days left to the end"
        }
        
        let expectedDate = df.string(from: Calendar.current.date(byAdding: .day, value: expectedLeftDay, to: Date())!)
        expectedDateLabel.text = expectedDate
    }
    
    func resetInhaler(totalUsage: Int) -> Bool {
        counter!.setValue(Int32(totalUsage), forKey: "totalUsage")
        counter!.setValue(Int32(totalUsage), forKey: "remainingUsage")
        changeUsageStepper.maximumValue = Double(totalUsage)
        changeUsageStepper.value = Double(totalUsage)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }

        appDelegate.saveContext()
        updateView()
        
        return true
    }
    
    func loadData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            try counter = context.fetch(Counter.fetchRequest()).first as? Counter
        } catch {
            print("Failed to fetch counter data.")
        }
        
        if counter == nil {
            print("Adding Counter")
            
            let newCounter = NSEntityDescription.insertNewObject(forEntityName: "Counter", into: context) as! Counter
            
            newCounter.totalUsage = 200
            newCounter.remainingUsage = 200
            newCounter.lastChangedDate = Date()
            
            appDelegate.saveContext()
            
            do {
                try counter = (context.fetch(Counter.fetchRequest()).first as? Counter)!
            } catch {
                print("Failed to initial counter.")
            }
        }
        
        changeUsageStepper.maximumValue = Double(counter!.totalUsage)
        changeUsageStepper.minimumValue = 0
        changeUsageStepper.value = Double(counter!.remainingUsage)
        previousValue = Double(counter!.remainingUsage)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "resetInhalerSegue" {
            let destination = segue.destination as! ResetInhalerViewController
            destination.delegate = self
        }
    }
}
