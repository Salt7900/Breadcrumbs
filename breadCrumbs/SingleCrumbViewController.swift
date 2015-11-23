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


class SingleCrumbViewController: UIViewController {
    
    override func viewDidLoad() {
        var currentCrumb = findLastCrumb()
        setPageData(currentCrumb)
    }
    
    @IBOutlet weak var messagePicture: UIImageView!
    @IBOutlet weak var messageFrom: UILabel!
    @IBOutlet weak var messageField: UILabel!
    
    func findLastCrumb() -> RetrievedCrumb{
        var crumbIdentity = latestCrumb.last
        for savedItem in everySingleCrumb {
            if savedItem.identity == crumbIdentity {
                return savedItem
            }
        }
        var dummyCrumb = RetrievedCrumb(lat: 41.88790, long: -87.6375, identifier: "HELLO", title: "Your Message", subtitle: "Hello to your world, coders", imageURL: "https://pbs.twimg.com/profile_images/634740140003295234/bpnVhq8Z.jpg")
        return dummyCrumb
    }
    
    func setPageData(crumb: RetrievedCrumb){
        self.messageFrom.text = crumb.title
        self.messageField.text = crumb.subtitle
    }

}
