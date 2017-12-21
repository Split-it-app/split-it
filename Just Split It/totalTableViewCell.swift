//
//  totalTableViewCell.swift
//  Just Split It
//
//  Created by Muhammad Joyo on 12/20/17.
//

import UIKit

class totalTableViewCell: UITableViewCell {

	@IBOutlet weak var Name: UILabel!
	@IBOutlet weak var TotalValue: UILabel!
	
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
