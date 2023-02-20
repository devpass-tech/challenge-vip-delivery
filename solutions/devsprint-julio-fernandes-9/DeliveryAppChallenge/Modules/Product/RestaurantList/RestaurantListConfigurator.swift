//
//  RestaurantListConfigurator.swift
//  DeliveryApp
//
//  Created by Alexandre Robaert on 19/02/23.
//  Copyright © 2023 Alexandre Robaert. All rights reserved.
//

import Foundation

enum RestaurantListConfigurantor {
    static func make(categoryFilter: String) -> RestaurantListViewController {
    
        let presenter = RestaurantListPresenter()
        let router = RestaurantListRouter()
        let interactor = RestaurantListInteractor(presenter: presenter, network: NetworkManager())
        let viewController = RestaurantListViewController(interactor: interactor, router: router, categoryFilter: categoryFilter)
        router.viewController = viewController
        presenter.viewController = viewController
        return viewController
    }
}
