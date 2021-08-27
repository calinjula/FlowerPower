//
//  MapLocationTableViewCell.swift
//  FlowerPower
//
//  Created by Calin Jula on 24.08.2021.
//

import UIKit
import MapKit

protocol MapLocationTableViewCellDelegate: AnyObject {
    func didTapDirectionsButton()
}

class MapLocationTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "MapLocationTableViewCellId"

    @IBOutlet private weak var getDirectionsButton: UIButton!
    @IBOutlet private weak var deliveryAddressLabel: UILabel!
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var distanceLabel: UILabel!
    
    weak var delegate: MapLocationTableViewCellDelegate?
    
    func configureCell(viewModel: ClientLocationViewModelType) {
        localizeText()
        let annotation = MKPointAnnotation()
        annotation.coordinate = viewModel.customerCoordinates.coordinate
        mapView.addAnnotation(annotation)
        let mapRegion = MKCoordinateRegion(center: viewModel.customerCoordinates.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(mapRegion, animated: true)
        if let distanceToCustomer = viewModel.distanceToCustomer {
            distanceLabel.isHidden = false
            distanceLabel.text = "\("customer_position".localized) \(distanceToCustomer) \("customer_distance".localized)"
        } else {
            distanceLabel.isHidden = true
        }
    }
    
    private func localizeText() {
        getDirectionsButton.setTitle("get_directions".localized, for: .normal)
        deliveryAddressLabel.text = "delivery_address".localized
    }

    @IBAction func directionsButtonTapped(_ sender: Any) {
        delegate?.didTapDirectionsButton()
    }
}
