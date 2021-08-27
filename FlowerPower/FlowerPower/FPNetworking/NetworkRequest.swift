//
//  NetworkRequest.swift
//  FlowerPower
//
//  Created by Calin Jula on 24.08.2021.
//

import Foundation

enum NetworkingError: Error {
    case malformedUrl
    case wrongStatusCode
    case noDataReturned
    case orderUpdateFailed
    
    var errorMessage: String {
        switch self {
            case .malformedUrl:
                return "network_error_malformed_url".localized
            case .noDataReturned, .wrongStatusCode:
                return "network_error_status_code".localized
            case .orderUpdateFailed:
                return "network_error_order_update".localized
        }
    }
}

class NetworkRequest {
    var httpMethod: HTTPMethod
    var path: String
    var domain: String
    var body: Encodable?
    
    init(with httpMethod: HTTPMethod, path: String, domain: String, requestBody: Encodable? = nil) {
        self.httpMethod = httpMethod
        self.path = path
        self.domain = domain
    }
}

extension NetworkRequest {
    func asUrlRequest() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = domain
        components.path = path
        guard let composedUrl = components.url else {
            throw NetworkingError.malformedUrl
        }
        var request = URLRequest(url: composedUrl)
        request.httpMethod = httpMethod.rawValue
        if let reqBody = body {
            request.httpBody = try reqBody.jsonEncoded()
        }
        return request
    }
}
