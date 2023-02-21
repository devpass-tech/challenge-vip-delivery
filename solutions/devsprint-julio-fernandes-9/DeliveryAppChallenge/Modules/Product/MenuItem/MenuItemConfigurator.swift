//
//  MenuItemConfigurator.swift
//  DeliveryApp
//
//  Created by Alexandre Robaert on 21/02/23.
//  Copyright © 2023 Alexandre Robaert. All rights reserved.
//

import Foundation

enum MenuItemConfigurator {
    static func make() -> MenuItemViewController {
        let router = MenuItemRouter()
        let presenter = MenuItemPresenter()
        let interactor = MenuItemInteractor(presenter: presenter, network: NetworkManager())
        let viewController = MenuItemViewController(interactor: interactor, router: router)
        router.viewController = viewController
        presenter.viewController = viewController
        return viewController
    }
}
