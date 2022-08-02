//
//  SettingsViewInteractor.swift
//  DeliveryApp
//
//  Created by Guilherme Prata Costa on 02/08/22.
//

import Foundation


final class SettingsViewInteractor {
    let presenter: SettingsViewPresenterProtocol

    init(presenter: SettingsViewPresenterProtocol) {
        self.presenter = presenter
        self.useCase = useCase
    }
}

extension SettingsViewInteractor: SettingsViewInteractorProtocol {}
