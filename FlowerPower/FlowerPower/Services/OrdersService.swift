//
//  OrdersService.swift
//  FlowerPower
//
//  Created by Calin Jula on 24.08.2021.
//

import PromiseKit
import Foundation

class OrdersService {

    private var networkRequestable: NetworkRequestable
    private let apiRouter: ApiRouter
    
    init(networkRequestable: NetworkRequestable) {
        self.networkRequestable = networkRequestable
        self.apiRouter = .getAllOrders
    }
    
    func fetchOrders() -> Promise<[Order]> {
        let request = NetworkRequest(with: apiRouter.httpMethod,
                                         path: apiRouter.path,
                                         domain: apiRouter.baseUrlPath)
        return networkRequestable.perform(request: request).map { networkResponse in
            guard let status = networkResponse.httpStatus, status == 200 else {
                throw NetworkingError.wrongStatusCode
            }
            guard let data = networkResponse.responseData else {
                throw NetworkingError.noDataReturned
            }
            let orders = try JSONDecoder().decode([Order].self, from: data)
            return orders
        }
    }
}
