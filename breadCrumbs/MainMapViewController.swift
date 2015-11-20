//
//  FirstViewController.swift
//  breadCrumbs
//
//  Created by Ben Fallon on 11/17/15.
//  Copyright © 2015 Ben Fallon. All rights reserved.
//

import UIKit
import MapKit

import CoreLocation

class FirstViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.showsUserLocation = true
        locationManager.requestAlwaysAuthorization()
        runner()
        
    }
    
    func runner(){
        let location:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 41.889, longitude: -87.637)
        let mapAnno = Crumb(coordinate: location, radius: 50, note: "DBC", message: "Hello to your world coders")
        let mapPoint = Crumb(coordinate: CLLocationCoordinate2D(latitude: 42.889, longitude: -87.637), radius: 50, note: "Not DBC", message: "Hello to your world coders")
        let testingPoint = Crumb(coordinate: CLLocationCoordinate2D(latitude: 37.334, longitude: -122.0387), radius: 500, note: "Not DBC", message: "Hello to your world coders")
        
        addCrumbs(mapAnno)
        addCrumbs(mapPoint)
        addCrumbs(testingPoint)
        
    }
    
    func placePins(){

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
        //addRadiusCircle(crumb)
        regionWithCrumb(crumb)
        addRadiusCircle(crumb)
        startMonitoringCrumb(crumb)
        
    }

    
    func regionWithCrumb(crumb: Crumb) -> CLCircularRegion {
        let region = CLCircularRegion(center: crumb.coordinate, radius: 50 as CLLocationDistance, identifier: crumb.identity)
        region.notifyOnEntry = ( true )
        return region
    }
    
    func startMonitoringCrumb(crumb: Crumb) {
        if !CLLocationManager.isMonitoringAvailableForClass(CLCircularRegion) {
            showSimpleAlertWithTitle("Error", message: "Geofencing is not supported on this device!", viewController: self)
            return
        }
        // 2
        if CLLocationManager.authorizationStatus() != .AuthorizedAlways {
            showSimpleAlertWithTitle("Warning", message: "Your geotification is saved but will only be activated once you grant Geotify permission to access the device location.", viewController: self)
        }
        let region = regionWithCrumb(crumb)
        locationManager.startMonitoringForRegion(region)
    }
    
    func stopMonitoringGeolocation(crumb: Crumb){
        for region in locationManager.monitoredRegions{
            if let circularRegion = region as? CLCircularRegion {
                if circularRegion.identifier == crumb.identity{
                    locationManager.stopMonitoringForRegion(circularRegion)
                }
            }
        }
    }
    
    func addRadiusCircle(crumb: Crumb){
        //Draws circle on the map
        var circle = MKCircle(centerCoordinate: crumb.coordinate, radius: 50 as CLLocationDistance)
        self.mapView.addOverlay(circle)
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        var crumb = view.annotation as? Crumb
        stopMonitoringGeolocation(crumb!)
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
    
    func locationManager(manager: CLLocationManager!, monitoringDidFailForRegion region: CLRegion!, withError error: NSError!) {
        print("Monitoring failed for region with identifier: \(region.identifier)")
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        print("Location Manager failed with the following error: \(error)")
    }

}

