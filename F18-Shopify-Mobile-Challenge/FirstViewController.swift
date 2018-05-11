//
//  FirstViewController.swift
//  F18-Shopify-Mobile-Challenge
//
//  Created by Henry on 2018-05-05.
//  Copyright © 2018 DxStudio. All rights reserved.
//

import UIKit
import Alamofire

class FirstViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
//    let headerTitles = ["ayy", "lmao"]
//    let data = [["1.1", "1.2", "1.3"], ["2.1", "2.2", "2.3"]]
    let cellReuseIdentifier = "cell"
    
    var yearDict: [String: Int] = [:]
    var provinceDict: [String: Int] = [:]
    var sortedProvinceData: [(key: String, value: Int)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Regeister Table View Cell class & reuse ID
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        Requests.getData() { orders in
            for order in orders {
                if self.provinceDict[order.province] != nil {
                    self.provinceDict[order.province]! += 1
                } else {
                    self.provinceDict[order.province] = 1
                }
            }
//            print(self.provinceDict) // async probs... so gotta put inside completion closure
//            print(Array(self.provinceDict))
            self.sortedProvinceData = self.provinceDict.sorted(by: <)
//            print(self.sortedProvinceData)
            self.tableView.reloadData()
        }
    }
    
}

extension FirstViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
//        return data.count
        return provinceDict.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return data[section].count
        return 1 // there should only be 1 value in each row, which is the count in each province
    }
    
    // create cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
//        cell.textLabel?.text = data[indexPath.section][indexPath.row]
        // Convert dictionary to Arrays so we can access indexes for them
        cell.textLabel?.text = String(sortedProvinceData[indexPath.section].value) + " orders in \(sortedProvinceData[indexPath.section].key)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Cell # (\(indexPath.section), \(indexPath.row)) was selected")
        self.tableView.deselectRow(at: indexPath, animated: false) // "deselects" the highlight for cells
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // check if theres title for section
        // i.e. no title if # titles in headerTitles < # arrays in data
        if section < sortedProvinceData.count {
            return sortedProvinceData[section].key
        }
        return nil
    }
    
}

