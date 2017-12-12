//
//  PictureViewController.swift
//  Just Split It
//
//  Created by Muhammad Joyo on 12/12/17.
//

import UIKit

class PictureViewController: UIViewController {
	
	@IBOutlet weak var imageView: UIImageView!
	
	//Variable that's going to receive the UIImage
	var capturedImageRef = UIImage()
	
    override func viewDidLoad() {
        super.viewDidLoad()

		imageView.image = capturedImageRef
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	

}
