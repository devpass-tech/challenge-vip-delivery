//
//  RestaurantDetailsRouter.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Robaert on 20/02/23.
//  Copyright (c) 2023 Alexandre Robaert. All rights reserved.
//

import UIKit

protocol RestaurantDetailsRouting {
    func routeTo(_ route: RestaurantDetailsModel.Route)
}

final class RestaurantDetailsRouter {
    weak var viewController: RestaurantDetailsDisplayLogic?
}

// MARK: - RestaurantDetailsRouting
extension RestaurantDetailsRouter: RestaurantDetailsRouting {
    
    func routeTo(_ route: RestaurantDetailsModel.Route) {
        DispatchQueue.main.async {
            switch route {
            case .goToMenuItem:
                self.showMenuItem()
            }
        }
    }
}

// MARK: - Private Zone
private extension RestaurantDetailsRouter {
    
    func showMenuItem() {
        viewController?.navigationController?.pushViewController(MenuItemConfigurator.make(), animated: true)
    }
}
