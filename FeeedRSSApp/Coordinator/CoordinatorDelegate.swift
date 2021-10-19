//
//  CoordinatorDelegate.swift
//  FeeedRSSApp
//
//  Created by Carlos ZR on 19/10/21.
//

import Foundation
import UIKit

protocol CoordinatorDelegate {
    static func instantiate() -> Self
}

extension CoordinatorDelegate where Self: UIViewController {
    static func instantiate() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(identifier: id) as Self // as! Self
    }
}
