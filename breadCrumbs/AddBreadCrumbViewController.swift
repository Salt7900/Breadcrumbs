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


class SecondViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //JEN CAMERA LINKS TO VIEW
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var currentImage: UIImageView!
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    //END JEN LINKS TO VIEW
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
            // sets controller as the camera delegate
        imagePicker.delegate = self

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
        if let pickedImage: UIImage = (info[UIImagePickerControllerOriginalImage]) as? UIImage {
            //let selectorToCall = Selector("imageWasSavedSuccessfully:didFinishSavingWithError:conetext:")
            UIImageWriteToSavedPhotosAlbum(pickedImage, nil, nil, nil)
        }
        imagePicker.dismissViewControllerAnimated(true, completion: {
            //whatever we want to do when user saves image
            })
        
        func imagePickerControllerDidCancel(picker: UIImagePickerController) {
            print("User canceled image")
            dismissViewControllerAnimated(true, completion: {
                // Anything you want to happen when the user selects cancel
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
                })
            }
        }
    }
    
// END JEN ALL NEW CAMERA CODE
    

}