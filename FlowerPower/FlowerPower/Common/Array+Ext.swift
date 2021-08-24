//
//  Array+Ext.swift
//  FlowerPower
//
//  Created by Calin Jula on 24.08.2021.
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        guard (startIndex..<endIndex).contains(index) else {
            return nil
        }
        return self[index]
    }
}
