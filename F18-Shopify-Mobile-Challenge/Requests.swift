//
//  Requests.swift
//  F18-Shopify-Mobile-Challenge
//
//  Created by Henry on 2018-05-05.
//  Copyright © 2018 DxStudio. All rights reserved.
//

import Foundation
import Alamofire

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}

// Handles the API request
struct Requests {
    static func getData(completion: @escaping (_ orders: [orderNode]) -> Void) {
        var orders = [orderNode]()
        
        Alamofire.request("https://shopicruit.myshopify.com/admin/orders.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6").responseJSON() {
            response in
            guard response.result.isSuccess else {
                print("Couldnt process JSON response")
                return
            }
            
            // parse as Dictionary
            if let json = response.result.value as? [String: Any] {
                orders = orderContainer(dictionary: json).orders
            }
            completion(orders)
        }
    }
}

