//
//  IndividualBillViewController.swift
//  Just Split It
//
//  Created by Maria-Belem on 12/11/17.
//

import UIKit

class IndividualBillViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var IndividItemTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
