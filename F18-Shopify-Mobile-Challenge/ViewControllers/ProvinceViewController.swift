//
//  ProvinceViewController.swift
//  F18-Shopify-Mobile-Challenge
//
//  Created by Henry on 2018-05-05.
//  Copyright © 2018 DxStudio. All rights reserved.
//

import UIKit
import Alamofire

class ProvinceViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let cellReuseIdentifier = "cell"
    var orderNumbers : [basicMetadata] = []
    var metadata: basicMetadata = basicMetadata(firstName: "", lastName: "", orderTotal: "", orderNum: "")
    var provinceInfoDict: [String: [basicMetadata]] = [:]
    var sortedProvinceDict: [(key: String, value: [basicMetadata])] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Regeister Table View Cell class & reuse ID
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        Requests.getData() { orders in
            for order in orders {
                // Get all the relevant metadata
                self.metadata = basicMetadata(firstName: order.firstName, lastName: order.lastName, orderTotal: order.totalPrice, orderNum: order.orderNumber)
                
                // Store them into provinceInfoDict
                if self.provinceInfoDict[order.province] != nil {
                    self.provinceInfoDict[order.province]! += [self.metadata]
                } else { // array is empty
                    self.provinceInfoDict[order.province] = [self.metadata]
                }

            }
            // Async so gotta do inside completion closure
            self.sortedProvinceDict = self.provinceInfoDict.sorted {
                return $0.key < $1.key
            }
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let orderListVC = segue.destination as? OrderListViewController {
            orderListVC.orderNums = orderNumbers
        }
    }
}

extension ProvinceViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sortedProvinceDict.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // there should only be 1 value in each row, which is the count in each province
    }
    
    // create cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        let sectionData = sortedProvinceDict[indexPath.section]
        cell.textLabel?.text = String(sectionData.value.count) + " orders in \(sectionData.key)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Cell # (\(indexPath.section), \(indexPath.row)) was selected")
        orderNumbers = sortedProvinceDict[indexPath.section].value
        performSegue(withIdentifier: "OrderListViewControllerSegue", sender: orderNumbers)
        self.tableView.deselectRow(at: indexPath, animated: true) // "deselects" the highlight for cells
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // check if theres title for section
        // i.e. no title if # titles in headerTitles < # arrays in data
        if section < sortedProvinceDict.count {
            return sortedProvinceDict[section].key
        }
        return nil
    }
    
    // Header styling
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.medium);
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
}

