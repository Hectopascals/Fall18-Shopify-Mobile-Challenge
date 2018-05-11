//
//  OrderNode.swift
//  F18-Shopify-Mobile-Challenge
//
//  Created by Henry on 2018-05-10.
//  Copyright © 2018 DxStudio. All rights reserved.
//

import Foundation

class orderNode: NSObject {
    let orderYear: String
    let province: String
    let firstName: String
    let lastName: String
    let orderNumber: String
    let totalPrice: String
    
    convenience init?(dictionary: [String: Any]) {
        guard let year = dictionary["created_at"] as? String,
            let shippingAddr = dictionary["shipping_address"] as? [String: Any],
            let province = shippingAddr["province"] as? String,
            let firstName = shippingAddr["first_name"] as? String,
            let lastName = shippingAddr["last_name"] as? String,
            let orderNum = dictionary["order_number"] as? Int,
            let totalPrice = dictionary["total_price"] as? String
            else {
                print("Something couldnt be parsed")
                return nil
        }

        self.init(year: year, province: province, orderNum: orderNum, totalPrice: totalPrice, firstName: firstName, lastName: lastName)
    }
    
    init(year: String, province: String, orderNum: Int, totalPrice: String, firstName: String, lastName: String) {
        let index = year.index(year.startIndex, offsetBy: 3)
        self.orderYear = String(year[...index]) // truncate to first 4 numbers (year)
        self.province = province
        self.orderNumber = String(orderNum)
        self.totalPrice = totalPrice
        self.firstName = firstName
        self.lastName = lastName
    }
    
    // Convert array of dictionary to array of orderNode
    static func arrayInit(dictionary: [[String: Any]]) -> [orderNode] {
        var array = [orderNode]()
        array = dictionary.compactMap { item in
            orderNode(dictionary:item)
        }
        return array
    }
}
