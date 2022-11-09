//
//  SettingsPresenterSpy.swift
//  DeliveryAppChallengeTests
//
//  Created by Douglas Garcia on 09/11/22.
//

import Foundation
@testable import DeliveryAppChallenge

final class SettingsPresenterSpy: SettingsPresentationLogic {

    private(set) var presentDataCalled = false
    
    var viewController: DeliveryAppChallenge.SettingsViewControllerDisplayLogic?
    
    func presentData(response: DeliveryAppChallenge.SettingsList.LoadSettings.Response) {
        presentDataCalled = true
    }
}
