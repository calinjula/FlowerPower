//
//  Order.swift
//  FlowerPower
//
//  Created by Calin Jula on 24.08.2021.
//

import Foundation

enum OrderStatus: String, Codable, CaseIterable {
    case new, pending, delivered
    
    var systemImageName: String {
        switch self {
            case .pending: return "clock.arrow.2.circlepath"
            case .delivered: return "shippingbox.fill"
            case .new: return "envelope.open.fill"
        }
    }
    
    var actionText: String {
        switch self {
            case .new: return "order_change_new".localized
            case .pending: return "order_change_pending".localized
            case .delivered: return "order_change_delivered".localized
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
