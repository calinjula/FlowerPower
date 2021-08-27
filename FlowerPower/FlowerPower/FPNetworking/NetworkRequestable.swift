//
//  NetworkRequestable.swift
//  FlowerPower
//
//  Created by Calin Jula on 24.08.2021.
//

import PromiseKit

protocol NetworkRequestable {
    func perform(request: NetworkRequest) -> Promise<NetworkResponse>
}
