//
//  RestaurantListRouter.swift
//  DeliveryAppChallenge
//
//  Created by Gustavo Tiecker on 25/01/22.
//

import UIKit

protocol RestaurantListRoutingLogic {}

protocol RestaurantListDataPassing {}

typealias RestaurantListRouterType = (RestaurantListRoutingLogic & RestaurantListDataPassing)

final class RestaurantListRouter: RestaurantListRouterType {
    
    weak var viewController: RestaurantListViewController?
    var dataStore: RestaurantListDataStore?
    
    init() {}
}
