//
//  SettingsViewConfigurator.swift
//  DeliveryApp
//
//  Created by Guilherme Prata Costa on 02/08/22.
//

import UIKit

enum SettingsViewConfigurator: FeatureFactory {

    struct Dependencies {}

    static func make(with dependencies: Dependencies) -> UIViewController {
        let presenter = SettingsViewPresenter()
        let repository = SettingsViewRepository(network: NetworkManager())
        let useCase = SettingsViewUseCase(repository: repository)
        let interactor = SettingsViewInteractor(presenter: presenter, useCase: useCase)
        let controller = SettingsViewController(interactor: interactor)
        presenter.controller = controller
        return controller
    }
}
