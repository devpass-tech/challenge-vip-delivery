//
//  RestaurantDetailsConfigurator.swift
//  DeliveryAppChallenge
//
//  Created by bruna.drago on 25/01/22.
//

import UIKit

enum RestaurantDetailsConfigurator: FeatureFactory {
    struct Dependencies {
        let restaurantId: String
    }
    
    static func make(with dependencies: Dependencies) -> UIViewController {
        let view = RestaurantDetailsView()
        let presenter = RestaurantDetailsPresenter()
        let networkManager = NetworkManager()
        let apiDataSource = RestaurantDetailsApiDataSource(network: networkManager)
        let cacheDataSource = RestaurantDetailsCacheDataSource()

        let repository = GetRestaurantDetailsRepositoryImpl(
            primaryDataSource: cacheDataSource,
            secondDataSource: apiDataSource
        )

        let getRestaurantDetails = GetRestaurantDetails(repository: repository)
        let interactor = RestaurantDetailsInteractor(
            presenter: presenter,
            getRestaurantDetails: getRestaurantDetails,
            restaurantId: dependencies.restaurantId
        )
        let router = RestaurantDetailsRouter()
        let viewController = RestaurantDetailsViewController(customView: view, interactor: interactor , router: router)
        
        view.delegate = viewController
        router.viewController = viewController
        router.dataStore = interactor
        presenter.viewController = viewController
        
        return viewController
    }
}
