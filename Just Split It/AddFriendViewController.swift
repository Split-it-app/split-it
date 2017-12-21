//
//  AddFriendViewController.swift
//  Just Split It
//
//  Created by Maria-Belem on 12/20/17.
//

import UIKit

class AddFriendViewController: UIViewController {

    let JSIColor = UIColor(red: 64/255.0, green: 173/255.0, blue: 98/255.0, alpha: 1.0)
    
    var model:ModelClass = ModelClass()
    
    var groupBill = GroupBill() // this is the user-selected group bill that is carried over from ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = JSIColor
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
