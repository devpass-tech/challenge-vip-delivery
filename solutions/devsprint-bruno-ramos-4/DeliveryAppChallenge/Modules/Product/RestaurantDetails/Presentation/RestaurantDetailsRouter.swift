//
//  RestaurantDetailsRouter.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Cardoso on 07/06/22.
//

import Foundation

protocol RestaurantDetailsRoutingLogic {
    func routeToNextModule()
}

protocol RestaurantDetailsDataPassing {
    var dataStore: RestaurantDetailsDataStore? { get }
}

typealias RestaurantDetailsRouterType = (RestaurantDetailsRoutingLogic & RestaurantDetailsDataPassing)

final class RestaurantDetailsRouter: RestaurantDetailsRoutingLogic, RestaurantDetailsDataPassing {
    weak var viewController: RestaurantDetailsViewController?
    var dataStore: RestaurantDetailsDataStore?

    init() { }

    func routeToNextModule() {}
}
