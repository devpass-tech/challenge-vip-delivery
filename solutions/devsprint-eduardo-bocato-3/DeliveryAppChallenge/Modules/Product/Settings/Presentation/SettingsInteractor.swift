//
//  SettingsInteractor.swift
//  DeliveryAppChallenge
//
//  Created by Douglas Garcia on 08/11/22.
//

import Foundation

final class SettingsInteractor: SettingsBusinessLogic {
    
    var presenter: SettingsPresentationLogic
    
    init(presenter: SettingsPresentationLogic) {
        self.presenter = presenter
    }
    
    func loadData(request: SettingsList.LoadSettings.Request) {
        let data = SettingsResponse(
            name: "John Appleseed",
            email: "john@apple.com",
            address: "Rua Bela Cintra, 495 - Consolação",
            paymentMethod: "Cartão de Crédito"
        )

        let response = SettingsList.LoadSettings.Response(data: data)
        presenter.presentData(response: response)
    }
}
