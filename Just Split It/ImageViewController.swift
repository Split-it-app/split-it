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
		let quantityRegex = try! NSRegularExpression(pattern: "(^[0-9]+)(\\s)*", options: [])
		
		//When true, stops adding items
		var reachedEndOfItems = false
		
		//Goes through every line in the receipt
		for current in lines {
			//Looks for the all matches of a possible price
			let priceMatches = priceRegex.matches(in: current, range: NSRange(location: 0, length: current.count))
			//Looks for the first match of the word "tax"
			let taxMatch = taxRegex.firstMatch(in: current, range: NSRange(location: 0, length: current.count))
			//Looks for the first match of a number at the beginning of the string
			let quantityMatch = quantityRegex.firstMatch(in: current, range: NSRange(location: 0, length: current.count))
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
				let price = currNS?.substring(with: priceMatch!.range).replacingOccurrences(of: " ", with: "").replacingOccurrences(of: ",", with: ".") as NSString?
				//Adds tax item to the group bill
				let tax = Item(name: "Tax", price: price?.floatValue ?? 0)
				newGroupBill.addItem(item: tax)
				reachedEndOfItems = true
			} else if !reachedEndOfItems && priceMatch != nil {
				//Converts string to NSString
				let currNS = current as NSString?
				//Checks if the line has total, amount, or due, and skips them
				if (currNS?.localizedCaseInsensitiveContains("total"))! || (currNS?.localizedCaseInsensitiveContains("amount"))! || (currNS?.localizedCaseInsensitiveContains("due"))! {
					reachedEndOfItems = true
					continue
				}
				//Default quantity is 1
				var quantity = 1
				let itemName: String?
				if(quantityMatch != nil) {
					//Creates a substring of the quantity without the space after
					let itemQuantity = currNS?.substring(with: quantityMatch!.range(at: 0)) as NSString?
					//Only sets it as the quantity if it's less than 10
					if(itemQuantity!.intValue <= 10) {
						quantity = Int(itemQuantity!.intValue)
					}
					//Creates a substring from the end of quantity to the beginning of price
					itemName = currNS?.substring(with: NSMakeRange(quantityMatch!.range.length, priceMatch!.range.location - quantityMatch!.range.length))
				} else {
					//Creates a substring of the rest of the string to get the name
					itemName = currNS?.substring(with: NSMakeRange(0, priceMatch!.range.location))
				}
				//Takes the range from priceMatch and get's the subtring of the match
				let price = currNS?.substring(with: priceMatch!.range) as NSString?
				//Creates a character set of character not wanted in the name
				let charactersToRemove = NSCharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVW‌​XYZabcdefghijklmnopq‌​rstuvwxyz0123456789.‌​_- ").inverted
				//Removes all unwanted characters from the character set
				let cleanName = itemName?.components(separatedBy: charactersToRemove).joined(separator: "")
				//Calculate actual price
				let itemPrice = (price?.floatValue)!/Float(quantity)
				//Adds new items to the group bill based on the quantity
				for _ in 1...quantity {
					let newItem = Item(name: cleanName!, price: itemPrice)
					newGroupBill.addItem(item: newItem)
				}
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
