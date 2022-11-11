//
//  SettingsInteractor.swift
//  DeliveryAppChallenge
//
//  Created by Douglas Garcia on 08/11/22.
//

import Foundation

final class SettingsInteractor: SettingsBusinessLogic {
    
    var presenter: SettingsPresentationLogic
    let getSettingsUseCase: GetSettingsUseCaseProtocol
    
    init(presenter: SettingsPresentationLogic, getSettingsUseCase: GetSettingsUseCaseProtocol) {
        self.presenter = presenter
        self.getSettingsUseCase = getSettingsUseCase
    }
    
    func loadData(request: SettingsList.LoadSettings.Request) {
        getSettingsUseCase.execute { result in
            switch result {
            case let .success(settings):
                self.presenter.presentData(response: .init(data: settings))
            case let .failure(error):
                self.presenter.presentError(error: error)
            }
        }
    }
}
