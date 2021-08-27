//
//  UpdateOrderService.swift
//  FlowerPower
//
//  Created by Calin Jula on 27.08.2021.
//

import PromiseKit

struct UpdateOrderBody: Encodable {
    var orderId: Int
    var newStatus: OrderStatus
}

class UpdateOrderService {
    private var networkRequestable: NetworkRequestable
    private let apiRouter: ApiRouter
    
    init(networkRequestable: NetworkRequestable) {
        self.networkRequestable = networkRequestable
        self.apiRouter = .updateOrder
    }
    
    func update(order: Order, newStatus: OrderStatus) -> Promise<Void> {
        let requestBody = UpdateOrderBody(orderId: order.id, newStatus: newStatus)
        let request = NetworkRequest(with: apiRouter.httpMethod,
                                     path: apiRouter.path,
                                     domain: apiRouter.baseUrlPath,
                                     requestBody: requestBody)
        return networkRequestable.perform(request: request).map { networkResponse in
            guard let status = networkResponse.httpStatus, status == 200 else {
                throw NetworkingError.orderUpdateFailed
            }
            return
        }
    }
}
