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
        findLastCrumb()
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
        //Could still return empty - need better solution -BEN
        return everySingleCrumb.last!
    }

}
