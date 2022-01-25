//
//  RestaurantDetailsFactory.swift
//  DeliveryAppChallenge
//
//  Created by bruna.drago on 25/01/22.
//

import UIKit

enum RestaurantDetailsFactory: FeatureFactory {
    struct Dependencies {}
    
    static func make(with dependencies: Dependencies) -> UIViewController {
        let viewController = RestaurantDetailsViewController()
        return viewController
    }
    
}
