//
//  MapViewController.swift
//  SmoothBreath_iOS
//
//  Created by Wenchu Du on 2019/9/4.
//  Copyright © 2019 Wenchu Du. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager: CLLocationManager = CLLocationManager()
    var currentLocation: CLLocationCoordinate2D?
    var allRecords: [Record] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 10
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        addAnnotations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        locationManager.startUpdatingLocation()
        if let userLocation = locationManager.location?.coordinate {
            let viewRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 2000, longitudinalMeters: 2000)
            mapView.setRegion(viewRegion, animated: false)
        }
        
        addAnnotations()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        locationManager.stopUpdatingLocation()
    }
    
    func loadData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            try allRecords = context.fetch(Record.fetchRequest()) as! [Record]
        } catch {
            print("Failed to fetch record data.")
        }
    }
    
    func addAnnotations() {
        loadData()
        var allAnnotations = [Annotation]()
        
        for record in allRecords {
            if !record.latitude.isZero && !record.longitude.isZero {
                
                let attackLevel = Int(record.attackLevel)
                var attackLevelStr = ""
                if attackLevel == 0 {
                    attackLevelStr = "Attack Level: Mild"
                } else if attackLevel == 1 {
                    attackLevelStr = "Attack Level: Moderate"
                } else {
                    attackLevelStr = "Attack Level: Severe"
                }
                
                let df = DateFormatter()
                df.dateFormat = "dd-MM-yyyy hh:mm a"
                let annotation = Annotation(newTitle: df.string(from: record.attackDate!), newSubtitle: attackLevelStr, lat: Double(record.latitude), long: Double(record.longitude))
                allAnnotations.append(annotation)
            }
        }
        
        mapView.addAnnotations(allAnnotations)
    }
}
