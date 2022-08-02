//
//  SettingsViewInteractor.swift
//  DeliveryApp
//
//  Created by Guilherme Prata Costa on 02/08/22.
//

import Foundation


final class SettingsViewInteractor {
    let presenter: SettingsViewPresenterProtocol
    let useCase: SettingsViewUseCaseProtocol

    init(presenter: SettingsViewPresenterProtocol, useCase: SettingsViewUseCaseProtocol) {
        self.presenter = presenter
        self.useCase = useCase
    }
}

extension SettingsViewInteractor: SettingsViewInteractorProtocol {
    func fetchData() {
        useCase.execute { [weak self] result in
            switch result {
            case .success(let settings): self?.presenter.fetchedSuccessData(data: settings)
            case .failure: self?.presenter.fetchedErrorData()
            }
        }
    }
}
