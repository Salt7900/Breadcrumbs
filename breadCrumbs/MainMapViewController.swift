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
    
    func placepins(){
        let location:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 41.889, longitude: -87.637)
        
        var anotation = MKPointAnnotation()
        anotation.coordinate = location
        anotation.title = "DBC"
        anotation.subtitle = "HELLO TO YOUR WOLRLD, CODERS"
        mapView.addAnnotation(anotation)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Ben - Show current user location
        mapView.showsUserLocation = true
        //Ben - Update location when moving
        mapView.delegate = self
        placepins()
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

