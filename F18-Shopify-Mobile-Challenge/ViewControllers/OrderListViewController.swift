//
//  OrderListViewController.swift
//  F18-Shopify-Mobile-Challenge
//
//  Created by Henry on 2018-05-10.
//  Copyright © 2018 DxStudio. All rights reserved.
//

import UIKit

// VC to populate list of order numbers from selected province
class OrderListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    let cellReuseIdentifier = "orderNumberCell"
    var orderNums : [basicMetadata] = [] // data should be loaded from Segue sender
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.barTintColor = UIColor.white

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension OrderListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderNums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        cell.textLabel?.text = "Order #" + orderNums[indexPath.row].orderNum
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
