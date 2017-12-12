//
//  IndividualBillViewController.swift
//  Just Split It
//
//  Created by Maria-Belem on 12/11/17.
//

import UIKit

class IndividualBillViewController: UIViewController {
    
    @IBOutlet weak var individBillLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        individBillLabel.text = "MB's Bill"
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
