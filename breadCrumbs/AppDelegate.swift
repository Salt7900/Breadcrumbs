//
//  AppDelegate.swift
//  breadCrumbs
//
//  Created by Ben Fallon on 11/17/15.
//  Copyright © 2015 Ben Fallon, Jen Trudell, and Katelyn Dinkgrave. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate{
var window: UIWindow?

let locationManager = CLLocationManager()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //BEN Status bar defaults to white
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)

        //JEN if no one has logged ininsert login view before tabbed view main controller by creating new storyboard object and assigning it to LoginVC
        
        if CrumbUser.retrieveLoginStatus() == "no" {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = storyboard.instantiateViewControllerWithIdentifier("LoginVC") as! LoginViewController
            self.window?.rootViewController = loginVC
        }
        
        //BEN map and notifications
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()

        if(UIApplication.instancesRespondToSelector(Selector("registerUserNotificationSettings:"))) {
            UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Alert, .Sound, .Badge], categories: nil))
        }
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        
        let notification = launchOptions?[UIApplicationLaunchOptionsLocalNotificationKey] as! UILocalNotification!
        if (notification != nil) {
            print("Hello, this should be from a notificiation")
        }

        return true
    }


    //BEN - Allow notifications when a geofence has been crossed
    func handleRegionEvent(region: CLRegion!){
        if UIApplication.sharedApplication().applicationState == .Active {
            if let message = notefromRegionIdentifier(region.identifier) {
                if let viewController = window?.rootViewController {
                    showSimpleAlertWithTitle(nil, message: message, viewController: viewController)
                }
            }
        } else {
            // Otherwise present a local notification
            let notification = UILocalNotification()
            notification.alertBody = notefromRegionIdentifier(region.identifier)
            notification.soundName = "Default";
            UIApplication.sharedApplication().presentLocalNotificationNow(notification)
        }
    }

    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        handleRegionEvent(region)
    }

    func notefromRegionIdentifier(identifier: String) -> String? {
            for savedItem in everySingleCrumb {
                    if savedItem.identity == identifier {
                        latestCrumb.append(savedItem.identity!)
                        return savedItem.subtitle
                    }
            }
        return "You have a notification"
    }


}
