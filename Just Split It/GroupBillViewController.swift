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
    //@IBOutlet weak var priceTableView: UITableView!
    
    let mintColor = UIColor(red: 192/255.0, green: 223/255.0, blue: 217/255.0, alpha: 1.0)
    let darkColor = UIColor(red: 59/255.0, green: 58/255.0, blue: 54/255.0, alpha: 1.0)
    let frostColor = UIColor(red: 223/255.0, green: 236/255.0, blue: 229/255.0, alpha: 1.0)
    let JSIColor = UIColor(red: 64/255.0, green: 173/255.0, blue: 98/255.0, alpha: 1.0)
    
    var model:ModelClass = ModelClass()
    
    var groupBill = GroupBill() // this is the user-selected group bill that is carried over from ViewController
    
    var itemsArray:[Item] = [Item]()
    var friendsArray:[Friend] = [Friend]()
    var totalPrice: Float = 0.0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Billname: " + groupBill.getBillName())  // for testing
        
        print("item count: " + groupBill.getItemArray().count.description)
        
        itemsArray = groupBill.getItemArray()
        friendsArray = groupBill.getFriendArray()
        
        print("friend count: " + friendsArray.count.description)
        
        //let mintColor2 = UIColor(red: 219/255.0, green: 233/255.0, blue: 216/255.0, alpha: 1.0)
       // let mintColor = UIColor(red: 192/255.0, green: 223/255.0, blue: 217/255.0, alpha: 1.0)
        self.view.backgroundColor = JSIColor
        self.FriendTableView.backgroundColor = JSIColor
        self.FriendTableView.separatorColor = JSIColor
        self.ItemTableView.backgroundColor = JSIColor
        
        navigationController?.navigationBar.barTintColor = JSIColor
        
        for item in itemsArray {
            totalPrice+=item.price
            print("item name: \(item.name)")
            print("total price = \(totalPrice)")
        }
    
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // if tableView is the top table view (i.e. friend's list)
        if (tableView == self.FriendTableView){
            return "Friends" // only 1 category here
        }
        // if tableView is the bottom table view (i.e. items list)
        else {
            return groupBill.getBillName()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view:UIView, forSection: Int) {
        let darkColor = UIColor(red: 59/255.0, green: 58/255.0, blue: 54/255.0, alpha: 1.0)
       // let blueColor = UIColor(red: 194/255.0, green: 212/255.0, blue: 216/255.0, alpha: 1.0)
        
        if let headerTitle = view as? UITableViewHeaderFooterView {
            headerTitle.textLabel?.textColor = darkColor
            headerTitle.textLabel?.font = UIFont(name: "PingFangHK-Medium", size: 20)
           // headerTitle.backgroundView?.backgroundColor = frostColor
        }
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
       var showPrice = ""
       if (tableView == self.ItemTableView){
            showPrice = String(format: "Total $%.02f", totalPrice)
       }
        return showPrice
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        let darkColor = UIColor(red: 59/255.0, green: 58/255.0, blue: 54/255.0, alpha: 1.0)
        //let blueColor = UIColor(red: 194/255.0, green: 212/255.0, blue: 216/255.0, alpha: 1.0)
        
        if let footerTitle = view as? UITableViewHeaderFooterView {
            footerTitle.textLabel?.textColor = darkColor
            footerTitle.textLabel?.font = UIFont(name: "PingFangHK-Medium", size: 20)
           // footerTitle.backgroundView?.backgroundColor = frostColor
        }
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
            
           // let mintColor2 = UIColor(red: 219/255.0, green: 233/255.0, blue: 216/255.0, alpha: 1.0)
            
            itemCell.Title.text = itemsArray[indexPath.row].name
            itemCell.Title.font = UIFont (name: "PingFangHK-Regular", size: 20)
            itemCell.Title.textColor = frostColor
            
            itemCell.Detail.text = String(format: "$%.02f", itemsArray[indexPath.row].price)
            itemCell.Detail.font = UIFont (name: "PingFangHK-Regular", size: 20)
            itemCell.Detail.textColor = frostColor
            
            itemCell.backgroundColor = JSIColor
            
            //itemCell.textLabel?.text = itemsArray[indexPath.row].name
            //itemCell.detailTextLabel?.text = "$" + itemsArray[indexPath.row].price.description
            return itemCell
            
        } else {
            let friendListCell = tableView.dequeueReusableCell(withIdentifier: "friendListCell") as! CategoryRow
            //friendListCell.textLabel?.text = "friend" //REMOVED because need to write friend name in collection view cell and NOT table view cell
            // transfer friends array to CategoryRow
            friendListCell.friendArray = self.friendsArray
            
           // let mintColor2 = UIColor(red: 219/255.0, green: 233/255.0, blue: 216/255.0, alpha: 1.0)
            
            friendListCell.backgroundColor = JSIColor
            
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
            
        }
        else if (segue.identifier == "GroupBillVCtoAddFriendVC"){
            let AddFriendVC = AddFriendViewController()
            AddFriendVC.groupBill = self.groupBill
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


