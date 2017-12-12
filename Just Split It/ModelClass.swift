//
//  ModelClass.swift
//  Just Split It
//
//  Created by Banana on 12/8/17.
//

import UIKit

class ModelClass: NSObject {

    // array of Group Bills
    var groupBillArray: [GroupBill]
    
    override init(){
        groupBillArray = [GroupBill]()
    }
    
    func addBill(groupBill: GroupBill){
        groupBillArray.append(groupBill)
    }
    
    func getCount() -> Int{
        return groupBillArray.count
    }
}
