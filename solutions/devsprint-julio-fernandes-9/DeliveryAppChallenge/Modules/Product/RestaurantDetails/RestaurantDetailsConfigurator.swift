//
//  RestaurantDetailsConfigurator.swift
//  DeliveryApp
//
//  Created by Alexandre Robaert on 20/02/23.
//  Copyright © 2023 Alexandre Robaert. All rights reserved.
//

import Foundation

enum RestaurantDetailsConfigurator {
    static func make() -> RestaurantDetailsViewController {
        let router = RestaurantDetailsRouter()
        let presenter = RestaurantDetailsPresenter()
        let interactor = RestaurantDetailsInteractor(network: NetworkManager(), presenter: presenter)
        let viewController = RestaurantDetailsViewController(interactor: interactor, router: router)
        router.viewController = viewController
        presenter.viewController = viewController
        return viewController
    }
}
