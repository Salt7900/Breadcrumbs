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
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
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
