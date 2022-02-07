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

        // MARK: - Interactor
        let apiDataSource = HomeApiDataSource(network: networkManager)
        let cacheDataSource = HomeCacheDataSource()
        let repository = GetHomeRepositoryImpl(primaryDataSource: cacheDataSource,
                                                          secondaryDataSource: apiDataSource)

        let getHome = GetHome(repository: repository)
        let interactor = HomeInteractor(presenter: presenter,
                                        getHome: getHome)

        let router = HomeRouter()
        let view = HomeView()
        let viewController = HomeViewController(customView: view,
                                                interactor: interactor,
                                                router: router)

        view.delegate = viewController
        router.dataStore = interactor
        presenter.viewController = viewController

        return viewController
    }
}
