//
//  OrderDetailImageCell.swift
//  FlowerPower
//
//  Created by Calin Jula on 24.08.2021.
//

import UIKit
import AlamofireImage

class OrderDetailImageCell: UITableViewCell {
    
    static let reuseIdentifier = "OrderDetailImageCellId"

    @IBOutlet private weak var networkImageView: UIImageView!
    
    func configureCell(with imageUrl: String) {
        guard let url = URL(string: imageUrl) else {
            return
        }
        networkImageView.af.setImage(withURL: url, placeholderImage: UIImage(named: "flower-placeholder"))
    }
}
