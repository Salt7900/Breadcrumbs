//
//  LoginViewController.swift
//  breadCrumbs
//
//  Created by Jen Trudell on 11/23/15.
//  Copyright © 2015 Ben Fallon. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import MapKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let center = CLLocationCoordinate2D(latitude: 41.887, longitude: -87.66)
        let region = MKCoordinateRegionMakeWithDistance(
            center, 10000, 10000)
        
        mapView.setRegion(region, animated: true)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // JEN login functions
    @IBAction func submitPressed(sender: AnyObject) {
        
        let enteredEmail = email.text!
        let enteredPassword = password.text!
        
        let loginDetails = [
            "email": enteredEmail,
            "password": enteredPassword
        ]

    
    // JEN AND KATELYN authenticate with ALamofire
    
    func authenticateUser(parameters:[String:String]) {
        
        let loginUrl = "https://gentle-fortress-2146.herokuapp.com/login"
        
        Alamofire.request(.POST, loginUrl, parameters: parameters).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(json)
                    
                    let apiKey : String = json["api_key"].stringValue
                    let first_name : String = json["first_name"].stringValue
                    
                    // set user and NSUserDefaults
                    let sessionUser = CrumbUser(firstName: first_name, userAPI: apiKey, email: enteredEmail)
                    sessionUser.setUserDefaults()
                    
                    //send logged in user to main tabbar controller
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let tabBarController = storyboard.instantiateViewControllerWithIdentifier("TabBarController") as! UITabBarController
                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    appDelegate.window?.rootViewController = tabBarController
                    
                }
            case .Failure(let error):
                print(error)
                NSUserDefaults.standardUserDefaults().setObject("no", forKey: "loggedin")
                //pop error message
                showSimpleAlertWithTitle("Login Failed", message: "Please try again", viewController: self)

            }
            
        }
        
    }
    
    authenticateUser(loginDetails)
        
    }

    //goes back to register view if not a member pressed
    @IBAction func goToRegister(sender: AnyObject) {
        self.performSegueWithIdentifier("goRegister", sender: self)
        
    }


}
