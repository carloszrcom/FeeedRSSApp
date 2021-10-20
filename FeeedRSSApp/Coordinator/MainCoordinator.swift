//
//  MainCoordinator.swift
//  FeeedRSSApp
//
//  Created by Carlos ZR on 19/10/21.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController
    
    // MARK: - Initializers
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    
    func start() {
        let vc = ViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goDetailViewController(data: String) {
        let detailView = DetailViewController.instantiate()
        detailView.contenidoWeb = data
        navigationController.pushViewController(detailView, animated: true)
    }
}
