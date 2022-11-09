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
        let item = response.data.convertSettingModel()
        let viewModel = SettingsList.LoadSettings.ViewModel(item: item)
        viewController?.displayData(viewModel: viewModel)
    }
}
