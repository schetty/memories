//
//  HomeCoordinator.swift
//  Memories
//
//  Created by Naomi Schettini on 5/30/21.
//

import UIKit

final public class AppCoordinator: Coordinator {
    // MARK: - Properties

    let navigationController: UINavigationController

    // MARK: - Private properties

    private let window: UIWindow

    // MARK: - Init

    init(window: UIWindow) {
        self.navigationController = UINavigationController()
        self.window = window
    }
    
    // MARK: - Methods

       func start() {
           window.rootViewController = navigationController
           window.makeKeyAndVisible()

           let homeCoordinator = HomeCoordinator(navigationController: navigationController)
           homeCoordinator.start()
       }

}
