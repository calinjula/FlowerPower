//
//  CustomerDetailsTableViewCell.swift
//  FlowerPower
//
//  Created by Calin Jula on 24.08.2021.
//

import UIKit

class CustomerDetailsTableViewCell: UITableViewCell {

    static let reuseIdentifier = "CustomerDetailsTableViewCellId"
    
    @IBOutlet private weak var customerNameDescriptionLabel: UILabel!
    @IBOutlet private weak var orderDescriptionLabel: UILabel!
    @IBOutlet private weak var priceDescriptionLabel: UILabel!
    @IBOutlet private weak var nameValueLabel: UILabel!
    @IBOutlet private weak var orderValueLabel: UILabel!
    @IBOutlet private weak var priceValueLabel: UILabel!
    
    func configureCell(name: String, price: String, order: String) {
        localizeText()
        nameValueLabel.text = name
        priceValueLabel.text = price
        orderValueLabel.text = order
    }
    
    private func localizeText() {
        customerNameDescriptionLabel.text = "Name:"
        orderDescriptionLabel.text = "Order:"
        priceDescriptionLabel.text = "Price:"
    }
}
