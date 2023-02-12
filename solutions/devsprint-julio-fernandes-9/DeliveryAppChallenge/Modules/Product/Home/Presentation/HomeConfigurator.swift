//
//  HomeConfigurator.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Robaert on 11/02/23.
//  Copyright © 2023 Alexandre Robaert. All rights reserved.
//

import Foundation

enum HomeConfigurator {
    
    static func makeHome() -> HomeViewController {
        let presenter = HomePresenter()
        let router = HomeRouter()
        let interactor = HomeInteractor(networking: NetworkManager(), presenter: presenter)
        let homeViewController = HomeViewController(interactor: interactor, router: router)
        presenter.viewController = homeViewController
        router.viewController = homeViewController
        return homeViewController
    }
}
