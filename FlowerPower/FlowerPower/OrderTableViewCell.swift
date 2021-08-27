//
//  OrderTableViewCell.swift
//  FlowerPower
//
//  Created by Calin Jula on 24.08.2021.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "OrderTableViewCellId"

    @IBOutlet private weak var statusImage: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var customerNameLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    
    func configureCell(for order: Order, and customer: Customer) {
        descriptionLabel.text = order.orderDescription
        customerNameLabel.text = customer.name
        priceLabel.text = "\(order.price) $"
        statusImage.image = UIImage(systemName: order.status.systemImageName)
        tintImage(for: order.status)
    }
    
    private func tintImage(for status: OrderStatus) {
        switch status {
            case .new:
                statusImage.tintColor = UIColor.systemPink
            case .delivered:
                statusImage.tintColor = UIColor.systemGreen
            case .pending:
                statusImage.tintColor = UIColor.systemOrange
        }
    }
}
