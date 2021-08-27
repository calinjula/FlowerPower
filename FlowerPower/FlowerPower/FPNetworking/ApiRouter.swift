//
//  ApiRouter.swift
//  FlowerPower
//
//  Created by Calin Jula on 24.08.2021.
//

import Foundation

enum ApiRouter {
    case getAllOrders
    case getAllCustomers
    case updateOrder
    
    var httpMethod: HTTPMethod {
        switch self {
            case .getAllOrders,
                 .getAllCustomers:
                return .get
            case .updateOrder:
                return .post
        }
    }
    
    var path: String {
        switch self {
            case .getAllOrders:
                return "/orders"
            case .getAllCustomers:
                return "/customers"
            case .updateOrder:
                return "/order/update"
        }
    }
    
    var baseUrlPath: String { "demo8202908.mockable.io" }
}
