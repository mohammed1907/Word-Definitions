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
    
    func showSearchScreen() {
        let viewModel = SearchViewModel(dictionaryService: DictionaryService(), cacheManager: CoreDataManager.shared)
        let searchView = SearchView(viewModel: viewModel, coordinator: self)
        let hostingController = UIHostingController(rootView: searchView)
        navigationController.setViewControllers([], animated: false)
        navigationController.setViewControllers([hostingController], animated: false)
    }
    func showWordDetails(for wordDefinition: DictionaryWord) {
        let viewModel = WordDetailsViewModel(wordDefinition: wordDefinition)
        let detailsView = WordDetailsView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: detailsView)

        DispatchQueue.main.async {
            self.navigationController.pushViewController(hostingController, animated: true)
        }
    }
}
