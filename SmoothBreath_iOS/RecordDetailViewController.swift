//
//  RecordDetailViewController.swift
//  SmoothBreath_iOS
//
//  Created by Wenchu Du on 2019/9/8.
//  Copyright © 2019 Wenchu Du. All rights reserved.
//

import UIKit
import MapKit

class RecordDetailViewController: UIViewController {
    
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    @IBOutlet weak var attackLevelLabel: UILabel!
    @IBOutlet weak var stressLabel: UILabel!
    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var nearbyLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var record: Record?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy hh:mm a"
        dateAndTimeLabel.text = dateFormatter.string(from: record!.attackDate!)
        
        let attackLevel = Int(record!.attackLevel)
        if attackLevel == 0 {
            attackLevelLabel.text = "Mild"
        } else if attackLevel == 1 {
            attackLevelLabel.text = "Moderate"
        } else {
            attackLevelLabel.text = "Severe"
        }
        
        let stress = Int(record!.stress)
        if stress == 0 {
            stressLabel.text = "Slight"
        } else if stress == 1 {
            stressLabel.text = "Middle"
        } else if stress == 2 {
            stressLabel.text = "High"
        } else {
            stressLabel.text = "Extreme"
        }
        
        let exercise = Int(record!.exercise)
        if exercise == 0 {
            exerciseLabel.text = "Slight"
        } else if exercise == 1 {
            exerciseLabel.text = "Middle"
        } else if exercise == 2 {
            exerciseLabel.text = "High"
        } else {
            exerciseLabel.text = "Extreme"
        }
        
        if record!.period {
            periodLabel.text = "Yes"
        } else {
            periodLabel.text = "No"
        }
        
        nearbyLabel.text = record?.nearby
        
        if !(record?.latitude.isZero)! && !(record?.longitude.isZero)! {
            let annotation = Annotation(newTitle: "", newSubtitle: "", lat: Double(record!.latitude), long: Double(record!.longitude))
            mapView.addAnnotation(annotation)
            focusOn(annotation: annotation)
        }
    }
    
    func focusOn(annotation: MKAnnotation) {
        let zoomRegion = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 1000,
        longitudinalMeters: 1000)
        mapView.setRegion(mapView.regionThatFits(zoomRegion), animated: true)
    }
}
