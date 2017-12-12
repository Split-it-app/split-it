//
//  CategoryRow.swift
//  Just Split It
//
//  Created by Banana on 12/8/17.
//

import UIKit

class CategoryRow: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
//    let GBVC:GroupBillViewController = GroupBillViewController()
    
    //let model:ModelClass = ModelClass()
    
    var friendArray = [Friend]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // test
        print ("category friend count: " + friendArray.count.description)
        //print(friendArray[0].name)
        return friendArray.count
    }
    
    // extension: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let friendCellCollection = collectionView.dequeueReusableCell(withReuseIdentifier: "friendCellCollection", for: indexPath) as! friendCollectionViewCell
        
         friendCellCollection.friendName = friendArray[indexPath.row].name
        //let friend = friendArray[indexPath.row];
       // friendCellCollection.friendName = friend.name
    
        let lavenderColor = UIColor(red: 176/255.0, green: 170/255.0, blue: 194/255.0, alpha: 1.0)
   
        friendCellCollection.backgroundColor = lavenderColor
        friendCellCollection.friendNameFont = UIFont (name: "PingFangHK-Regular", size: 20)!
        
        return friendCellCollection
        
        /*
         // let billCell = tableView.dequeueReusableCell(withIdentifier: "billCell", for: indexPath)
         let billCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "billCell")
         //let billCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "billCell")
         
         let mintColor = UIColor(red: 192/255.0, green: 223/255.0, blue: 217/255.0, alpha: 1.0)
         //let mintColor2 = UIColor(red: 219/255.0, green: 233/255.0, blue: 216/255.0, alpha: 1.0)
         // let frostColor = UIColor(red: 233/255.0, green: 236/255.0, blue: 229/255.0, alpha: 1.0)
         let darkColor = UIColor(red: 59/255.0, green: 58/255.0, blue: 54/255.0, alpha: 1.0)
         
         billCell.textLabel?.text = model.groupBillArray[indexPath.row].getBillName()
         billCell.textLabel?.textColor = darkColor
         billCell.textLabel?.font = UIFont (name: "PingFangHK-Regular", size: 20)
         billCell.detailTextLabel?.text = model.groupBillArray[indexPath.row].date
         billCell.detailTextLabel?.font = UIFont (name: "PingFangHK-Regular", size: 14)
         billCell.detailTextLabel?.textColor = darkColor
         billCell.backgroundColor = mintColor
         */
    }
    
    // extension: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let mintColor = UIColor(red: 192/255.0, green: 223/255.0, blue: 217/255.0, alpha: 1.0)
        
        let itemsPerRow: CGFloat = 4
        let hardCodedPadding: CGFloat = 5
        let itemWidth = (collectionView.bounds.width/itemsPerRow) - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2*hardCodedPadding)
        collectionView.backgroundColor = mintColor
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    
    
    
}
