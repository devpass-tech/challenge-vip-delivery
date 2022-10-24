//
//  RestaurantDetailsConfigurator.swift
//  DeliveryApp
//
//  Created by Julio Fernandes on 04/08/22.
//

import UIKit

enum RestaurantDetailsConfigurator: FeatureFactory {
    
    struct Dependencies {}
    
    static func make(with dependencies: Dependencies) -> UIViewController {
        let presenter = RestaurantDetailsPresenter()
        let repository = RestaurantDetailRepository(network: NetworkManager())
        let useCase = RestaurantDetailsUseCase(repository: repository)
        let interactor = RestaurantDetailsInteractor(presenter: presenter, useCase: useCase)
        let controller = RestaurantDetailsViewController(interactor: interactor)
        presenter.controller = controller
        return controller
    }
}
