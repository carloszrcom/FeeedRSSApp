//
//  Coordinator.swift
//  FeeedRSSApp
//
//  Created by Carlos ZR on 19/10/21.
//

import Foundation
import UIKit

protocol Coordinator {
    // Propiedad del protocolo con sus métodos get y set (métodos accesores).
    var navigationController: UINavigationController { get set }
    func start()
}
