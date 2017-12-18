//
//  ViewController.swift
//  Just Split It
//
//  Created by Maria-Belem on 11/8/17.
//
//  GITHUB LINK: https://github.com/Split-it-app/split-it
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var groupBillsTableView: UITableView!
    
    // initialize model (for MVC purposes)
    var model: ModelClass = ModelClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // EXAMPLE
        let groupBill1 = GroupBill(name: "Bill 1")
        let groupBill2 = GroupBill(name: "Bill 2")
        let groupBill3 = GroupBill(name: "Bill 3")
        let item1 = Item(name: "milkshake capuccino espresso gonzalalaalalala", price: 2)
        let item2 = Item(name: "coca cola", price: 3)
        let item3 = Item(name: "sprite", price: 4)
        let item4 = Item(name: "hard drugs", price: 5)
        let tax = Item(name: "Tax", price: 2)
        let friend1 = Friend()
        friend1.name = "MB"
        let friend2 = Friend()
        friend2.name = "MJ"
        let friend3 = Friend()
        friend3.name = "WJ"
        let friend4 = Friend()
        friend4.name = "Hull"
        let friend5 = Friend()
        friend5.name = "MC"
        groupBill1.addItem(item: item1)
        groupBill1.addItem(item: item2)
        groupBill1.addItem(item: item3)
        groupBill1.addItem(item: item4)
        groupBill1.addItem(item: tax)
        let itema = Item(name: "Coffee", price: 4)
        let itemb = Item(name: "Biscuit", price: 4)
        let itemc = Item(name: "Smoothie", price: 3)
        let itemd = Item(name: "Oatmeal", price: 3)
        let tax2 = Item(name: "Tax", price: 2)
        groupBill2.addItem(item: itema)
        groupBill2.addItem(item: itemb)
        groupBill2.addItem(item: itemc)
        groupBill2.addItem(item: itemd)
        groupBill2.addItem(item: tax2)
        
        let ramen1 = Item(name: "Veggie Ramen", price: 12)
        let ramen2 = Item(name: "Drink", price: 2)
        let tax3 = Item(name:"Tax", price: 2)
        groupBill3.addItem(item: ramen1)
        groupBill3.addItem(item: ramen2)
        groupBill3.addItem(item: tax3)
        
        groupBill1.addFriend(friend: friend1)
        groupBill1.addFriend(friend: friend2)
        groupBill1.addFriend(friend: friend3)
        groupBill1.addFriend(friend: friend4)
        groupBill1.addFriend(friend: friend5)
        groupBill1.setDate(date: "11/14/17")
        groupBill2.setDate(date: "10/31/17")
        groupBill3.setDate(date: "06/21/17")
        
        let John = Friend()
        John.name = "John"
        let Peter = Friend()
        Peter.name = "Peter"
        groupBill2.addFriend(friend: John)
        groupBill2.addFriend(friend: Peter)
        let Emily = Friend()
        Emily.name = "Emily"
        let Jessica = Friend()
        Jessica.name = "Jessica"
        groupBill3.addFriend(friend: Emily)
        groupBill3.addFriend(friend: Jessica)
        
        //let model:ModelClass = ModelClass()
        //model = ModelClass()
        model.addBill(groupBill: groupBill1)
        model.addBill(groupBill: groupBill2)
        model.addBill(groupBill: groupBill3)
        
        //let mintColor = UIColor(red: 192/255.0, green: 223/255.0, blue: 217/255.0, alpha: 1.0)
        //let mintColor2 = UIColor(red: 219/255.0, green: 233/255.0, blue: 216/255.0, alpha: 1.0)
        let JSIColor = UIColor(red: 64/255.0, green: 173/255.0, blue: 98/255.0, alpha: 1.0)
        
        self.view.backgroundColor = JSIColor
        self.groupBillsTableView.backgroundColor = JSIColor
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.groupBillArray.count
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // let billCell = tableView.dequeueReusableCell(withIdentifier: "billCell", for: indexPath)
        let billCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "billCell")
        //let billCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "billCell")
      
        //let mintColor = UIColor(red: 192/255.0, green: 223/255.0, blue: 217/255.0, alpha: 1.0)
        //let mintColor2 = UIColor(red: 219/255.0, green: 233/255.0, blue: 216/255.0, alpha: 1.0)
        let frostColor = UIColor(red: 233/255.0, green: 236/255.0, blue: 229/255.0, alpha: 1.0)
        //let darkColor = UIColor(red: 59/255.0, green: 58/255.0, blue: 54/255.0, alpha: 1.0)
        let JSIColor = UIColor(red: 64/255.0, green: 173/255.0, blue: 98/255.0, alpha: 1.0)
        
        billCell.textLabel?.text = model.groupBillArray[indexPath.row].getBillName()
        billCell.textLabel?.textColor = frostColor
        billCell.textLabel?.font = UIFont (name: "PingFangHK-Regular", size: 20)
        billCell.detailTextLabel?.text = model.groupBillArray[indexPath.row].date
        billCell.detailTextLabel?.font = UIFont (name: "PingFangHK-Regular", size: 14)
        billCell.detailTextLabel?.textColor = frostColor
        billCell.backgroundColor = JSIColor
        return billCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let groupBillVC = GroupBillViewController()
        groupBillVC.model = self.model;
        groupBillVC.groupBill = self.model.groupBillArray[indexPath.row]
        
        self.performSegue(withIdentifier: "VCtoGroupBillVC", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "VCtoGroupBillVC" {
            
            let GroupBillVC = segue.destination
                as! GroupBillViewController
            let myIndexPath = self.groupBillsTableView.indexPathForSelectedRow!
            let row = myIndexPath.row
            GroupBillVC.groupBill =  model.groupBillArray[row]
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

