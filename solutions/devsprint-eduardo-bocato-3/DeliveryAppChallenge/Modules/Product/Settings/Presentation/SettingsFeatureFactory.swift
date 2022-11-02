//
//  SettingsFeatureFactory.swift
//  DeliveryAppChallenge
//
//  Created by Douglas Garcia on 02/11/22.
//

import UIKit

enum SettingsFeatureFactory: FeatureFactory {
    struct Dependencies {}
    
    static func make(with dependencies: Dependencies) -> UIViewController {
        
        let repository = SettingsRepositoryImpl()
        let getSettings = GetSettings(repository: repository)
        let presenter = SettingsPresenter()
        let interactor = SettingsInteractor(presenter: presenter, getSettigns: getSettings)
        let view = SettingsView()
        let viewController = SettingsViewController(customView: view, interactor: interactor)
        
        presenter.viewController = viewController
        
        return viewController
    }
}
