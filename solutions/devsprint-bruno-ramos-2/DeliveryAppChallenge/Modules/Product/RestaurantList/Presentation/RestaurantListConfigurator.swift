//
//  RestaurantListConfigurator.swift
//  DeliveryAppChallenge
//
//  Created by Gustavo Tiecker on 25/01/22.
//

import UIKit

enum RestaurantListConfigurator: FeatureFactory {
    
    struct Dependencies {}
    
    static func make(with dependencies: Dependencies) -> UIViewController {
        let view = RestaurantListView()
        let presenter = RestaurantListPresenter()
        let networkManager = NetworkManager()
        let worker = RestaurantListWorker(network: networkManager)
        let interactor = RestaurantListInteractor(presenter: presenter, worker: worker)
        let router = RestaurantListRouter()
        let viewController = RestaurantListViewController(customView: view, interactor: interactor, router: router)
        
        view.delegate = viewController
        router.dataStore = interactor
        presenter.viewController = viewController
        
        return viewController
    }
}
