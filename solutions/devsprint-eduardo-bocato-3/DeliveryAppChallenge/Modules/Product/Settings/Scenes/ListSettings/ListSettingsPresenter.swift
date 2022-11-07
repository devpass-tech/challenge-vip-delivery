//
//  SettingsPresenter.swift
//  DeliveryAppChallenge
//
//  Created by Douglas Garcia on 02/11/22.
//

import Foundation

protocol SettingsPresentationLogic {
    func presentFetchSettings(response: ListSettings.FetchData.Response)
    func presentFetchFailureSettings(error: ListSettings.FetchData.Error)
}

final class SettingsPresenter: SettingsPresentationLogic {
    
    weak var viewController: SettingsDisplayLogic?
    
    func presentFetchSettings(response: ListSettings.FetchData.Response) {
        let viewModel = ListSettings.FetchData.ViewModel()
        viewController?.displaySettings(viewModel: viewModel)
    }
    
    func presentFetchFailureSettings(error: ListSettings.FetchData.Error) {
        // TODO:
    }
}
