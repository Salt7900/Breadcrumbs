//
//  NavigationViewController.swift
//  breadCrumbs
//
//  Created by Jen Trudell on 11/23/15.
//  Copyright © 2015 Ben Fallon. All rights reserved.
//

import UIKit

class NavigationViewController: UIViewController {
    
    let userDefaults = NSUserDefaults.standardUserDefaults()

    

    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let loggedIn = userDefaults.valueForKey("loggedin") as? String
        
        if (loggedIn == "no" || loggedIn == nil) {
            self.performSegueWithIdentifier("goLogin", sender: self)
        } else if loggedIn == "yes" {
            self.dismissViewControllerAnimated(true, completion: nil)
        } else {
            self.performSegueWithIdentifier("goLogin", sender: self)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
