//
//  RestaurantListFeatureFactory.swift
//  DeliveryAppChallenge
//
//  Created by Gustavo Tiecker on 25/01/22.
//

import UIKit

enum RestaurantListFeatureFactory: FeatureFactory {
    
    struct Dependencies {}
    
    static func make(with dependencies: Dependencies) -> UIViewController {
        let viewController = RestaurantListViewController()
        return viewController
    }
}
