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

    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var distanceLabel: UILabel!
    
    weak var delegate: MapLocationTableViewCellDelegate?
    
    func configureCell(location: CLLocation, distance: String?) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = location.coordinate
        mapView.addAnnotation(annotation)
        let mapRegion = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(mapRegion, animated: true)
        if let distanceToCustomer = distance {
            distanceLabel.isHidden = false
            distanceLabel.text = "The customer is \(distanceToCustomer) meters away"
        } else {
            distanceLabel.isHidden = true
        }
    }

    @IBAction func directionsButtonTapped(_ sender: Any) {
        delegate?.didTapDirectionsButton()
    }
}
