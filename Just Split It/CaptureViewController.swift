//
//  CaptureViewController.swift
//  Just Split It
//
//  Created by Muhammad Joyo on 12/9/17.
//

import UIKit
import AVFoundation
import Vision

class CaptureViewController: UIViewController {

    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var captureButton: UIButton!
    
    //Allows us to transfer data between one or more device inputs
    var captureSession: AVCaptureSession?
    //Allows us to render the live feed from the camera to the view
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    //Allows us to capture a still image from the captureSession
    var capturePhotoOutput: AVCapturePhotoOutput?
    //Allows us to send the image to the next view
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Init a device object with a video media type
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        
        do {
            //Connect input device to capture device
            let inputDevice = try AVCaptureDeviceInput(device: captureDevice!)
            
            //Init capture session
            captureSession = AVCaptureSession()
            //Add input device to capture session
            captureSession?.addInput(inputDevice)
            
            //Init videoPreviewLayer and add it as a sublayer to previewView
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            previewView.layer.addSublayer(videoPreviewLayer!)
            
            //Init AVCapturePhotoOutput
            capturePhotoOutput = AVCapturePhotoOutput()
            //Enable High Res photos
            capturePhotoOutput?.isHighResolutionCaptureEnabled = true
            //Add capturePhotoOutput as output to the capture session
            captureSession?.addOutput(capturePhotoOutput!)
            
            //Start capture session
            captureSession?.startRunning()
            
        } catch {
            print(error)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTapTakePhoto(_ sender: Any) {
        // Check if capturePhotoOutput is valid
        guard let capturePhotoOutput = self.capturePhotoOutput else {
            return
        }
        
        //Init AVCapturePhotoSettings
        let photoSettings = AVCapturePhotoSettings()
        
        //Set photo settings
        photoSettings.isAutoStillImageStabilizationEnabled = true
        photoSettings.isHighResolutionPhotoEnabled = true
        photoSettings.flashMode = .off
        
        //Call capturePhoto method and pass photoSettings and self which implements AVCapturePhotoCaptureDelegate
        capturePhotoOutput.capturePhoto(with: photoSettings, delegate: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPictureSegue" {
            let destination = segue.destination as! PictureViewController
            destination.capturedImageRef = self.image!
        }
    }

}

extension CaptureViewController : AVCapturePhotoCaptureDelegate {
    func photoOutput(_ captureOutput: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?,
                     previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?,
                     resolvedSettings: AVCaptureResolvedPhotoSettings,
                     bracketSettings: AVCaptureBracketedStillImageSettings?,
                     error: Error?) {
        //Get captured image
        //Make sure we get the photoSampleBuffer
        guard error == nil, let photoSampleBuffer = photoSampleBuffer else {
            print("Error capturing photo: \(String(describing: error))")
            return
        }
        //Convert photoSampleBuffer to a jpeg
        guard let imageData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer, previewPhotoSampleBuffer: previewPhotoSampleBuffer) else {
            return
        }
        //Init a UIImage with our image data
        let capturedImage = UIImage.init(data: imageData , scale: 1.0)
        if let img = capturedImage {
            //Set our captured image to the class var
            self.image = img
            
            self.performSegue(withIdentifier: "showPictureSegue", sender: self)
        }
    }
}
