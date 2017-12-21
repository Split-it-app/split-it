//
//  Total.swift
//  Just Split It
//
//  Created by Muhammad Joyo on 12/20/17.
//

import UIKit

class Total: NSObject {
	var friend: Friend
	var total: Int
	
	
	init(user: Friend, personalTotal: Int){
		friend = user
		total = personalTotal
	}
}
