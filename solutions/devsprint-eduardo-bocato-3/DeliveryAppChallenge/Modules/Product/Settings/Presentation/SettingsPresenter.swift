//
//  SettingsPresenter.swift
//  DeliveryAppChallenge
//
//  Created by Douglas Garcia on 02/11/22.
//

import Foundation

protocol SettingsPresentationLogic {
    func presentSettings(response: Settings.LoadData.Response)
}

final class SettingsPresenter {
    
    weak var viewController: SettingsDisplayLogic?
}

extension SettingsPresenter: SettingsPresentationLogic {
    func presentSettings(response: Settings.LoadData.Response) {
        debugPrint("🚀 SettingsPresenter")
        let viewModel = Settings.LoadData.ViewModel()
        viewController?.displaySettings(viewModel: viewModel)
    }
}
