//
//  SingleCrumbViewController.swift
//  breadCrumbs
//
//  Created by Ben Fallon on 11/22/15.
//  Copyright © 2015 Ben Fallon. All rights reserved.
//

import UIKit
import MobileCoreServices
import MapKit
import CoreLocation


class SingleCrumbViewController: UIViewController {
    
    let userEmail = NSUserDefaults.standardUserDefaults().objectForKey("email") as! String
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var messagePicture: UIImageView!
    @IBOutlet weak var messageFrom: UILabel!
    @IBOutlet weak var messageField: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        mapView.showsUserLocation = true
    }
    
    override func viewDidAppear(animated: Bool) {
        var currentCrumb = findLastCrumb()
        setPageData(currentCrumb)
        setPagePhoto(currentCrumb)
        setMapArea(currentCrumb)
    }
    
    //Find the correct crumb based on ID -BEN
    func findLastCrumb() -> RetrievedCrumb{
        
        let userLocation = mapView.userLocation.coordinate
        
        var crumbIdentity = latestCrumb.last
        for savedItem in everySingleCrumb {
            if savedItem.identity == crumbIdentity {
                return savedItem
            }
        }

        return createDummyCrumb(userLocation, userEmail: userEmail)
    }
    
    //Set Page text from crumb object - BEN
    func setPageData(crumb: RetrievedCrumb){
        self.messageFrom.text = "breadCrumb sent by \(crumb.creatorEmail)"
        self.messageField.text = crumb.subtitle
    }
    
    //Retirive and display photo - BEN
    func setPagePhoto(crumb: RetrievedCrumb){
        messagePicture.imageFromUrl(crumb.imageURL!)
    
    }
    
    func setMapArea(crumb: RetrievedCrumb){
        let region = MKCoordinateRegionMakeWithDistance(
            crumb.coordinate, 1000, 1000)
        
        mapView.setRegion(region, animated: true)
    }

}
