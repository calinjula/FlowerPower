//
//  OrderDetailsViewModel.swift
//  FlowerPower
//
//  Created by Calin Jula on 24.08.2021.
//

import MapKit
import PromiseKit

class OrderDetailsViewModel {
    
    let imageUrlString: String
    let customerCoordinates: CLLocation
    let customerName: String
    let price: String
    let orderDescription: String
    
    var currentUserLocation: CLLocation?
    
    init(order: Order, customer: Customer) {
        self.imageUrlString = order.imageUrl
        customerCoordinates = CLLocation(latitude: customer.latitude, longitude: customer.longitude)
        customerName = customer.name
        price = "$\(order.price)"
        orderDescription = order.orderDescription
    }
    
    func reverseGeoCodeCustomerLocation(_ completionHandler: @escaping (MKMapItem) -> Void) {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(customerCoordinates) { [weak self] locations, error in
            if error == nil, let returnedLocation = locations?.first {
                let mapItem = MKMapItem(placemark: MKPlacemark(placemark: returnedLocation))
                completionHandler(mapItem)
            } else {
                guard let customerCoordinates = self?.customerCoordinates else {
                    return
                }
                let placemark = MKPlacemark(coordinate: customerCoordinates.coordinate, addressDictionary: nil)
                let mapItem = MKMapItem(placemark: placemark)
                completionHandler(mapItem)
            }
        }
    }
    
    func getCurrentLocation() -> Promise<Void> {
        CLLocationManager.requestLocation().map { [weak self] locations in
            self?.currentUserLocation = locations.last
        }.asVoid()
    }
    
    var distanceToCustomer: String? {
        guard let distanceInMeters = currentUserLocation?.distance(from: customerCoordinates) else {
            return nil
        }
        if distanceInMeters.isLess(than: 1000) {
            return "\(distanceInMeters) m"
        } else {
            let distanceInKilometers = distanceInMeters / 1000
            return String(format: "%.2f km", distanceInKilometers)
        }
    }
    
}
