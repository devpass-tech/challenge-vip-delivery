//
//  HomeViewConfigurator.swift
//  DeliveryApp
//
//  Created by Julio Fernandes on 26/07/22.
//

import UIKit

enum HomeViewConfigurator: FeatureFactory {
    
    struct Dependencies {}
    
    static func make(with dependencies: Dependencies) -> UIViewController {
        let presenter = HomeViewPresenter()
        let network = NetworkManager()
        let settingsWorker = SettingsViewRepository(network: network)
        let repository = HomeViewRepository(network: network, settingsWorker: settingsWorker)
        let useCase = HomeViewUseCase(repository: repository)
        let interactor = HomeViewInteractor(presenter: presenter, useCase: useCase)
        let controller = HomeViewController(interactor: interactor)
        presenter.controller = controller
        return controller
    }
}
