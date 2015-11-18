//
//  FirstViewController.swift
//  breadCrumbs
//
//  Created by Ben Fallon on 11/17/15.
//  Copyright © 2015 Ben Fallon. All rights reserved.
//

import UIKit
import MapKit

class FirstViewController: UIViewController {

    //Create an outlet for the map -ben
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mapView.showsUserLocation = true

    }

    //Give function to the zoom button -ben
    @IBAction func zoomIn(sender: AnyObject) {
        let userLocation = mapView.userLocation
        
        let region = MKCoordinateRegionMakeWithDistance(
            userLocation.location!.coordinate, 2000,2000)
        
        mapView.setRegion(region, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

