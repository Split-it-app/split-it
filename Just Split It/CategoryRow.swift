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
    
    var colorArray = [UIColor]()
    var colorIndex = 0
    
    var fFont = UIFont (name: "PingFangHK-Regular", size: 20)
    
    //Want 4 different colors for the labels
    let salmonColor = UIColor(red: 250/255.0, green: 124/255.0, blue: 146/255.0, alpha: 1.0)
    let rainColor = UIColor(red: 110/255.0, green: 196/255.0, blue: 219/255.0, alpha: 1.0)
    let buttermilkColor = UIColor(red: 255/255.0, green: 247/255.0, blue: 192/255.0, alpha: 1.0)
    let lavenderColor = UIColor(red: 176/255.0, green: 170/255.0, blue: 194/255.0, alpha: 1.0)
    let leafColor = UIColor(red: 102/255.0, green: 171/255.0, blue: 140/255.0, alpha: 1.0)
    
    let frostColor = UIColor(red: 223/255.0, green: 236/255.0, blue: 229/255.0, alpha: 1.0)
    let JSIColor = UIColor(red: 64/255.0, green: 173/255.0, blue: 98/255.0, alpha: 1.0)
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // test
        print ("category friend count: " + friendArray.count.description)
        //print(friendArray[0].name)
        return friendArray.count+1
    }
    
    // extension: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        
        let friendCellCollection = collectionView.dequeueReusableCell(withReuseIdentifier: "friendCellCollection", for: indexPath) as! friendCollectionViewCell
        
        if(indexPath.row >= friendArray.count){
            friendCellCollection.friendName = "+" //Add a friend
            friendCellCollection.backgroundColor = frostColor
        } else{
            friendCellCollection.friendName = friendArray[indexPath.row].name
            if(friendArray[indexPath.row].color == JSIColor){
                //randomly set color of friend if user hasn't designated a color yet
                friendCellCollection.backgroundColor = colorArray[colorIndex]
                colorIndex = colorIndex + 1
            } else {
                friendCellCollection.backgroundColor = friendArray[indexPath.row].color
            }
        }
        
        friendCellCollection.friendNameFont = UIFont (name: "PingFangHK-Regular", size: 20)!
        
        return friendCellCollection
    }
    
    // extension: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        colorArray.append(rainColor)
        colorArray.append(salmonColor)
        colorArray.append(buttermilkColor)
        colorArray.append(lavenderColor)
        
        //let itemsPerRow: CGFloat = 4
        //let hardCodedPadding: CGFloat = 5
       // let itemWidth = (collectionView.bounds.width/itemsPerRow) - hardCodedPadding
        //let itemHeight = collectionView.bounds.height - (2*hardCodedPadding)
        collectionView.backgroundColor = JSIColor
        //return CGSize(width: itemWidth, height: itemHeight)
        //return CGSize(width: width+10, height: 80);
        return CGSize(width: 90, height: 80);
    }
}

extension String
{
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat
    {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height);
        
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return boundingBox.width;
    }
}
