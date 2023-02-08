//
//  Reusable.swift
//  ContactManagerUI
//
//  Created by sei_dev on 2/8/23.
//

import UIKit

protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

extension Reusable where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
