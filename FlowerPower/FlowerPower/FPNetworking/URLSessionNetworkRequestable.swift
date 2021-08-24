//
//  URLSessionNetworkRequestable.swift
//  FlowerPower
//
//  Created by Calin Jula on 24.08.2021.
//

import PromiseKit
import Foundation

class URLSessionNetworkRequestable: NetworkRequestable {
    
    func perform(request: NetworkRequest) -> Promise<NetworkResponse> {
        let (promise, resolver) = Promise<NetworkResponse>.pending()
        do {
            let urlRequest = try request.asUrlRequest()
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let networkError = error {
                    resolver.reject(networkError)
                } else {
                    let requestResponse = response as? HTTPURLResponse
                    let networkResponse = NetworkResponse(status: requestResponse?.statusCode, data: data)
                    resolver.resolve(.fulfilled(networkResponse))
                }
            }.resume()
        }
        catch {
            resolver.reject(error)
        }
        return promise
    }
}
