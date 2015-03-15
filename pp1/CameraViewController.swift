//
//  CameraViewController.swift
//  pp1
//
//  Created by Can A. MOGOL on 14/03/15.
//  Copyright (c) 2015 acm. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import AVFoundation
import UIKit
import GLKit



class CameraViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    @IBOutlet var videoPreviewView: UIView!
    private var currentCameraDevice:AVCaptureDevice?
    private var backCameraDevice:AVCaptureDevice?
    private var frontCameraDevice:AVCaptureDevice?
	private var stillCameraOutput:AVCaptureStillImageOutput!
    private var videoOutput:AVCaptureVideoDataOutput!

    private var session:AVCaptureSession!
    private var previewLayer:AVCaptureVideoPreviewLayer!
    
    
    func showAccessDeniedMessage(){
        let alert = UIAlertView()
        alert.title = "Camera Access"
        alert.message = "Access to camera denied, will not capture is not available"
        alert.addButtonWithTitle("Ok")
        alert.show()
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let authorizationStatus = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo)
        switch authorizationStatus {
        case .NotDetermined:
            AVCaptureDevice.requestAccessForMediaType(AVMediaTypeVideo,
                completionHandler: { (granted:Bool) -> Void in
                    if granted {
                        self.configureSession()
                    }
                    else {
                        self.showAccessDeniedMessage()
                    }
            })
        case .Authorized:
            configureSession()
        case .Denied, .Restricted:
            showAccessDeniedMessage()
        }
    }
    
    func configureSession(){
        session = AVCaptureSession()
        
        let availableCameraDevices = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo)
        for device in availableCameraDevices as [AVCaptureDevice] {
            if device.position == .Back {
                backCameraDevice = device
            }
            else if device.position == .Front {
                frontCameraDevice = device
            }
        }
        
        
        self.currentCameraDevice = self.backCameraDevice
        var error:NSError?
        
        let possibleCameraInput: AnyObject? = AVCaptureDeviceInput.deviceInputWithDevice(self.currentCameraDevice, error: &error)
        if let backCameraInput = possibleCameraInput as? AVCaptureDeviceInput {
            if self.session.canAddInput(backCameraInput) {
                self.session.addInput(backCameraInput)
            }
        }
        
        self.stillCameraOutput = AVCaptureStillImageOutput()
        self.stillCameraOutput.outputSettings = [
            AVVideoCodecKey  : AVVideoCodecJPEG,
            AVVideoQualityKey: 0.9
        ]
        
        if self.session.canAddOutput(self.stillCameraOutput) {
            self.session.addOutput(self.stillCameraOutput)
        }
        
        self.videoOutput = AVCaptureVideoDataOutput()
        self.videoOutput.setSampleBufferDelegate(self, queue: dispatch_queue_create("sample buffer delegate", DISPATCH_QUEUE_SERIAL))
        if self.session.canAddOutput(self.videoOutput) {
            self.session.addOutput(self.videoOutput)
        }
        
        previewLayer = AVCaptureVideoPreviewLayer.layerWithSession(session) as AVCaptureVideoPreviewLayer
        previewLayer.frame = CGRect()
        previewLayer.frame.origin = view.bounds.origin
        previewLayer.frame.size.width = view.bounds.size.width
        previewLayer.frame.size.height = videoPreviewView.bounds.size.height
        self.previewLayer.frame=self.view.bounds
        videoPreviewView.layer.addSublayer(previewLayer)
        session.startRunning()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

