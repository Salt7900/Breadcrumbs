//
//  UserModel.swift
//  breadCrumbs
//
//  Created by Jen Trudell on 11/21/15.
//  Copyright © 2015 Jen Trudell. All rights reserved.
//

import Foundation

import UIKit

class CrumbUser {
    let firstName: String
    let userAPI: String
    let email: String
    
    let emailKey = "email"
    let nameKey = "name"
    let apiKey = "apiKey"
    let loggedinKey = "loggedin"
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    init(firstName: String, userAPI: String, email: String) {
        self.firstName = firstName
        self.userAPI = userAPI
        self.email = email
    }
    
    func setUserDefaults() {
        defaults.setObject(self.email, forKey: emailKey)
        defaults.setObject(self.firstName, forKey: nameKey)
        defaults.setObject(self.userAPI, forKey: apiKey)
        defaults.setObject("yes", forKey: loggedinKey)
        print("\(self.email) logged in")
    }
    
    class func logOut() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject("no", forKey: "loggedin")
        defaults.setObject("no user", forKey: "email")
        defaults.setObject("no user", forKey: "name")
        defaults.setObject("no user", forKey: "apiKey")
    }
    
    
    class func retrieveLoginStatus() -> String {
        let defaults = NSUserDefaults.standardUserDefaults()
        let status = defaults.objectForKey("loggedin")
        
        if (status == nil || status === "no") {
            return "no"
        } else {
            return "yes"
        }
    }
    
}

