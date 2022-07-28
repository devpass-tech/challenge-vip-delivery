//
//  RestaurantListConfigurator.swift
//  DeliveryApp
//
//  Created by Vinicius dos Reis Morgado Brancalliao on 27/07/22.
//

import UIKit

enum RestaurantListConfigurator: FeatureFactory {
    struct Dependencies {}
    
    static func make(with dependencies: Dependencies) -> UIViewController {
        let presenter = RestaurantListPresenter()
        let repository = RestaurantListRepository(network: NetworkManager())
        let useCase = RestaurantListUseCase(repository: repository)
        let interactor = RestaurantListInteractor(presenter: presenter, useCase: useCase)
        let viewController = RestaurantListViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
