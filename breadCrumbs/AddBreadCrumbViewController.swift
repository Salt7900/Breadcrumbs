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


class SecondViewController: UIViewController, UINavigationControllerDelegate {
    
    //Add outlet to map -ben
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Show current location on map - Ben
        mapView.showsUserLocation = true
        
        var lgpr = UILongPressGestureRecognizer(target: self, action: "action:")
        lgpr.minimumPressDuration = 2.0;
        mapView.addGestureRecognizer(lgpr)

    }
    
    func action(gestureRecognizer:UIGestureRecognizer) {
        print("long press")
    }
    

    //Add zoom button functionality -ben
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
    
// access camera on button press and begin a camera session if a camera exists
    
    @IBOutlet var addPhotoButton: UIButton!
    let captureSession = AVCaptureSession()
    var captureDevice : AVCaptureDevice?
    
    @IBAction func addPhotoButtonPressed(sender: AnyObject) {
        captureSession.sessionPreset = AVCaptureSessionPresetLow
        
        let devices = AVCaptureDevice.devices()
        
        // go through each AV capture device and see if it is a camera
        // if it is, check to see if back camera and store as captureDevice
        for device in devices {
            if device.hasMediaType(AVMediaTypeVideo) {
                if device.position == AVCaptureDevicePosition.Back {
                    captureDevice = device as? AVCaptureDevice
                }
            }
        }
        
        if captureDevice != nil {
            beginCameraSession()
        }
    }
    
    func beginCameraSession() {
        captureSession.addInput(try! AVCaptureDeviceInput(device: captureDevice))
        var previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.view.layer.addSublayer(previewLayer)
        previewLayer?.frame = self.view.layer.frame
        captureSession.startRunning()
    }
    
// end camera code

}