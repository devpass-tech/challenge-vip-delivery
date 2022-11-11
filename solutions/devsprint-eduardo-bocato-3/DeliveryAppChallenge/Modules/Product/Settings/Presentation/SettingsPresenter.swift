//
//  SettingsPresenter.swift
//  DeliveryAppChallenge
//
//  Created by Douglas Garcia on 08/11/22.
//

import Foundation

final class SettingsPresenter: SettingsPresentationLogic {
    
    weak var viewController: SettingsViewControllerDisplayLogic?
    
    func presentData(response: SettingsList.LoadSettings.Response) {
        let settings = response.data.convertSettingModel()
        viewController?.displayData(viewModel: .init(item: settings))
    }
    
    func presentError(error: SettingsList.LoadSettings.Error) {
        viewController?.displayError(error: error)
    }
}
