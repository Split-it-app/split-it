//
//  PictureViewController.swift
//  Just Split It
//
//  Created by Muhammad Joyo on 12/12/17.
//

import UIKit
import Foundation
import TesseractOCR

class PictureViewController: UIViewController {
	
	@IBOutlet weak var digitizeButton: UIButton!
	@IBOutlet weak var imageView: UIImageView!
	
	//Variable that's going to receive the UIImage
	var capturedImageRef: UIImage!
	var rawTextData: String!
    
    
    // Tesseract Image Recognition
    func performImageRecognition(_ image: UIImage) {
        if let tesseract = G8Tesseract(language: "eng+fra") {
            // 2
            tesseract.engineMode = .tesseractCubeCombined
            // 3
            tesseract.pageSegmentationMode = .auto
            // 4
            tesseract.image = image.g8_blackAndWhite()
			//imageView.image = image.g8_blackAndWhite()
            // 5
            tesseract.recognize()
            // 6
            print (tesseract.recognizedText)
			// 7
			rawTextData = tesseract.recognizedText
        }
    }
	
    override func viewDidLoad() {
        super.viewDidLoad()

		imageView.image = capturedImageRef
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	@IBAction func onDigitizeClicked() {
		let scaledImage = imageView.image?.scaleImage(640)
		performImageRecognition(scaledImage!)
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
