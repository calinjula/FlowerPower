//
//  String+Ext.swift
//  FlowerPower
//
//  Created by Calin Jula on 27.08.2021.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
