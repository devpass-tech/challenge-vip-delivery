//
//  MenuItemConfigurator.swift
//  DeliveryApp
//
//  Created by Vinicius dos Reis Morgado Brancalliao on 29/07/22.
//

import UIKit

enum MenuItemConfigurator: FeatureFactory {
    struct Dependencies {}
    
    static func make(with dependencies: Dependencies) -> UIViewController {
        let presenter = MenuItemPresenter()
        let repository = MenuItemRepository(network: NetworkManager())
        let useCase = MenuItemUseCase(repository: repository)
        let interactor = MenuItemInteractor(presenter: presenter, useCase: useCase)
        let controller = MenuItemViewController(interactor: interactor)
        presenter.viewController = controller
        return controller
    }
}
