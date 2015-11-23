//
//  RegistrationViewController.swift
//  breadCrumbs
//
//  Created by Jen Trudell on 11/23/15.
//  Copyright © 2015 Ben Fallon. All rights reserved.
//

import UIKit
import  SwiftyJSON
import Alamofire

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //JEN AND KATELYN new user registration
    
    @IBAction func submitPressed(sender: AnyObject) {
        let enteredFirstName = firstName.text
        let enteredLastName = lastName.text
        let enteredEmail = email.text
        let enteredPassword = password.text
        let enteredConfirmPassword = confirmPassword.text
        
        if enteredPassword != enteredConfirmPassword {
            //pop error alert
        } else {
            
            let registrationDetails : [String: Dictionary<String,String>] = [
                "user": [
                    "first_name": enteredFirstName!,
                    "last_name": enteredLastName!,
                    "email": enteredEmail!,
                    "password": enteredPassword!
                ]
            ]
            
            //register using Alamofire
            
            func registerNewUser(parameters:[String:Dictionary<String,String>]) {
                let newUserUrl = "https://gentle-fortress-2146.herokuapp.com/users"
                Alamofire.request(.POST, newUserUrl, parameters: parameters)
            }
            
            registerNewUser(registrationDetails)
            
            // if fails pop up an error
            // else go to login view
            self.dismissViewControllerAnimated(true, completion: nil)
            
            print("got here")
        }
        
    }
    
    //goes back to login view if already a member pressed
    @IBAction func gotToLogin(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)

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
