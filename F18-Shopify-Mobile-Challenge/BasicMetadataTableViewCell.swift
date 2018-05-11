//
//  BasicMetadataTableViewCell.swift
//  F18-Shopify-Mobile-Challenge
//
//  Created by Henry on 2018-05-08.
//  Copyright © 2018 DxStudio. All rights reserved.
//

import UIKit

// TableViewCell to set corresponding nib details
class BasicMetadataTableViewCell: UITableViewCell {

    @IBOutlet weak var orderNumLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    // Set cell details for Orders by Year
    func setCell(name: String, orderNum: String, orderTotal: String) {
        orderNumLabel.text = "#" + orderNum
        nameLabel.text = name
        totalPriceLabel.text = "$" + orderTotal
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
