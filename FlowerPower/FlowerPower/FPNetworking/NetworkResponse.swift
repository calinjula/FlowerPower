//
//  NetworkResponse.swift
//  FlowerPower
//
//  Created by Calin Jula on 24.08.2021.
//

import Foundation

public class NetworkResponse {
    var responseData: Data?
    var httpStatus: Int?
    
    init(status: Int?, data: Data? = nil) {
        self.responseData = data
        self.httpStatus = status
    }
}
