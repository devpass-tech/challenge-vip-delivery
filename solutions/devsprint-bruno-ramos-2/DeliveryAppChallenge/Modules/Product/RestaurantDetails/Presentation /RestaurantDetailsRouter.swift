//
//  RestaurantDetailsRouter.swift
//  DeliveryAppChallenge
//
//  Created by bruna.drago on 25/01/22.
//

import UIKit

protocol RestaurantDetailsRoutingLogic {}

protocol RestaurantDetailsDataPassing {
    var dataStore: RestaurantDetailsDataStore? { get set }
}

typealias RestaurantDetailsRouterType = (RestaurantDetailsRoutingLogic & RestaurantDetailsDataPassing)

final class RestaurantDetailsRouter: RestaurantDetailsRouterType {
    
    weak var viewController: RestaurantDetailsViewController?
    var dataStore: RestaurantDetailsDataStore?
    
    init() {}
    
}
