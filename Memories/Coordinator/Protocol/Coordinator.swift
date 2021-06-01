//
//  Coordinator.swift
//  Memories
//
//  Created by Naomi Schettini on 5/30/21.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get }
    func start()
}
