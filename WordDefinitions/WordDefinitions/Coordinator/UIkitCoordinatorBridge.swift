//
//  UIkitCoordinatorBridge.swift
//  WordDefinitions
//
//  Created by mohamed hassan on 15/02/2025.
//

import SwiftUI
import UIKit

struct UIKitCoordinatorView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let navController = UINavigationController()
        let coordinator = AppCoordinator(navigationController: navController)
        coordinator.start()
        return navController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
