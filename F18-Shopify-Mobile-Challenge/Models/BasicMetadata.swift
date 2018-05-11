//
//  BasicMetadata.swift
//  F18-Shopify-Mobile-Challenge
//
//  Created by Henry on 2018-05-10.
//  Copyright © 2018 DxStudio. All rights reserved.
//

import Foundation

// Structure to hold all the useful data from parsing the JSON
struct basicMetadata {
    let firstName: String
    let lastName: String
    let orderTotal: String
    let orderNum: String
    let fullName: String
    
    init(firstName: String, lastName: String, orderTotal: String, orderNum: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.orderTotal = orderTotal
        self.orderNum = orderNum
        self.fullName = firstName + " " + lastName
    }
}
