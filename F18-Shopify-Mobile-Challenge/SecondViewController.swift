//
//  SecondViewController.swift
//  F18-Shopify-Mobile-Challenge
//
//  Created by Henry on 2018-05-05.
//  Copyright © 2018 DxStudio. All rights reserved.
//

import UIKit
import Alamofire

class SecondViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let cellReuseIdentifier = "cell"
    
    var yearDict: [String: Int] = [:]
    
//    func getData(completion: @escaping ()->()) {
//        var orders = [orderSummary]()
//
//        Alamofire.request("https://shopicruit.myshopify.com/admin/orders.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6").responseJSON() {
//            response in
//            guard response.result.isSuccess else {
//                print("Couldnt process JSON response")
//                return
//            }
//
//            // get as Dictionary
//            if let json = response.result.value as? [String: Any] {
//                // Get the total count of the orders
//                //                if let arr = json["orders"] as? NSArray {
//                //                    print(arr.count)
//                //                }
//                orders = orderContainer(dictionary: json).orders
//
//                for order in orders {
//                    if self.yearDict[order.year] != nil {
//                        //                        print("adding to key:", order.year)
//                        self.yearDict[order.year]! += 1
//                    } else {
//                        //                        print("first key:", order.year)
//                        self.yearDict[order.year] = 1
//                    }
//                    //                    print(order.year)
//                }
//            }
//            completion()
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Regeister Table View Cell class & reuse ID
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        Requests.getData() { orders in
            for order in orders {
                if self.yearDict[order.year] != nil {
                    self.yearDict[order.year]! += 1
                } else {
                    self.yearDict[order.year] = 1
                }
            }
//            print(self.yearDict) // async probs... so gotta put inside completion closure
            self.tableView.reloadData()
        }
    }

}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return yearDict.keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // there should only be 1 value in each row
    }
    
    // create cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        cell.textLabel?.text = String(Array(yearDict)[indexPath.section].value)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Cell # (\(indexPath.section), \(indexPath.row)) was selected")
        self.tableView.deselectRow(at: indexPath, animated: false) // "deselects" the highlight for cells
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < yearDict.keys.count {
            return Array(yearDict)[section].key
        }
        return nil
    }
    
}
