//
//  Encodable+Ext.swift
//  FlowerPower
//
//  Created by Calin Jula on 27.08.2021.
//

import Foundation

extension Encodable {
    
    func jsonEncoded() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}
