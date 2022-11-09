//
//  SettingsConfigurator.swift
//  DeliveryAppChallenge
//
//  Created by Douglas Garcia on 09/11/22.
//

import UIKit

struct SettingsConfigurator {
    
    func makeViewController() -> UIViewController {
        let presenter = SettingsPresenter()
        let interactor = SettingsInteractor(presenter: presenter)
        let settingsView = SettingsView()
        let viewController = SettingsViewController(customView: settingsView, interactor: interactor)
        
        presenter.viewController = viewController
        
        return viewController
    }
}
