//
//  IndividualBillViewController.swift
//  Just Split It
//
//  Created by Maria-Belem on 12/11/17.
//

import UIKit

class IndividualBillViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

	@IBOutlet weak var totalsTableView: UITableView!
	
	var groupBill: GroupBill?
	var totals: [Friend:Float]?
	let JSIColor = UIColor(red: 64/255.0, green: 173/255.0, blue: 98/255.0, alpha: 1.0)
	let frostColor = UIColor(red: 223/255.0, green: 236/255.0, blue: 229/255.0, alpha: 1.0)
	
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = JSIColor
		self.totalsTableView.backgroundColor = JSIColor
		
		totals = [:]
		
		splitBill()
		print(totals!)
    }
    
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return totals!.count
	}
    
	internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
		let totalCell = tableView.dequeueReusableCell(withIdentifier: "totalCell", for: indexPath) as! totalTableViewCell
		
		let key   = Array(self.totals!.keys)[indexPath.row]
		let value = Array(self.totals!.values)[indexPath.row]
		
		totalCell.Name.text = key.name
		totalCell.Name.font = UIFont (name: "PingFangHK-Regular", size: 20)
		totalCell.Name.textColor = frostColor
		
		totalCell.TotalValue.text = String(format: "$%.02f", value)
		totalCell.TotalValue.font = UIFont (name: "PingFangHK-Regular", size: 20)
		totalCell.TotalValue.textColor = frostColor
		
		//itemCell.backgroundColor = JSIColor
		
		return totalCell
	}
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

	func splitBill() {
		for friend in groupBill!.friendArray {
			totals![friend] = 0;
		}
		let items = groupBill?.itemArray
		for item in items! {
			print("here")
			if item.name != "Tax" && item.purchasedBy.count > 0 {
				print("now here")
				for friend in item.purchasedBy {
					print("and now here")
					totals![friend] = item.price/Float(item.purchasedBy.count) + totals![friend]!
					print(item.price/Float(item.purchasedBy.count) + totals![friend]!)
				}
			} else if item.name == "Tax" {
				for friend in (groupBill?.friendArray)! {
					totals![friend] = item.price/Float((groupBill?.friendArray.count)!) + totals![friend]!
				}
			}
		}
		print("printing")
		print(totals!)
	}

}
