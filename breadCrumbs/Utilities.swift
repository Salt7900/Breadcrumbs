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


//Used to fetch image Asynchronously BEN
//func downloadImage(url: NSURL){
//    print("Started downloading \"\(url.URLByDeletingPathExtension!.lastPathComponent!)\".")
//    getDataFromUrl(url) { (data, response, error)  in
//        dispatch_async(dispatch_get_main_queue()) { () -> Void in
//            guard let data = data where error == nil else { return }
//            print("Finished downloading \"\(url.URLByDeletingPathExtension!.lastPathComponent!)\".")
//            imageURL.image = UIImage(data: data)
//        }
//    }
//}
//
//func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
//    NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
//        completion(data: data, response: response, error: error)
//        }.resume()
//}
