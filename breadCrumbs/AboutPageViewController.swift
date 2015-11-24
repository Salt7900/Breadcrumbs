//
//  AboutPageViewController.swift
//  breadCrumbs
//
//  Created by Ben Fallon on 11/23/15.
//  Copyright © 2015 Ben Fallon. All rights reserved.
//

import UIKit

class AboutPageViewController: UIViewController {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toSettings" {
            let destinationViewController = segue.destinationViewController as! SettingsViewController;
            // setup the destination controller
        }
    }


}
