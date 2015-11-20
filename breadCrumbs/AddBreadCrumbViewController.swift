//
//  SecondViewController.swift
//  breadCrumbs
//
//  Created by Ben Fallon on 11/17/15.
//  Copyright © 2015 Ben Fallon. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVFoundation
import MapKit


class SecondViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    
    //Jen allow save message
    @IBOutlet weak var enterMessageField: UITextField!
    
    @IBAction func userMessage(sender: UITextField) {
        
    }

    
    //Ben allow to iteract with map
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var eventTypeSegmentedControl: UISegmentedControl!
    
    //JEN CAMERA LINKS TO VIEW
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var currentImage: UIImageView!
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    //END JEN LINKS TO VIEW
    
    //Ben - Save all info into a new crumb object
    @IBAction func saveCrumb(sender: AnyObject) {
        var crumb = Crumb(coordinate: mapView.centerCoordinate, radius: 50 as CLLocationDistance, note: enterMessageField.text!, message: "HELLO")
        
        Main().addCrumb(crumb)
        self.performSegueWithIdentifier("backToMainMap", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
            // sets controller as the camera delegate
        imagePicker.delegate = self
        
        //Ben - dealing with map and user location
        mapView.showsUserLocation = true
    }
    
    //BEN Zoom in functionality
    @IBAction func zoomIn(sender: AnyObject) {
        let userLocation = mapView.userLocation
        
        let region = MKCoordinateRegionMakeWithDistance(
            userLocation.location!.coordinate, 2000, 2000)
        
        mapView.setRegion(region, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
// BEGIN JEN ALL NEW CAMERA CODE SHOUTOUT TO deege on Github
    
    //function for alerting users to errors
    func postAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message,
            preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    //function to check for cameras and if the exist open camera when photobutton pressed
    @IBAction func takePicture(sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(.Camera)) {
            if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
                imagePicker.allowsEditing = false
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
    
    //function to deal with images once you have one
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print("Got an image")
        
        func displayImage(pickedImage: UIImage) {
            imagePicker.dismissViewControllerAnimated(true, completion: {
                self.currentImage.image = pickedImage
            })
        }

        if let pickedImage: UIImage = (info[UIImagePickerControllerOriginalImage]) as? UIImage {
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
                self.currentImage.image = image
                self.photoButton.setTitle("Change Photo", forState: .Normal)
                })
            }
        }
    }
    
// END JEN ALL NEW CAMERA CODE
    
    
    //DELETE ME..?
//    @IBAction func onAdd(sender: AnyObject) {
//        var crumb = Crumb(coordinate: mapView.centerCoordinate, radius: 50 as CLLocationDistance, note: enterMessageField.text!, message: "HELLO")
//        
//        Main().addCrumb(crumb)
//    }
//    
    

}