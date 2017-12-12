//
//  RawDataViewController.swift
//  Just Split It
//
//  Created by Muhammad Joyo on 12/12/17.
//

import UIKit

class RawDataViewController: UIViewController {

	@IBOutlet weak var rawDataTextView: UITextView!
	
	var rawData: String!
	
    override func viewDidLoad() {
        super.viewDidLoad()

		rawDataTextView.text = rawData;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
