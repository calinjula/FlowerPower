//
//  ErrorTableViewCell.swift
//  FlowerPower
//
//  Created by Calin Jula on 24.08.2021.
//

import UIKit

class ErrorTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "ErrorTableViewCellId"

    @IBOutlet private weak var errorMessageLabel: UILabel!
    
    func configureMessage(for error: Error) {
        if let networkError = error as? NetworkingError {
            errorMessageLabel.text = networkError.errorMessage
        } else {
            errorMessageLabel.text = "error_pull_to_refresh".localized
        }
    }
}
