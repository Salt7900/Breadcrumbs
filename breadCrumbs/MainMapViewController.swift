//
//  FirstViewController.swift
//  breadCrumbs
//
//  Created by Ben Fallon on 11/17/15.
//  Copyright © 2015 Ben Fallon, Jen Trudell, and Katelyn Dinkgrave. All rights reserved.
//

import UIKit
import MapKit
import SwiftyJSON
import Alamofire
import CoreLocation

var everySingleCrumb = [RetrievedCrumb]()
var newCrumbs = [Crumb]()
var latestCrumb = [RetrievedCrumb]()

class FirstViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    @IBOutlet weak var mapView: MKMapView!

    let locationManager = CLLocationManager()
    

    //Pull user geolocations and crumbs before view loads - BEN and JEN
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        mapView.showsUserLocation = true
        locationManager.requestAlwaysAuthorization()
        everySingleCrumb = [RetrievedCrumb]()
        pullCrumbs("crazy@email.com")
    }

    override func viewDidAppear(animated: Bool) {
        stopMonitoringAll()
        if newCrumbs.count != 0{
            convertCrumbToRetrivedCrumb(newCrumbs[0])
        }
    }

    //Pull and parse JSON for locations - BEN (and then Jen and Katelyn for image URL)
    func pullCrumbs(email: String){
        everySingleCrumb = [RetrievedCrumb]()
        var counter = 0
        let getCrumbUrl = "https://gentle-fortress-2146.herokuapp.com/fetch"
        Alamofire.request(.GET, getCrumbUrl, parameters:["receiverEmail": email]).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                        for _ in json{
                            let crumb: Dictionary<String,JSON> = json[counter].dictionaryValue
                            let lat : Double = crumb["lat"]!.doubleValue
                            let long : Double = crumb["long"]!.doubleValue
                            let identifier : String = crumb["identifier"]!.stringValue
                            let title : String = crumb["title"]!.stringValue
                            let subtitle : String = crumb["subtitle"]!.stringValue
                            let imageURL : String = crumb["photo_aws_url"]!.stringValue
                            let retrievedCrumb = RetrievedCrumb(lat: lat, long: long, identifier: identifier, title: title, subtitle: subtitle, imageURL: imageURL)
                            counter += 1
                            
                            self.addCrumbs(retrievedCrumb)
                            everySingleCrumb.append(retrievedCrumb)
                    }
                }
            case .Failure(let error):

                (error)
            }
        }
    }
    
    func convertCrumbToRetrivedCrumb(crumb: Crumb){
       let newCrumb = RetrievedCrumb(lat: crumb.latitude, long: crumb.longitude, identifier: crumb.identity!, title: crumb.title!, subtitle: crumb.subtitle!, imageURL: crumb.imageString!)
        
        self.addCrumbs(newCrumb)
        everySingleCrumb.append(newCrumb)
    }

    //Draw pins on map BEN
    func addCrumbs(crumb: RetrievedCrumb){
        self.mapView.addAnnotation(crumb)
        addRadiusCircle(crumb)
        startMonitoringCrumb(crumb)
    }


    //Create circular regions for monitoring BEN
    func regionWithCrumb(crumb: RetrievedCrumb) -> CLCircularRegion {
        let region = CLCircularRegion(center: crumb.coordinate, radius: crumb.radius, identifier: crumb.identity!)
        region.notifyOnEntry = ( true )
        region.notifyOnExit = ( false )
        return region
    }

    //Start to monitor the region BEN
    func startMonitoringCrumb(crumb: RetrievedCrumb) {
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

    func stopMonitoringGeolocation(crumb: RetrievedCrumb){
        for region in locationManager.monitoredRegions{
            if let circularRegion = region as? CLCircularRegion {
                if circularRegion.identifier == crumb.identity{
                    locationManager.stopMonitoringForRegion(circularRegion)
                }
            }
        }
    }

    func addRadiusCircle(crumb: RetrievedCrumb){
        //Draws circle on the map
        let circle = MKCircle(centerCoordinate: crumb.coordinate, radius: crumb.radius)
        self.mapView.addOverlay(circle)
    }

//    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
//        var crumb = view.annotation as? Crumb
//        stopMonitoringGeolocation(crumb!)
//    }

    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer!{
        if overlay is MKCircle{
            let circle = MKCircleRenderer(overlay: overlay)
            circle.strokeColor = UIColor.purpleColor()
            circle.fillColor = UIColor(red: 0, green: 150, blue: 255, alpha: 0.1)
            circle.lineWidth = 1
            return circle
        }else{
            return nil
        }
    }

    func stopMonitoringAll(){
        for region in locationManager.monitoredRegions{
            locationManager.stopMonitoringForRegion(region)
        }
    }

    //BEN Zoom in functionality
    @IBAction func zoomIn(sender: AnyObject) {
        let userLocation = mapView.userLocation
        let region = MKCoordinateRegionMakeWithDistance(
            userLocation.location!.coordinate, 2000, 2000)

        mapView.setRegion(region, animated: true)
    }
    
    //Allow the annotations to display the delete button
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView! {
        let identifier = "myCrumb"
        if annotation is RetrievedCrumb {
            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                let removeButton = UIButton(type: .Custom)
                removeButton.frame = CGRect(x: 0, y: 0, width: 23, height: 23)
                removeButton.setImage(UIImage(named: "DeleteCrumb")!, forState: .Normal)
                annotationView?.leftCalloutAccessoryView = removeButton
            } else {
                annotationView?.annotation = annotation
            }
            return annotationView
        }
        return nil
    }


    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        // Delete geotification
        let crumb = view.annotation as! RetrievedCrumb
        removeCrumb(crumb)
    }
    
    func removeCrumb(crumb: RetrievedCrumb) {
        if let indexInArray = everySingleCrumb.indexOf(crumb) {
            everySingleCrumb.removeAtIndex(indexInArray)
        }
        
        mapView.removeAnnotation(crumb)
        stopMonitoringGeolocation(crumb)
        removeRadiusOverlayForGeotification(crumb)
        removeCrumbFromDatabase(crumb.identity)
    }
    
    func removeCrumbFromDatabase(crumbID: String!){
        let deleteCrumbURL = "https://gentle-fortress-2146.herokuapp.com/breadcrumbs/\(crumbID)"
        Alamofire.request(.DELETE, deleteCrumbURL)
    }
    
    //When deleteed, remove the radius -BEN
    func removeRadiusOverlayForGeotification(crumb: RetrievedCrumb) {
        // Find exactly one overlay which has the same coordinates & radius to remove
        if let overlays = mapView?.overlays {
            for overlay in overlays {
                if let circleOverlay = overlay as? MKCircle {
                    let coord = circleOverlay.coordinate
                    if coord.latitude == crumb.coordinate.latitude && coord.longitude == crumb.coordinate.longitude && circleOverlay.radius == crumb.radius {
                        mapView?.removeOverlay(circleOverlay)
                        break
                    }
                }
            }
        }
    }

    //Ben- Allow map to track location
    func mapView(mapView: MKMapView!, didUpdateUserLocation
        userLocation: MKUserLocation!){
            mapView.centerCoordinate = userLocation.location!.coordinate
    }


}
