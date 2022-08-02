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
        let interactor = SettingsViewInteractor(presenter: presenter)
        let controller = SettingsViewController(interactor: interactor)
        presenter.controller = controller
        return controller
    }
}
