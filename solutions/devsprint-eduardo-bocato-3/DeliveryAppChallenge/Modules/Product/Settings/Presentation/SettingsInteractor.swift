//
//  SettingsInteractor.swift
//  DeliveryAppChallenge
//
//  Created by Douglas Garcia on 02/11/22.
//

import Foundation

protocol SettingsBussinesLogic {
    func loadSettings(request: Settings.LoadData.Request)
}

final class SettingsInteractor {
    
    private let presenter: SettingsPresentationLogic
    private let getSettigns: GetSettingsUseCase
    
    init(presenter: SettingsPresentationLogic, getSettigns: GetSettingsUseCase) {
        self.presenter = presenter
        self.getSettigns = getSettigns
    }
}

extension SettingsInteractor: SettingsBussinesLogic {
    func loadSettings(request: Settings.LoadData.Request) {
        let response = Settings.LoadData.Response()
        presenter.presentSettings(response: response)
    }
}
