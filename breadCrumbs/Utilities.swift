//
//  Utilities.swift
//  breadCrumbs
//
//  Created by Ben Fallon on 11/19/15.
//  Copyright © 2015 Ben Fallon, Jen Trudell, and Katelyn Dinkgrave. All rights reserved.
//

import UIKit
import MapKit

// MARK: Helper Functions

func showSimpleAlertWithTitle(title: String!, message: String, viewController: UIViewController) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    let action = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
    alert.addAction(action)
    viewController.presentViewController(alert, animated: true, completion: nil)
}

func createDummyCrumb(userLocation: CLLocationCoordinate2D, userEmail: String) -> RetrievedCrumb{
    let dummyCrumb = RetrievedCrumb(lat: userLocation.latitude, long: userLocation.longitude, identifier: "HELLO", title: "You haven't found any crumbs recently.", subtitle: "You haven't found any crumbs recently.", imageURL: "https://s3.amazonaws.com/breadcrumbs-assets/breadcrumbs/do-not-delete/littlebread.png", creatorEmail: userEmail)
    return dummyCrumb
}


//Used to download photo
extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = NSURL(string: urlString) {
            let request = NSURLRequest(URL: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
                (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                if let imageData = data as NSData? {
                    self.image = UIImage(data: imageData)
                }
            }
        }
    }
}

