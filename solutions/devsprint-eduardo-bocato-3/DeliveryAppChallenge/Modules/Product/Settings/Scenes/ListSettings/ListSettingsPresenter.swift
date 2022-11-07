//
//  SettingsPresenter.swift
//  DeliveryAppChallenge
//
//  Created by Douglas Garcia on 02/11/22.
//

import Foundation

protocol SettingsPresentationLogic {
    func presentSettingsList(response: SettingsList.FetchData.Response)
    func presentSettingsListFailure(error: SettingsList.FetchData.Error)
}

final class SettingsPresenter: SettingsPresentationLogic {
    
    weak var viewController: SettingsDisplayLogic?
    
    func presentSettingsList(response: SettingsList.FetchData.Response) {
        let viewModel = SettingsList.FetchData.ViewModel()
        viewController?.displaySettings(viewModel: viewModel)
    }
    
    func presentSettingsListFailure(error: SettingsList.FetchData.Error) {
        viewController?.displayFailure(error: error)
    }
}
