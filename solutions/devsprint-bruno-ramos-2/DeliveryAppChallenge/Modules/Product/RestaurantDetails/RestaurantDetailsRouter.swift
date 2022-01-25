//
//  RestaurantDetailsRouter.swift
//  DeliveryAppChallenge
//
//  Created by bruna.drago on 25/01/22.
//

import UIKit

protocol RestaurantDetailsRoutingLogic {}

protocol RestaurantDetailsDataPassing {}

typealias RestaurantDetailsRouterType = (RestaurantDetailsRoutingLogic & RestaurantDetailsDataPassing)

final class RestaurantDetailsRouter: RestaurantDetailsRoutingLogic, RestaurantDetailsDataPassing {
    
    weak var viewController: RestaurantDetailsViewController?
    
    
}