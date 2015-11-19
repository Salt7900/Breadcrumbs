//
//  crumb.swift
//  breadCrumbs
//
//  Created by Ben Fallon on 11/19/15.
//  Copyright © 2015 Ben Fallon. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class Crumb: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let radius: CLLocationDistance
    let title: String?
    let subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, radius: CLLocationDistance, note: String, message: String){
        self.coordinate = coordinate
        self.radius = radius
        self.title = note
        self.subtitle = message
    }

}
