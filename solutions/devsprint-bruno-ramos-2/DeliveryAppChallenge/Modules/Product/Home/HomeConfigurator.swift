//
//  HomeConfigurator.swift
//  DeliveryAppChallenge
//
//  Created by Leonardo Mendes on 30/01/22.
//

import UIKit

/// Used to initialize the whole module
enum HomeConfigurator: FeatureFactory {
    /// Struct used to initialize dependences needed on module
    struct Dependencies {
    }

    static func make(with dependencies: Dependencies) -> UIViewController {
        let presenter = HomePresenter()

        let networkManager = NetworkManager()
        let worker = HomeWorker(network: networkManager)
        let interactor = HomeInteractor(presenter: presenter, worker: worker)

        let router = HomeRouter()
        let view = HomeView()
        let viewController = HomeViewController(customView: view, interactor: interactor, router: router)

        view.delegate = viewController
        router.dataStore = interactor
        presenter.viewController = viewController

        return viewController
    }
}
