//
//  friendCollectionViewCell.swift
//  Just Split It
//
//  Created by Maria-Belem on 12/10/17.
//

import UIKit

class friendCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var friendNameLabel: UILabel!;
    
    static let friendNameFont:UIFont = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.thin);
    
    var friendName: String = ""
    {
        didSet
        {
            friendNameLabel.text = friendName;
        }
    }
}
