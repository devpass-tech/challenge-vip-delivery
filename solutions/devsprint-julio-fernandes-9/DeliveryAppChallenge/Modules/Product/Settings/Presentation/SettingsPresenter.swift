//
//  SettingsPresenter.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Robaert on 12/02/23.
//  Copyright (c) 2023 Alexandre Robaert. All rights reserved.
//

import Foundation

protocol SettingsPresentationLogic {
    func presentResponse(_ response: SettingsModel.Response)
}

final class SettingsPresenter {
    public weak var viewController: SettingsDisplayLogic?
}


// MARK: - SettingsPresentationLogic
extension SettingsPresenter: SettingsPresentationLogic {
    
    func presentResponse(_ response: SettingsModel.Response) {
        switch response {
        case .fetchDataView(let response):
            presentViewModel(with: response)
        case .fetchDataViewWithError(let message):
            presentViewModel(with: message)
        }
    }
}


// MARK: - Private Zone
private extension SettingsPresenter {
    
    func presentViewModel(with response: SettingsNetworkResponse) {
        viewController?.displayViewModel(.dataView(entity: response))
    }
    
    func presentViewModel(with messageError: String) {
        viewController?.displayViewModel(.dataViewWithError(messageError: messageError))
    }
}
