//
//  CustomerDetailsTableViewCell.swift
//  FlowerPower
//
//  Created by Calin Jula on 24.08.2021.
//

import UIKit

class CustomerDetailsTableViewCell: UITableViewCell {

    static let reuseIdentifier = "CustomerDetailsTableViewCellId"
    
    @IBOutlet private weak var customerDetailsLabel: UILabel!
    @IBOutlet private weak var customerNameDescriptionLabel: UILabel!
    @IBOutlet private weak var orderDescriptionLabel: UILabel!
    @IBOutlet private weak var priceDescriptionLabel: UILabel!
    @IBOutlet private weak var nameValueLabel: UILabel!
    @IBOutlet private weak var orderValueLabel: UILabel!
    @IBOutlet private weak var priceValueLabel: UILabel!
    
    func configureCell(viewModel: ClientDetailsViewModelType) {
        localizeText()
        nameValueLabel.text = viewModel.customerName
        priceValueLabel.text = viewModel.price
        orderValueLabel.text = viewModel.orderDescription
    }
    
    private func localizeText() {
        customerNameDescriptionLabel.text = "\("name".localized):"
        orderDescriptionLabel.text = "\("order".localized):"
        priceDescriptionLabel.text = "\("price".localized):"
        customerDetailsLabel.text = "customer_details".localized
    }
}
