//
//  RestaurantListConfigurator.swift
//  DeliveryAppChallenge
//
//  Created by pedro tres on 08/06/22.
//

import UIKit

enum RestaurantListConfigurator: FeatureFactory {
    struct Dependencies {}
    
    static func make(with dependencies: Dependencies) -> UIViewController {
        
        let view = RestaurantListView()
        let presenter = RestaurantListPresenter()
        let interactor = RestaurantListInteractor(presenter: presenter)
        let router = RestaurantListRouter()
        let viewController = RestaurantListViewController(
            customView: view,
            interactor: interactor,
            router: router
        )
        presenter.viewController = viewController
        router.viewController = viewController
        
        return viewController
    }
}
