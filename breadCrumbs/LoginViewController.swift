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

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
                    let user = JSON(value)
                    print(user)
                    
                    // set NSUserDefaults
//                    let sessionUser = CrumbUser(firstName: "jane", lastName: "smith", email: sentUsername)
//                    sessionUser.setUserDefaults()
                    
                    //send them to main map
                    
                }
            case .Failure(let error):
                print(error)
                NSUserDefaults.standardUserDefaults().setObject("no", forKey: "loggedin")
                
                //pop error message
            }
            
        }
        
    }
    
    authenticateUser(loginDetails)
        
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
