//
//  crumb.swift
//  breadCrumbs
//
//  Created by Ben Fallon on 11/19/15.
//  Copyright © 2015 Ben Fallon, Jen Trudell, and Katelyn Dinkgrave. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import SwiftyJSON
import Alamofire

class Crumb: NSObject, MKAnnotation {
    var latitude: Double
    var longitude: Double
    var coordinate: CLLocationCoordinate2D
    var radius: CLLocationDistance
    var title: String?
    var subtitle: String?
    var identity: String?


    init(lat: Double, long: Double, identifier: String, title: String, subtitle: String){
        self.radius = 50 as CLLocationDistance
        self.latitude = lat;
        self.longitude = long;
        self.identity = identifier;
        self.title = title;
        self.subtitle = subtitle;
        self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
    }

    func saveToWeb(){
        var crumb : [String:Dictionary<String,NSObject>] = [
            "pseudocrumb": [
                "lat": self.latitude,
                "long": self.longitude,
                "identifier": self.identity!,
                "title": self.title!,
                "subtitle": self.subtitle!
            ]
        ]
        let newPseudocrumbUrl = "https://gentle-fortress-2146.herokuapp.com/pseudocrumbs"
        Alamofire.request(.POST, newPseudocrumbUrl, parameters: crumb)

    }



}
