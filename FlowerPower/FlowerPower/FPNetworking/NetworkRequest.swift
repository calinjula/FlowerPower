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
    
    var errorMessage: String {
        switch self {
            case .malformedUrl:
                return "Ooops, seems like there is a bug in our code! Please contact our support representatives."
            case .noDataReturned, .wrongStatusCode:
                return "Ooops, our servers are not cooperating today. Tap here or pull to try again!"
        }
    }
}

public class NetworkRequest {
    var httpMethod: HTTPMethod
    var path: String
    var domain: String
    
    init(with httpMethod: HTTPMethod, path: String, domain: String) {
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
        return request
    }
}
