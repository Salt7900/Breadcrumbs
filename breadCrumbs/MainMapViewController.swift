//
//  FirstViewController.swift
//  breadCrumbs
//
//  Created by Ben Fallon on 11/17/15.
//  Copyright © 2015 Ben Fallon. All rights reserved.
//

import UIKit
import MapKit

class FirstViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    func placePins(){
       // var locations: [AnyObject] = []
        
        let location:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 41.889, longitude: -87.637)
        
        let mapAnno = Crumb(coordinate: location, radius: 50, note: "DBC", message: "Hello to your world coders")
        
        let mapPoint = Crumb(coordinate: CLLocationCoordinate2D(latitude: 42.889, longitude: -87.637), radius: 50, note: "Not DBC", message: "Hello to your world coders")
////
//        var anotation = MKPointAnnotation()
////        anotation.coordinate = mapAnno.coordinate
////        anotation.title = mapAnno.note
////        anotation.subtitle = mapAnno.message
        mapView.addAnnotation(mapPoint)
        mapView.addAnnotation(mapAnno)
        addRadiusCircle(mapAnno.coordinate)
        addRadiusCircle(mapPoint.coordinate)
    
        
//        if let data = NSUserDefaults.standardUserDefaults().objectForKey("allCrumbs") as? NSData {
//            let things = NSKeyedUnarchiver.unarchiveObjectWithData(data)
//            if things is NSArray{
//                for var thing in things{
//                    if things is Crumb {
//                        print(thing!.subtitle)
//                        print(thing)
//                }
//                }
//            }
//        }

//
    }
    
    func addCrumbs(crumb: Crumb){
        mapView.addAnnotation(crumb)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Ben - Show current user location
        mapView.showsUserLocation = true
        locationManager.requestAlwaysAuthorization()
        //Ben - Update location when moving
        //mapView.delegate = self
        placePins()

    }
    
    func addRadiusCircle(location: CLLocationCoordinate2D){
        mapView.delegate = self
        var circle = MKCircle(centerCoordinate: location, radius: 50 as CLLocationDistance)
        self.mapView.addOverlay(circle)
    }
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer!{
        if overlay is MKCircle{
            var circle = MKCircleRenderer(overlay: overlay)
            circle.strokeColor = UIColor.purpleColor()
            circle.fillColor = UIColor(red: 0, green: 150, blue: 255, alpha: 0.1)
            circle.lineWidth = 1
            return circle
        }else{
            return nil
        }
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

