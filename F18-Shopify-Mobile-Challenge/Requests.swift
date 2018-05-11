//
//  Requests.swift
//  F18-Shopify-Mobile-Challenge
//
//  Created by Henry on 2018-05-05.
//  Copyright © 2018 DxStudio. All rights reserved.
//

import Foundation
import Alamofire

// Struct Orders
struct orderContainer {
    let orders: [orderSummary]
    
    init(dictionary: [String: Any]) {
        guard let orderDict = dictionary["orders"] as? [[String: Any]] else {
            self.init(orders: [])
            return
        }
        // initialize orders as an array of orderSummary, which we'll then set to our orders param
        let orders = orderSummary.arrayInit(dictionary: orderDict)
        self.init(orders: orders)
    }
    
    init(orders: [orderSummary]) {
        self.orders = orders
    }
    
}

// OrderSummary
class orderSummary: NSObject {
    let year: String
    let province: String
    //    let numOrdersByProvince: Int
    //    let numOrdersByYear: Int
    
    convenience init?(dictionary: [String: Any]) {
        // now we're looking at each individual order
        guard let year = dictionary["created_at"] as? String,
        let billingAddr = dictionary["billing_address"] as? [String: Any],
        let province = billingAddr["province"] as? String
            else { return nil }
        
        self.init(year: year, province: province)
    }
    
    init(year: String, province: String) {
        let index = year.index(year.startIndex, offsetBy: 3)
        self.year = String(year[...index]) // truncate to first 4 numbers (year)
        self.province = province
    }
    
    static func arrayInit(dictionary: [[String: Any]]) -> [orderSummary] {
        var array = [orderSummary]()
        array = dictionary.compactMap { item in
            orderSummary(dictionary:item)
        }
        return array
    }
}

struct Requests {
    static func getData(completion: @escaping (_ orders: [orderSummary]) -> Void) {
        var orders = [orderSummary]()
        
        Alamofire.request("https://shopicruit.myshopify.com/admin/orders.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6").responseJSON() {
            response in
            guard response.result.isSuccess else {
                print("Couldnt process JSON response")
                return
            }
            
            // get as Dictionary
            if let json = response.result.value as? [String: Any] {
                // Get the total count of the orders
                //                if let arr = json["orders"] as? NSArray {
                //                    print(arr.count)
                //                }
                orders = orderContainer(dictionary: json).orders
            }
            completion(orders)
        }
    }
}
