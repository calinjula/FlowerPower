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
    
    func getCustomer(for order: Order) -> Customer? {
        return allCustomers.first { $0.id == order.customerId }
    }
}
