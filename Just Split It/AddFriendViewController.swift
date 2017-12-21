//
//  AddFriendViewController.swift
//  Just Split It
//
//  Created by Maria-Belem on 12/20/17.
//

import UIKit

class AddFriendViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var itemTableView: UITableView!
    
    // save friend name after button is pressed
    @IBAction func enterPressed(_ sender: Any) {
        friend.name = nameTextField.text!
        print("set friend name to: " + nameTextField.text!)
    }
    
    let JSIColor = UIColor(red: 64/255.0, green: 173/255.0, blue: 98/255.0, alpha: 1.0)
    
    var model:ModelClass = ModelClass()
    
    var groupBill = GroupBill() // this is the user-selected group bill that is carried over from GroupBillViewController
    
    var friend = Friend()
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Select your items"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupBill.getItemArray().count - 1 // to remove tax
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "itemCell")
        itemCell.textLabel?.text = groupBill.getItemArray()[indexPath.row].name
        return itemCell
    }
    
    // For selecting and assigning items to friend
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // find selected cell
        let cell = tableView.cellForRow(at: indexPath)
        cell?.contentView.backgroundColor = UIColor .yellow
        print("selected row index" + indexPath.row.description)
        
        // assign friend to the item that the user has selected
        groupBill.getItemArray()[indexPath.row].appendPurchasedBy(user: friend)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.contentView.backgroundColor = UIColor .yellow        
    }
    
    
    
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add the friend object to groupBill. This friend's name is set by the textField
        groupBill.addFriend(friend: friend)
        
        
        
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
