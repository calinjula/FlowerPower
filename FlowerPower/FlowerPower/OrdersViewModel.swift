//
//  OrdersViewModel.swift
//  FlowerPower
//
//  Created by Calin Jula on 24.08.2021.
//

import PromiseKit
import MapKit

class OrdersViewModel {
    
    private var allOrders = [Order]()
    private var allCustomers = [Customer]()
    var error: Error?
    
    private func fetchOrders() -> Promise<Void> {
        OrdersService(networkRequestable: URLSessionNetworkRequestable())
            .fetchOrders()
            .map { [weak self] orders in
                self?.allOrders = orders
                return
            }
    }
    
    private func fetchCustomers() -> Promise<Void> {
        CustomersService(networkRequestable: URLSessionNetworkRequestable())
            .fetchCustomers()
            .map { [weak self] customers in
                self?.allCustomers = customers
                return
            }
    }
    
    func fetchOrdersAndCustomers() -> Promise<Void> {
        when(fulfilled: [fetchCustomers(), fetchOrders()])
    }
    
    var numberOfOrders: Int {
        if error == nil {
            return allOrders.count
        } else {
            return 1
        }
    }
    
    var doesErrorExists: Bool {
        return error != nil
    }
    
    func getOrder(for index: Int) -> Order? {
        return allOrders[safe: index]
    }
    
    func getChangeStatus(for index: Int) -> [OrderStatus] {
        guard let order = getOrder(for: index) else { return [] }
        return OrderStatus.allCases.filter { $0 != order.status }
    }
    
    func getCustomer(for order: Order) -> Customer? {
        return allCustomers.first { $0.id == order.customerId }
    }
    
    private func changeStatus(for order: Order, to newStatus: OrderStatus) -> Promise<Void> {
        let updateOrderService = UpdateOrderService(networkRequestable: URLSessionNetworkRequestable())
        return updateOrderService.update(order: order, newStatus: newStatus)
    }
    
    func changeStatusWithRefresh(for order: Order, to newStatus: OrderStatus) -> Promise<Void> {
        return changeStatus(for: order, to: newStatus).then { [weak self] _ -> Promise<Void> in
            if self != nil {
                return self!.fetchOrdersAndCustomers()
            } else {
                return Promise { resolver in
                    resolver.fulfill(())
                }
            }
        }
    }
}
