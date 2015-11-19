//
//  FirstViewController.swift
//  breadCrumbs
//
//  Created by Ben Fallon on 11/17/15.
//  Copyright © 2015 Ben Fallon. All rights reserved.
//

import UIKit
import MapKit

class FirstViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    func placePins(){
        var locations: [AnyObject] = []
        
        let location:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 41.889, longitude: -87.637)
        
        let mapAnno = Crumb(coordinate: location, radius: 50, note: "DBC", message: "Hello to your world coders")
        
        let mapPoint = Crumb(coordinate: CLLocationCoordinate2D(latitude: 42.889, longitude: -87.637), radius: 50, note: "Not DBC", message: "Hello to your world coders")
        
        locations += [mapAnno]
        locations += [mapPoint]
        
//        var anotation = MKPointAnnotation()
//        anotation.coordinate = mapAnno.coordinate
//        anotation.title = mapAnno.note
//        anotation.subtitle = mapAnno.message
       mapView.addAnnotation(mapAnno)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Ben - Show current user location
        mapView.showsUserLocation = true
        //Ben - Update location when moving
        mapView.delegate = self
        placePins()

    }

    //BEN Zoom in functionality
    @IBAction func zoomIn(sender: AnyObject) {
        let userLocation = mapView.userLocation
        let region = MKCoordinateRegionMakeWithDistance(
            userLocation.location!.coordinate, 2000, 2000)
        
        mapView.setRegion(region, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Ben- Allow map to track location
    func mapView(mapView: MKMapView!, didUpdateUserLocation
        userLocation: MKUserLocation!){
            mapView.centerCoordinate = userLocation.location!.coordinate
    }

}

