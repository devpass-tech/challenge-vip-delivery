//
//  SettingsViewPresenter.swift
//  DeliveryApp
//
//  Created by Guilherme Prata Costa on 02/08/22.
//

import Foundation

final class SettingsViewPresenter {
    weak var controller: SettingsViewControllerOutput?
}

extension SettingsViewPresenter: SettingsViewPresenterProtocol {
    func fetchedSuccessData(data: SettingsViewResponse) {}
    func fetchedErrorData() {}
}
