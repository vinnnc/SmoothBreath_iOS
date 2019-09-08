//
//  CounterViewController.swift
//  SmoothBreath_iOS
//
//  Created by Wenchu Du on 2019/9/4.
//  Copyright © 2019 Wenchu Du. All rights reserved.
//

import UIKit

class CounterViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var remainingUsageLabel: UILabel!
    @IBOutlet weak var totalUsageLabel: UILabel!
    @IBOutlet weak var inhalerProgressView: UIProgressView!
    @IBOutlet weak var percentageRemainingLabel: UILabel!
    @IBOutlet weak var totalUsageTextField: UITextField!
    
    var remainingUsage = 175
    var totalUsage = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerKeyboardNotifications()
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        updateView()
    }
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)),name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
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
        if remainingUsage > 0 {
            remainingUsage -= 1
            updateView()
        } else {
            displayMessage(title: "Inhaler Empty", message: "Please reset a new inhaler.")
        }
    }
    
    @IBAction func removeUsage(_ sender: Any) {
        if remainingUsage < totalUsage {
            remainingUsage += 1
            updateView()
        } else {
            displayMessage(title: "Cannot Remove Usage", message: "Remaining usage is already same with total usage.")
        }
    }
    
    func updateView() {
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
            totalUsage = number
            remainingUsage = number
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
}
