//
//  SettingsFeatureFactory.swift
//  DeliveryAppChallenge
//
//  Created by Douglas Garcia on 02/11/22.
//

import UIKit

struct SettingsFactory {
    
    func makeViewController() -> UIViewController {
        let service = SettingsAPI()
        let worker = SettingsWorker(settingsService: service)
        let presenter = SettingsPresenter()
        let interactor = SettingsInteractor(presenter: presenter, settingsWorker: worker)
        let view = SettingsView()
        let viewController = SettingsViewController(customView: view, interactor: interactor)
        
        presenter.viewController = viewController
        
        return viewController
    }
}
