//
//  IndividualBillViewController.swift
//  Just Split It
//
//  Created by Maria-Belem on 12/11/17.
//

import UIKit

class IndividualBillViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

	//@IBOutlet weak var IndividItemTableView: UITableView!
	
	var groupBill: GroupBill?
	var totals: Array<Total>?
	let JSIColor = UIColor(red: 64/255.0, green: 173/255.0, blue: 98/255.0, alpha: 1.0)
	
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = JSIColor
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemCell = tableView.dequeueReusableCell(withIdentifier: "individItemCell", for: indexPath) as! itemListTableViewCell
        
        
        //itemCell.Title.text = itemsArray[indexPath.row].name
        itemCell.Title.text = "Item Name"
        // itemCell.Detail.text = "$" + itemsArray[indexPath.row].price.description
        itemCell.Detail.text = "$5"
        
        //itemCell.textLabel?.text = itemsArray[indexPath.row].name
        //itemCell.detailTextLabel?.text = "$" + itemsArray[indexPath.row].price.description
        return itemCell
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

	func splitBill(bill: GroupBill) {
		let items = groupBill?.itemArray
		for item in items {
			if item.purchasedBy.count > 0 {
				
			}
		}
	}

}
