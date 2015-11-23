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

    }
    
    override func viewDidAppear(animated: Bool) {
        var currentCrumb = findLastCrumb()
        setPageData(currentCrumb)
        setPagePhoto(currentCrumb)
    }
    
    @IBOutlet weak var messagePicture: UIImageView!
    @IBOutlet weak var messageFrom: UILabel!
    @IBOutlet weak var messageField: UILabel!
    
    
    //Find the correct crumb based on ID -BEN
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
    
    //Set Page text from crumb object - BEN
    func setPageData(crumb: RetrievedCrumb){
        self.messageFrom.text = crumb.title
        self.messageField.text = crumb.subtitle
    }
    
    //Retirive and display photo - BEN
    func setPagePhoto(crumb: RetrievedCrumb){
        ImageLoader.sharedLoader.imageForUrl(crumb.imageURL, completionHandler:{(image: UIImage?, url: String) in
            self.messagePicture.image = image!
        })
    }

}
