//
//  SecondViewController.swift
//  breadCrumbs
//
//  Created by Ben Fallon on 11/17/15.
//  Copyright © 2015 Ben Fallon, Jen Trudell, and Katelyn Dinkgrave. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVFoundation
import MapKit


class SecondViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let userDefaults = NSUserDefaults.standardUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        mapView.showsUserLocation = true
        
    }
    
    //Jen dismiss keyboard when touch outside keyboard
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    

    //Jen allow save message
    @IBOutlet weak var enterMessageField: UITextField!
    @IBOutlet weak var enterRecipientEmail: UITextField!
    


    //Ben allow to interact with map
    @IBOutlet weak var mapView: MKMapView!

    //JEN CAMERA LINKS TO VIEW
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var currentImage: UIImageView!
    @IBOutlet weak var cameraRollButton: UIButton!

    let imagePicker: UIImagePickerController! = UIImagePickerController()

    //Ben - Save all info into a new crumb object
    @IBAction func saveCrumb(sender: AnyObject) {
        let pinLocation = mapView.centerCoordinate
        let userEmail = userDefaults.objectForKey("email") as! String


        let crumb = Crumb(lat: pinLocation.latitude, long: pinLocation.longitude, identifier: NSUUID().UUIDString, title: "You've got a breadCrumb!", subtitle: enterMessageField.text!, photo: self.currentImage.image!, creatorEmail: userEmail, receiverEmail: enterRecipientEmail.text!)
        
        crumb.saveToWeb()
        
        //JEN -- send user to main tabbar controller after save
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyboard.instantiateViewControllerWithIdentifier("TabBarController") as! UITabBarController
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController = tabBarController
    }


    //BEN Zoom in functionality
    @IBAction func zoomIn(sender: AnyObject) {
        let userLocation = mapView.userLocation

        let region = MKCoordinateRegionMakeWithDistance(
            userLocation.location!.coordinate, 2000, 2000)

        mapView.setRegion(region, animated: true)
    }

// BEGIN JEN ALL NEW CAMERA CODE SHOUTOUT TO deege on Github

    //function for alerting users to errors
    func postAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message,
            preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    //function to check for cameras and if they exist open camera when add photo pressed
    @IBAction func takePicture(sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(.Camera)) {
            if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
                imagePicker.allowsEditing = true
                imagePicker.sourceType = .Camera
                imagePicker.cameraCaptureMode = .Photo
                presentViewController(imagePicker, animated: true, completion: {})
            } else {
                postAlert("Rear camera not available", message: "breadCrumbs cannot access the camera")
            }
        } else {
            postAlert("Camera not available", message: "breadCrumbs cannot access the camera")
        }
    }
    
    // access camera roll when button pressed

    @IBAction func openCameralRoll(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .PhotoLibrary
            presentViewController(imagePicker, animated: true, completion: {})
        } else {
            postAlert("Photo Library not available", message: "breadCrumbs cannot access your photo library")
        }
    }

    //function to deal with images once you have one
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print("Got an image")

        func displayImage(pickedImage: UIImage) {
            imagePicker.dismissViewControllerAnimated(true, completion: {
                self.currentImage.image = pickedImage
            })
        }

        if let pickedImage: UIImage = (info[UIImagePickerControllerEditedImage]) as? UIImage {
            //saves image to user's camera roll
            UIImageWriteToSavedPhotosAlbum(pickedImage, nil, nil, nil)
            displayImage(pickedImage)
        }


        func imagePickerControllerDidCancel(picker: UIImagePickerController) {
            print("User canceled image")
            dismissViewControllerAnimated(true, completion: {
            })
        }

        func imageWasSavedSuccessfully(image: UIImage, didFinishSavingWithError error: NSError!, context: UnsafeMutablePointer<()>){
            print("Image saved")
            if let theError = error {
                print("An error happened while saving the image = \(theError)")
            } else {
                print("Displaying")
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                let rotatedImage = fixImageOrientation(image)
                    
                self.currentImage.image = rotatedImage
                self.photoButton.setTitle("Change Photo", forState: .Normal)
                })
            }
        }
    }

// END JEN ALL NEW CAMERA CODE


}
