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

final class RestaurantDetailsRouter: RestaurantDetailsRoutingLogic {
    weak var viewController: RestaurantDetailsViewController?

    init() { }

    func routeToNextModule() {}
}
