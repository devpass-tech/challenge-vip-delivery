//
//  RestaurantDetailsConfigurator.swift
//  DeliveryAppChallenge
//
//  Created by bruna.drago on 25/01/22.
//

import UIKit

enum RestaurantDetailsConfigurator: FeatureFactory {
    struct Dependencies {}
    
    static func make(with dependencies: Dependencies) -> UIViewController {
        let view = RestaurantDetailsView()
        let presenter = RestaurantDetailsPresenter()
        let interactor = RestaurantDetailsInteractor(presenter: presenter)
        let router = RestaurantDetailsRouter()
        let viewController = RestaurantDetailsViewController(customView: view, interactor: interactor , router: router)
        
        view.delegate = viewController
        router.dataStore = interactor
        presenter.viewController = viewController
        
        return viewController
    }
}
