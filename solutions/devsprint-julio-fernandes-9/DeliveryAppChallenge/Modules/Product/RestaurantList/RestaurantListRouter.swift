//
//  RestaurantListRouter.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Robaert on 19/02/23.
//  Copyright (c) 2023 Alexandre Robaert. All rights reserved.
//

import UIKit

protocol RestaurantListRouting {
    
    func routeTo(_ route: RestaurantListModel.Route)
}

final class RestaurantListRouter {
    
    public weak var viewController: UIViewController?
}


// MARK: - RestaurantListRouting
extension RestaurantListRouter: RestaurantListRouting {
    
    func routeTo(_ route: RestaurantListModel.Route) {
        DispatchQueue.main.async {
            switch route {
            case .goToRestaurantDetail:
                self.showRestaurantDetailt()
            }
        }
    }
}


// MARK: - Private Zone
private extension RestaurantListRouter {
    
    func showRestaurantDetailt() {
        viewController?.navigationController?.pushViewController(RestaurantDetailsViewController(), animated: true)
    }
}
