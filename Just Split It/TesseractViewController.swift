//
//  TesseractViewController.swift
//  Just Split It
//
//  Created by William on 12/11/17.
//

import UIKit
import Foundation
import TesseractOCR

class TesseractViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func takePhoto(_ sender: Any) {
        view.endEditing(true)
        presentImagePicker()
    }
    
    // Tesseract Image Recognition
    func performImageRecognition(_ image: UIImage) {
        if let tesseract = G8Tesseract(language: "eng+fra") {
            // 2
            tesseract.engineMode = .tesseractCubeCombined
            // 3
            tesseract.pageSegmentationMode = .auto
            // 4
            tesseract.image = image.g8_blackAndWhite()
            // 5
            tesseract.recognize()
            // 6
            textView.text = tesseract.recognizedText
        }
        // 7
        activityIndicator.stopAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let imagePickerActionSheet = UIAlertController(title: "Please choose option!", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
//        let cameraButtonAction = UIAlertAction(title: "Use Camera", style: UIAlertActionStyle.default){
//            (UIAlertAction) -> Void in
//        }
//        imagePickerActionSheet.addAction(cameraButtonAction)
//
//        let libraryButtonAction = UIAlertAction(title: "Use Photo Library", style: UIAlertActionStyle.default){
//            (UIAlertAction) -> Void in
//        }
//        imagePickerActionSheet.addAction(libraryButtonAction)
//        present(imagePickerActionSheet,animated: true){
//            () -> Void in
//        }

        
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// 1
// MARK: - UINavigationControllerDelegate
extension TesseractViewController: UINavigationControllerDelegate {
}

// MARK: - UIImagePickerControllerDelegate
extension TesseractViewController: UIImagePickerControllerDelegate {
    func presentImagePicker() {
        // 2
        let imagePickerActionSheet = UIAlertController(title: "Snap/Upload Image",
                                                       message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        // 3
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let cameraButton = UIAlertAction(title: "Take Photo",
                                             style: .default) {
                                                (alert) -> Void in
                                                let imagePicker = UIImagePickerController()
                                                imagePicker.delegate = self
                                                imagePicker.sourceType = .camera
                                                self.present(imagePicker, animated: true)
            }
            imagePickerActionSheet.addAction(cameraButton)
        }
        // Insert here
        let libraryButton = UIAlertAction(title: "Choose Existing",
                                          style: .default) {
                                            (alert) -> Void in
                                            let imagePicker = UIImagePickerController()
                                            imagePicker.delegate = self
                                            imagePicker.sourceType = .photoLibrary
                                            self.present(imagePicker, animated: true)
        }
        imagePickerActionSheet.addAction(libraryButton)
        // 2
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        imagePickerActionSheet.addAction(cancelButton)
        // 3
        present(imagePickerActionSheet,animated: true){
            () -> Void in
        }
    }
    
    // 1
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // 2
        if let selectedPhoto = info[UIImagePickerControllerOriginalImage] as? UIImage,
            let scaledImage = selectedPhoto.scaleImage(640) {
            // 3
            self.activityIndicator.startAnimating()
            // 4
            dismiss(animated: true, completion: {
                self.performImageRecognition(scaledImage)
            })
        }
    }
    
}

// MARK: - UIImage extension
extension UIImage {
    func scaleImage(_ maxDimension: CGFloat) -> UIImage? {
        
        var scaledSize = CGSize(width: maxDimension, height: maxDimension)
        
        if size.width > size.height {
            let scaleFactor = size.height / size.width
            scaledSize.height = scaledSize.width * scaleFactor
        } else {
            let scaleFactor = size.width / size.height
            scaledSize.width = scaledSize.height * scaleFactor
        }
        
        UIGraphicsBeginImageContext(scaledSize)
        draw(in: CGRect(origin: .zero, size: scaledSize))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
}

