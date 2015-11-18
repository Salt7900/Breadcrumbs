//
//  Geotag.swift
//  breadCrumbs
//
//  Created by Ben Fallon on 11/18/15.
//  Copyright © 2015 Ben Fallon. All rights reserved.
//

import UIKit
import MapKit

import CoreLocation

let kGeotagLatitudeKey = "latitude"
let kGeotagLongitudeKey = "longitude"
let kGeotagRadiusKey = "radius"
let kGeotagIdentifierKey = "identifier"
let kGeotagNoteKey = "note"
let kGeotagEventTypeKey = "eventType"

enum EventType: Int{
    case onEntry = 0
    case onExit
}

class Geotag: NSObject, NSCoding, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var radius: CLLocationDistance
    var identifier: String
    var note: String
    var eventType: EventType
    
    var title: String?{
        if note.isEmpty{
            return "No Note"
        }
        return note
    }
    
    var subtitle: String?{
        let eventTypeString = EventType == .OnEntry ? "On Entry" : "On Exit"
        return "Radius: \(radius)m - \(eventTypeString)"
    }
    
    init(coordinate: CLLocationCoordinate2D, radius: CLLocationDistance, identifier: String, note: String, eventType: EventType){
        self.coordinate = coordinate
        self.radius = radius
        self.identifier = identifier
        self.note = note
        self.eventType = eventType
    }
    
    //BEN -- NSCoding
    
    required init?(coder decoder: NSCoder){
        let latitude = decoder.decodeDoubleForKey(kGeotagLatitudeKey)
        let longitude = decoder.decodeDoubleForKey(kGeotagLongitudeKey)
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        radius = decoder.decodeDoubleForKey(kGeotagRadiusKey)
        identifier = decoder.decodeObjectForKey(kGeotagIdentifierKey) as! String
        note = decoder.decodeObjectForKey(kGeotagNoteKey) as! String
        eventType = EventType(rawValue: decoder.decodeIntegerForKey(kGeotificationEventTypeKey))!
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeDouble(coordinate.latitude, forKey: kGeotagLatitudeKey)
        coder.encodeDouble(coordinate.longitude, forKey: kGeotagLongitudeKey)
        coder.encodeDouble(radius, forKey: kGeotagRadiusKey)
        coder.encodeObject(identifier, forKey: kGeotagIdentifierKey)
        coder.encodeObject(note, forKey: kGeotagNoteKey)
        coder.encodeInt(Int32(eventType.rawValue), forKey: kGeotagEventTypeKey)
    }

}
