//
//  RestaurantDetailsFactory.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Cardoso on 07/06/22.
//

import UIKit

enum RestaurantDetailsConfigurator: FeatureFactory {
    struct Dependencies {}
    
    static func make(with dependencies: Dependencies) -> UIViewController {
        let view = RestaurantDetailsView()
        let presenter = RestaurantDetailsPresenter()
        let interactor = RestaurantDetailsInteractor(presenter: presenter)
        let router = RestaurantDetailsRouter()
        let viewController = RestaurantDetailsViewController(
            customView: view,
            interactor: interactor,
            router: router
        )
        presenter.viewController = viewController
        router.viewController = viewController
        
        return viewController
    }
}
