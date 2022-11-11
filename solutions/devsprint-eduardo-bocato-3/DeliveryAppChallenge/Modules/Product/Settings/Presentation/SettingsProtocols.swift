//
//  SettingsProtocols.swift
//  DeliveryAppChallenge
//
//  Created by Douglas Garcia on 08/11/22.
//

import UIKit

protocol SettingsBusinessLogic {
    var presenter: SettingsPresentationLogic { get set }
    func loadData(request: SettingsList.LoadSettings.Request)
}

protocol SettingsPresentationLogic {
    var viewController: SettingsViewControllerDisplayLogic? { get set }
    func presentData(response: SettingsList.LoadSettings.Response)
    func presentError(error: SettingsList.LoadSettings.Error)
}

protocol SettingsViewControllerDisplayLogic: AnyObject {
    var interactor: SettingsBusinessLogic { get set }
    func displayData(viewModel: SettingsList.LoadSettings.ViewModel)
    func displayError(error: SettingsList.LoadSettings.Error)
}

typealias SettingsCustomViewInterface = (UIView & SettingsViewInterface)
protocol SettingsViewInterface {
    func displayItem(item: Settings)
}
