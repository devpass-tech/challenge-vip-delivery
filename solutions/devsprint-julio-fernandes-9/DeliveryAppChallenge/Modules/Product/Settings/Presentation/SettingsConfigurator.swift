//
//  SettingsConfigurator.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Robaert on 12/02/23.
//  Copyright © 2023 Alexandre Robaert. All rights reserved.
//

import Foundation
import UIKit

enum SettingsConfigurator {
    
    static func makeSettings() -> UIViewController {
        let presenter = SettingsPresenter()
        let interactor = SettingsInteractor(network: NetworkManager(), presenter: presenter, dataSource: .init())
        let router = SettingsRouter()
        let viewController = SettingsViewController(interactor: interactor, router: router)
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }
}
