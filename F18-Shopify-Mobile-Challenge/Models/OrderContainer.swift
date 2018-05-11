//
//  OrderContainer.swift
//  F18-Shopify-Mobile-Challenge
//
//  Created by Henry on 2018-05-10.
//  Copyright © 2018 DxStudio. All rights reserved.
//

import Foundation

struct orderContainer {
    let orders: [orderNode]
    
    init(dictionary: [String: Any]) {
        guard let orderDict = dictionary["orders"] as? [[String: Any]] else {
            self.init(orders: [])
            return
        }
        // initialize orders as an array of orderNode, which we'll then set to our orders param
        // helps clear out nils
        let orders = orderNode.arrayInit(dictionary: orderDict)
        self.init(orders: orders)
    }
    
    init(orders: [orderNode]) {
        self.orders = orders
    }
    
}
