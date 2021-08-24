//
//  Customer.swift
//  FlowerPower
//
//  Created by Calin Jula on 24.08.2021.
//

import Foundation

class Customer: Decodable {
    let id: Int
    let name: String
    let latitude: Double
    let longitude: Double
}
