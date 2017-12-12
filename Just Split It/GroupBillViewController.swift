//
//  GroupBillViewController.swift
//  Just Split It
//
//  Created by Maria-Belem on 11/20/17.
//

import UIKit



class GroupBillViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var FriendTableView: UITableView!
    @IBOutlet weak var ItemTableView: UITableView!
    @IBOutlet weak var priceTableView: UITableView!
    
    
    var model:ModelClass = ModelClass()
    
    var groupBill = GroupBill() // this is the user-selected group bill is carried over from ViewController
    
    var itemsArray:[Item] = [Item]()
    var friendsArray:[Friend] = [Friend]()
    var totalPrice = 100.0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Billname: " + groupBill.getBillName())  // for testing
        
        print("item count: " + groupBill.getItemArray().count.description)
        
        itemsArray = groupBill.getItemArray()
        friendsArray = groupBill.getFriendArray()
        
        print("friend count: " + friendsArray.count.description)
    
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // if tableView is the top table view (i.e. friend's list)
        if (tableView == self.FriendTableView){
            return "Friends" // only 1 category here
        }
        // if tableView is the bottom table view (i.e. items list)
        else if (tableView == self.ItemTableView){
            return groupBill.getBillName()
        }
        
        else{
            return "Price"
        }
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
       var showPrice = ""
        if (tableView == self.ItemTableView){
        /*
            for i in itemsArray {
                totalPrice += itemsArray[i].price
            }
        */
            showPrice = "Total $ \(totalPrice)"
        }
        return showPrice
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if(tableView == self.ItemTableView) {
            return 1
        }
        else if (tableView == self.FriendTableView){
            return 1
        }
        else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // # of rows dependent on array size
         if(tableView == self.ItemTableView) {
             return self.itemsArray.count
         }
         else if (tableView == self.FriendTableView){
            return 1
        }
         else{
            return self.itemsArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(tableView == self.ItemTableView){
            return 40
        }
        else if (tableView == self.FriendTableView){
            return 90
        }
        else{
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == self.ItemTableView) {
            //let itemCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "itemCell")
            
            let itemCell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! itemListTableViewCell
            
            
            itemCell.Title.text = itemsArray[indexPath.row].name
            itemCell.Detail.text = "$ " + itemsArray[indexPath.row].price.description
            
            //itemCell.textLabel?.text = itemsArray[indexPath.row].name
            //itemCell.detailTextLabel?.text = "$" + itemsArray[indexPath.row].price.description
            return itemCell
        
        } else {
            let friendListCell = tableView.dequeueReusableCell(withIdentifier: "friendListCell") as! CategoryRow
            //friendListCell.textLabel?.text = "friend" //REMOVED because need to write friend name in collection view cell and NOT table view cell 
            // transfer friends array to CategoryRow
            friendListCell.friendArray = self.friendsArray
            return friendListCell
        }
        
        /* else if (tableView == self.FriendTableView){
            let friendListCell = tableView.dequeueReusableCell(withIdentifier: "friendListCell") as! CategoryRow
            // transfer friends array to CategoryRow
            friendListCell.friendArray = self.friendsArray
            return friendListCell
        }
        else{
            let priceCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "priceCell")
            priceCell.textLabel?.text = itemsArray[indexPath.row].price.description
            return priceCell
        }*/
    }
    
    /*
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
        //self.myTableView.tableFooterView = footerView;
        
        /*
        for item in itemsArray {
            totalPrice += itemsArray[item].price
        }
 */

        let label = UILabel(frame: CGRect(x: footerView.frame.origin.x - 15, y: footerView.frame.origin.y, width: footerView.frame.size.width, height: 20))
        label.textAlignment = NSTextAlignment.right
        
        label.text = "Total $ \(totalPrice)"
        
        footerView.addSubview(label)
        
        return footerView
    }
    */

    
    // transfer individual bill to IndividualBillVC

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "GroupBillVCtoIndividualBillVC"){
            let IndividBillVC = segue.destination as! IndividualBillViewController
            
            //IndividBillVC.individBillLabel.text =  friendCell.friendName + "'s Bill"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


