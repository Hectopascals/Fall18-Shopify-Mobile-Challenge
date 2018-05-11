//
//  YearViewController.swift
//  F18-Shopify-Mobile-Challenge
//
//  Created by Henry on 2018-05-05.
//  Copyright © 2018 DxStudio. All rights reserved.
//

import UIKit
import Alamofire

class YearViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let cellReuseIdentifier = BasicMetadataTableViewCell.className
    var metadata: basicMetadata = basicMetadata(firstName: "", lastName: "", orderTotal: "", orderNum: "")
    var yearInfoDict: [String: [basicMetadata]] = [:]
    var sortedInfoDict: [(key: String, value: [basicMetadata])] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register Table View Cell nib & reuse ID
        tableView.register(UINib(nibName: BasicMetadataTableViewCell.className, bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        Requests.getData() { orders in
            for order in orders { // parse each order
                // Get all the relevant metadata
                self.metadata = basicMetadata(firstName: order.firstName, lastName: order.lastName, orderTotal: order.totalPrice, orderNum: order.orderNumber)

                // Store them into yearInfoDict
                if self.yearInfoDict[order.orderYear] != nil {
                    self.yearInfoDict[order.orderYear]! += [self.metadata]
                } else { // dict entry is empty
                    self.yearInfoDict[order.orderYear] = [self.metadata]
                }
            }
            self.sortedInfoDict = self.yearInfoDict.sorted {
                return $0.key > $1.key
            }
            // Async so gotta do inside completion closure
            self.tableView.reloadData()
        }
    }
}

extension YearViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sortedInfoDict.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numOrdersToDisplay = sortedInfoDict[section].value.count
        return numOrdersToDisplay > 10 ? 10 : numOrdersToDisplay // display at most 10 rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! BasicMetadataTableViewCell
        
        let data = sortedInfoDict[indexPath.section].value[indexPath.row]
        cell.setCell(name: data.fullName, orderNum: data.orderNum, orderTotal: data.orderTotal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Cell # (\(indexPath.section), \(indexPath.row)) was selected")
        self.tableView.deselectRow(at: indexPath, animated: false) // "deselects" the highlight for cells
    }
    
    // Handles Section Headers
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < sortedInfoDict.count { //infoDict.keys.count
            return sortedInfoDict[section].key + " (\(String(sortedInfoDict[section].value.count)))"
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.medium);
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
}
