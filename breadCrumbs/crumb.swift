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
    var photo: UIImage?
    var creatorEmail: String?
    var recieverEmail: String
    var imageString: String?


        //JEN: add UIImage in inti to convert to string object when sent to server for paperclip/S3, and imageURL as setter property for setting S3 URL on crumb load from server
    init(lat: Double, long: Double, identifier: String, title: String, subtitle: String, photo: UIImage, creatorEmail: String, recieverEmail: String){
        self.radius = 50 as CLLocationDistance
        self.latitude = lat;
        self.longitude = long;
        self.identity = identifier;
        self.title = title;
        self.subtitle = subtitle;
        self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long);
        self.creatorEmail = creatorEmail;
        self.recieverEmail = recieverEmail;
        self.photo = photo;


        //JEN: converts UIImage to NSData, then to 64-bit encoded string
        let imageData: NSData = UIImagePNGRepresentation(self.photo!)!
        self.imageString = imageData.base64EncodedStringWithOptions(.EncodingEndLineWithLineFeed)

    }

    func saveToWeb(){
        let crumb : [String:Dictionary<String,NSObject>] = [
            "breadcrumb": [
                "lat": self.latitude,
                "long": self.longitude,
                "identifier": self.identity!,
                "title": self.title!,
                "subtitle": self.subtitle!,
                "creatorEmail": self.creatorEmail!,
                "recieverEmail": self.recieverEmail,
                "image_data": self.imageString!
            ]
        ]
        let newCrumbUrl = "https://gentle-fortress-2146.herokuapp.com/breadcrumbs"
        Alamofire.request(.POST, newCrumbUrl, parameters: crumb)

    }

}

//JEN for pulling crumbs from server with different init values re photo, will make subclass of Crumb in refactor

class RetrievedCrumb: NSObject, MKAnnotation {
    var latitude: Double
    var longitude: Double
    var coordinate: CLLocationCoordinate2D
    var radius: CLLocationDistance
    var title: String?
    var subtitle: String?
    var identity: String?
    var imageURL: String?


    //JEN: add UIImage in init to convert to string object when sent to server for paperclip/S3, and imageURL as setter property for setting S3 URL on crumb load from server
    init(lat: Double, long: Double, identifier: String, title: String, subtitle: String, imageURL: String){
        self.radius = 50 as CLLocationDistance;
        self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long);
        self.latitude = lat;
        self.longitude = long;
        self.identity = identifier;
        self.title = title;
        self.subtitle = subtitle;
        self.imageURL = imageURL;
    }
}
