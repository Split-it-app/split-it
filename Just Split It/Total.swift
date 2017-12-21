//
//  Total.swift
//  Just Split It
//
//  Created by Muhammad Joyo on 12/20/17.
//

import UIKit

class Total: NSObject {
	var friend: Friend
	var total: int
	
	
	override init(user: Friend, personalTotal: int){
		friend = user
		total = personalTotal
	}
}
