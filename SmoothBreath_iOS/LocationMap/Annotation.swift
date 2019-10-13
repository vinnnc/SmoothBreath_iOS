//
//  Annotation.swift
//  SmoothBreath_iOS
//
//  Created by Wenchu Du on 2019/10/4.
//  Copyright © 2019 Wenchu Du. All rights reserved.
//

import UIKit
import MapKit

class Annotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init (newTitle: String, newSubtitle: String, lat: Double, long: Double) {
    self.title = newTitle
    self.subtitle = newSubtitle
    coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
}
