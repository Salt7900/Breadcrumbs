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

let kCrumbLat = "latitude"
let kCrumbLong = "longitude"
let KCrumbRadius = "radius"
let KCrumbNote = "note"
let KCrumbMessage = "message"


class Crumb: NSObject, MKAnnotation {
    let latitude: Double
    let longitude: Double
    let coordinate: CLLocationCoordinate2D
    let radius: CLLocationDistance
    let title: String?
    let subtitle: String?
    let identity: String
    
    init(coordinate: CLLocationCoordinate2D, radius: CLLocationDistance, note: String, message: String){
        self.coordinate = coordinate
        self.radius = radius
        self.title = note
        self.subtitle = message
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
        self.identity = NSUUID().UUIDString
    }
    
    
}
    //Required for core data
//     Also require the class to be a part of NSCoding
//    required init?(coder decoder: NSCoder) {
//        longitude = decoder.decodeDoubleForKey(kCrumbLong)
//        latitude = decoder.decodeDoubleForKey(kCrumbLat)
//        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//        radius = decoder.decodeDoubleForKey(KCrumbRadius)
//        title = decoder.decodeObjectForKey(KCrumbNote) as? String
//        subtitle = decoder.decodeObjectForKey(KCrumbMessage) as? String
//    }
//    
//    func encodeWithCoder(coder: NSCoder) {
//        coder.encodeDouble(self.coordinate.latitude, forKey: kCrumbLat)
//        coder.encodeDouble(self.coordinate.longitude, forKey: kCrumbLong)
//        coder.encodeDouble(self.radius, forKey: KCrumbRadius)
//        coder.encodeObject(self.title, forKey: KCrumbNote)
//        coder.encodeObject(self.subtitle, forKey: KCrumbMessage)
//    }


