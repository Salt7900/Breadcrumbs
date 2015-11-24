//
//  SettingsViewController.swift
//  breadCrumbs
//
//  Created by Ben Fallon on 11/23/15.
//  Copyright © 2015 Ben Fallon, Katelyn Dinkgrave and Jen Trudell. All rights reserved.
//

import UIKit

let userDefaults = NSUserDefaults.standardUserDefaults()

class SettingsViewController: UIViewController {
    
//JEN label top of view with email of user
    
    @IBOutlet weak var userEmailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set label to user email
        let userEmail = userDefaults.objectForKey("email") as! String
        userEmailLabel.text = "Hey there, \(userEmail)"
    }
    
// JEN attach logout button, send back to login screen on logout

    @IBAction func logoutPressed(sender: AnyObject) {
        CrumbUser.logOut()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyboard.instantiateViewControllerWithIdentifier("LoginVC") as! LoginViewController
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController = loginVC

    }
}
