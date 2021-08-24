//
//  OrderDetailViewController.swift
//  FlowerPower
//
//  Created by Calin Jula on 24.08.2021.
//

import UIKit
import CoreLocation
class OrderDetailViewController: UIViewController {
    
    enum TableViewRow: Int, CaseIterable {
        case orderImage, orderDetails, customerLocation
        init(_ rawValue: Int) {
            switch rawValue {
                case 0:
                    self = .orderImage
                case 1:
                    self = .orderDetails
                case 2:
                    self = .customerLocation
                default:
                    fatalError("Failed to init TableViewRow enum in OrderDetailViewController")
            }
        }
    }
    
    @IBOutlet weak var detailsTableView: UITableView!
    
    var viewModel: OrderDetailsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getCurrentLocation().done { [weak self] in
            self?.detailsTableView.reloadRows(at: [IndexPath(row: TableViewRow.customerLocation.rawValue, section: 0)], with: .automatic)
        }
    }
}

extension OrderDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        TableViewRow.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch TableViewRow(indexPath.row) {
            case .orderImage:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderDetailImageCell.reuseIdentifier) as? OrderDetailImageCell else {
                    return UITableViewCell()
                }
                cell.configureCell(with: viewModel.imageUrlString)
                return cell
            case .orderDetails:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomerDetailsTableViewCell.reuseIdentifier) as? CustomerDetailsTableViewCell else {
                    return UITableViewCell()
                }
                cell.configureCell(name: viewModel.customerName,
                                   price: viewModel.price,
                                   order: viewModel.orderDescription)
                return cell
            case .customerLocation:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: MapLocationTableViewCell.reuseIdentifier) as? MapLocationTableViewCell else {
                    return UITableViewCell()
                }
                cell.configureCell(location: viewModel.customerCoordinates, distance: viewModel.distanceToCustomer)
                cell.delegate = self
                return cell
        }
    }
}

extension OrderDetailViewController: MapLocationTableViewCellDelegate {
    func didTapDirectionsButton() {
        viewModel.reverseGeoCodeCustomerLocation { mapItem in
            mapItem.openInMaps(launchOptions: nil)
        }
    }
}
