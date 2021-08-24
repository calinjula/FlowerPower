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
    
    var httpMethod: HTTPMethod {
        switch self {
            case .getAllOrders,
                 .getAllCustomers:
                return HTTPMethod.get
        }
    }
    
    var path: String {
        switch self {
            case .getAllOrders:
                return "/orders"
            case .getAllCustomers:
                return "/customers"
        }
    }
    
    var baseUrlPath: String { "demo8202908.mockable.io" }
}
