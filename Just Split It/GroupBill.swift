//
//  GroupBill.swift
//  Just Split It
//
//  Created by Maria-Belem on 11/20/17.
//

import Foundation

class GroupBill: NSObject {
    var name:String = ""
    var itemArray: [Item] = [Item]()
    var friendArray: [Friend] = [Friend]()
    var date:String = ""
    
    override init(){
        name = ""
        
    }
    init (name: String){
        self.name = name
    }
    
    func setName (name:String){
        self.name = name
    }
    
    // add item to items list
    func addItem(item: Item){
        itemArray.append(item)
    }
    func addItem(name: String, price: Float){   // overloaded method for adding with name and price
        let item:Item = Item(name: name, price: price)
        itemArray.append(item)
    }
    
    // add friend to friends list
    func addFriend(friend: Friend){
        friendArray.append(friend)
    }
    
    //add date of bill
    func addDate(date: String){
        self.date = date 
    }
    
    // getters functions
    func getBillName() -> String{
        return self.name
    }
    
    func getItemArray() -> [Item]{
        return self.itemArray
    }
    
    func getFriendArray() -> [Friend]{
        return self.friendArray
    }
    
    func getDate() -> String{
        return self.date
    }
}





