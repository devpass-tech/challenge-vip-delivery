//
//  RestaurantListRouter.swift
//  DeliveryAppChallenge
//
//  Created by Gustavo Tiecker on 25/01/22.
//

import UIKit

protocol RestaurantListRoutingLogic {
    func routeToRestaurantDetail()
}

protocol RestaurantListDataPassing {
    var dataStore: RestaurantListDataStore? { get set }
}

typealias RestaurantListRouterType = (RestaurantListRoutingLogic & RestaurantListDataPassing)

final class RestaurantListRouter: RestaurantListRouterType {
    
    weak var viewController: UIViewController?
    var dataStore: RestaurantListDataStore?
    
    init() {}

    func routeToRestaurantDetail() {
        let destination = RestaurantDetailsConfigurator.make(with: .init(restaurantId: ""))
        viewController?.navigationController?.pushViewController(destination, animated: true)
    }
}
