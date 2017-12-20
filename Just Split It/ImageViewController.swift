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
	var newGroupBill: GroupBill!
	
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
	
	//parsing rawText into a GroupBill
	func parseText(rawText: String) {
		newGroupBill = GroupBill(name: "New Bill")
		
		//Split raw text by lines
		let lines = rawText.components(separatedBy: "\n")
		
		//NSRegexExpressions
		let taxRegex = try! NSRegularExpression(pattern: "(T|t)(a|A|c|C|o|O|\\s)(X|x)", options: [])
		let priceRegex = try! NSRegularExpression(pattern: "[0-9]*\\s?[\\.|,]\\s?[0-9][0-9]", options: [])
		
		//Goes through every line in the receipt
		for current in lines {
			//Looks for the all matches of a possible price
			let priceMatches = priceRegex.matches(in: current, range: NSRange(location: 0, length: current.count))
			//Looks for the first match of the word "tax"
			let taxMatch = taxRegex.firstMatch(in: current, range: NSRange(location: 0, length: current.count))
			//Selects the last match of price in the line
			let priceMatch: NSTextCheckingResult?
			if priceMatches.count > 0 {
				priceMatch = priceMatches[priceMatches.count - 1]
			} else {
				priceMatch = nil
			}
			//Adds tax item if there is a tax and price match
			if taxMatch != nil && priceMatch != nil {
				//Converts string to NSString
				let currNS = current as NSString?
				//Takes the range from priceMatch and get's the subtring of the match
				let price = currNS?.substring(with: priceMatch!.range) as NSString?
				//Adds tax item to the group bill
				let tax = Item(name: "Tax", price: price?.floatValue ?? 0)
				newGroupBill.addItem(item: tax)
			} else if priceMatch != nil {
				//Converts string to NSString
				let currNS = current as NSString?
				//Takes the range from priceMatch and get's the subtring of the match
				let price = currNS?.substring(with: priceMatch!.range) as NSString?
				//Creates a substring of the string that isn't the price to get the name
				let nameRange = NSMakeRange(0, priceMatch!.range.location)
				//Adds tax item to the group bill
				let tax = Item(name: (currNS?.substring(with: nameRange))!, price: price?.floatValue ?? 0)
				newGroupBill.addItem(item: tax)
			}
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
		let scaledImage = imageView.image?.scaleImage(1600)
		performImageRecognition(scaledImage!)
		
		//parse text and save it to newGroupBill
		parseText(rawText: rawTextData)
		
		//Segue to next view
		//self.performSegue(withIdentifier: "showRawDataSegue", sender: self)
		self.performSegue(withIdentifier: "showNewBillSegue", sender: self)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "showRawDataSegue" {
			
			let destination = segue.destination as! RawDataViewController
			destination.rawData = self.rawTextData!
		} else if segue.identifier == "showNewBillSegue" {
			
			let destination = segue.destination as! GroupBillViewController
			destination.groupBill = newGroupBill;
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
