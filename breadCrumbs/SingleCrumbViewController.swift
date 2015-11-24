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
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {

    }
    
    override func viewDidAppear(animated: Bool) {
        var currentCrumb = findLastCrumb()
        setPageData(currentCrumb)
        setPagePhoto(currentCrumb)
        setMapArea(currentCrumb)
    }
    
    @IBOutlet weak var messagePicture: UIImageView!
    @IBOutlet weak var messageFrom: UILabel!
    @IBOutlet weak var messageField: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    //Find the correct crumb based on ID -BEN
    func findLastCrumb() -> RetrievedCrumb{
        
        let userLocation = mapView.userLocation.coordinate
        let userEmail = userDefaults.objectForKey("email") as! String

        var crumbIdentity = latestCrumb.last
        for savedItem in everySingleCrumb {
            if savedItem.identity == crumbIdentity {
                return savedItem
            }
        }
        
        var dummyCrumb = RetrievedCrumb(lat: userLocation.latitude, long: userLocation.longitude, identifier: "HELLO", title: "You haven't found any crumbs recently.", subtitle: "You haven't found any crumbs recently.", imageURL: "https://s3.amazonaws.com/breadcrumbs-assets/breadcrumbs/do-not-delete/littlebread.png", creatorEmail: userEmail)
        return dummyCrumb
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
            crumb.coordinate, 1500, 1500)
        
        mapView.setRegion(region, animated: true)
    }

}
