//
//  AppCoordinator.swift
//  WordDefinitions
//
//  Created by mohamed hassan on 14/02/2025.
//

import UIKit
import SwiftUI

class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        showSearchScreen()
    }
    /// **Show Search Screen**
    func showSearchScreen() {
        let viewModel = DictionaryViewModel()
        let searchView = SearchView(viewModel: viewModel, coordinator: self)
        let hostingController = UIHostingController(rootView: searchView)
        navigationController.setViewControllers([], animated: false)
        navigationController.setViewControllers([hostingController], animated: false)
    }
    /// **Show Word Details Screen**
    func showWordDetails(for wordDefinition: DictionaryWord) {
        let detailsView = WordDetailsView(wordDefinition: wordDefinition)
        let hostingController = UIHostingController(rootView: detailsView)
        navigationController.pushViewController(hostingController, animated: true)
    }
}
