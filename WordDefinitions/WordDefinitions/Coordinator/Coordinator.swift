//
//  Coordinator.swift
//  WordDefinitions
//
//  Created by mohamed hassan on 14/02/2025.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}
