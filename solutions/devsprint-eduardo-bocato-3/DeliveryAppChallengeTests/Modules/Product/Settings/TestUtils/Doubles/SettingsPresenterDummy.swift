//
//  SettingsPresenterDummy.swift
//  DeliveryAppChallengeTests
//
//  Created by Douglas Garcia on 09/11/22.
//

import Foundation
@testable import DeliveryAppChallenge

final class SettingsPresenterDummy: SettingsPresentationLogic {
    
    var viewController: SettingsViewControllerDisplayLogic?
    
    func presentData(response: SettingsList.LoadSettings.Response) {}
}
