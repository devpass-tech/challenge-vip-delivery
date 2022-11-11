//
//  SettingsConfigurator.swift
//  DeliveryAppChallenge
//
//  Created by Douglas Garcia on 09/11/22.
//

import UIKit

struct SettingsConfigurator {
    
    func makeViewController() -> UIViewController {
        let service = SettingsService()
        let useCase = GetSettingsUseCase(service: service)
        let presenter = SettingsPresenter()
        let interactor = SettingsInteractor(presenter: presenter, getSettingsUseCase: useCase)
        let settingsView = SettingsView()
        let viewController = SettingsViewController(customView: settingsView, interactor: interactor)
        
        presenter.viewController = viewController
        
        return viewController
    }
}
