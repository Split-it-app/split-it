//
//  PictureViewController.swift
//  Just Split It
//
//  Created by Muhammad Joyo on 12/12/17.
//

import UIKit
import Foundation
import TesseractOCR

class ImageViewController: UIViewController {
	
	@IBOutlet weak var digitizeButton: UIButton!
	@IBOutlet weak var imageView: UIImageView!
	
	//Variable that's going to receive the UIImage
	var capturedImageRef: UIImage!
	var rawTextData: String!
	
	
	// Tesseract Image Recognition
	func performImageRecognition(_ image: UIImage) {
		if let tesseract = G8Tesseract(language: "eng") {
			//Set tesseract mode to Cube combined (slowest but also the most accurate)
			tesseract.engineMode = .tesseractCubeCombined
			//Set mode so that it recognizes paragraph breaks
			tesseract.pageSegmentationMode = .auto
			//Filter the image to make it easier to read
			tesseract.image = image.g8_blackAndWhite()
			//Recognize text in the image
			tesseract.recognize()
			//Print raw text
			print (tesseract.recognizedText)
			//Save raw text
			rawTextData = tesseract.recognizedText
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		//Set image to the imageView
		imageView.image = capturedImageRef
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	@IBAction func onDigitizeClicked() {
		//Scale image to get the best results
		let scaledImage = imageView.image?.scaleImage(1200)
		performImageRecognition(scaledImage!)
		
		//Segue to next view
		self.performSegue(withIdentifier: "showRawDataSegue", sender: self)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "showRawDataSegue" {
			
			let destination = segue.destination as! RawDataViewController
			destination.rawData = self.rawTextData!
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
