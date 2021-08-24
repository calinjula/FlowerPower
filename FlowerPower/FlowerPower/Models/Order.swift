//
//  Order.swift
//  FlowerPower
//
//  Created by Calin Jula on 24.08.2021.
//

import Foundation

enum OrderStatus: String, Decodable {
    case new, pending, delivered
    
    var systemImageName: String {
        switch self {
            case .pending: return "clock.arrow.2.circlepath"
            case .delivered: return "shippingbox.fill"
            case .new: return "envelope.open.fill"
        }
    }
}

struct Order: Decodable {
    let id: Int
    let orderDescription: String
    let price: Double
    let customerId: Int
    let imageUrl: String
    let status: OrderStatus
    
    enum CodingKeys: String, CodingKey {
        case id, price, status
        case orderDescription = "description"
        case customerId = "customer_id"
        case imageUrl = "image_url"
    }
}
