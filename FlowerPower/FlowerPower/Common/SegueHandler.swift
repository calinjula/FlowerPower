//
//  SegueHandler.swift
//  FlowerPower
//
//  Created by Calin Jula on 24.08.2021.
//

import UIKit

protocol SegueHandlerType where Self: UIViewController {
    associatedtype SegueIdentifier: RawRepresentable where SegueIdentifier.RawValue == String
    func segueIdentifier(_ rawValue: String?) -> SegueIdentifier
}

extension SegueHandlerType {
    
    func performSegue(withIdentifier segueIdentifier: SegueIdentifier, sender: AnyObject?) {
        performSegue(withIdentifier: segueIdentifier.rawValue, sender: sender)
    }
    
    func segueIdentifier(_ rawValue: String?) -> SegueIdentifier {
        guard let rawValue = rawValue,
              let identifier = SegueIdentifier(rawValue: rawValue) else {
            fatalError("Wrong segue identifier \(rawValue ?? "")")
        }
        return identifier
    }
    
}
