//
//  RestaurantListRouter.swift
//  DeliveryAppChallenge
//
//  Created by pedro tres on 08/06/22.
//

import Foundation
import UIKit

protocol RestaurantListRoutingLogic {
    func routeToNextModule()
}

protocol RestaurantListDataPassing {
    var dataStore: RestaurantListDataStore? { get }
}

typealias RestaurantListRouterType = (RestaurantListRoutingLogic & RestaurantListDataPassing)

final class RestaurantListRouter: RestaurantListRoutingLogic, RestaurantListDataPassing {
    weak var viewController: RestaurantListViewController?
    var dataStore: RestaurantListDataStore?

    init() {
    }

    func routeToNextModule() {
        let newViewController = UIViewController()
        viewController?.navigationController?.pushViewController(newViewController, animated: true)
    }
}
