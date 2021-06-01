//
//  HomeCoordinator.swift
//  Memories
//
//  Created by Naomi Schettini on 5/30/21.
//

import UIKit
import Combine

class HomeCoordinator {
    
    // MARK: - Properties
    
    let navigationController: UINavigationController
    let viewModel: HomeViewModel = HomeViewModel()
    
    // MARK: - Init
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    // MARK: - Methods
    
    func start() {
        let homeScreen = HomeViewController(viewModel: self.viewModel)
        navigationController.viewControllers.append(homeScreen)
        navigationController.popToRootViewController(animated: true)
    }
    
}
