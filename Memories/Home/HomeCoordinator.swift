//
//  HomeCoordinator.swift
//  Memories
//
//  Created by Naomi Schettini on 5/30/21.
//

import UIKit

class HomeCoordinator {
    
    
    // MARK: - Properties
    
    let navigationController: UINavigationController
    
    
    // MARK: - Init
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    // MARK: - Methods
    
    func start() {
        let homeScreen = HomeViewController()
        navigationController.pushViewController(homeScreen, animated: true)
    }
    
}