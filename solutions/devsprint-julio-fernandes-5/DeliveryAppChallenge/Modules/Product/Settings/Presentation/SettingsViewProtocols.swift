//
//  SettingsViewProtocols.swift
//  DeliveryApp
//
//  Created by Guilherme Prata Costa on 02/08/22.
//

import Foundation

protocol SettingsViewInteractorProtocol {
    func fetchData()
}

protocol SettingsViewPresenterProtocol {
    func fetchedSuccessData(data: SettingsViewResponse)
    func fetchedErrorData()
}

protocol SettingsViewControllerOutput: AnyObject {}
