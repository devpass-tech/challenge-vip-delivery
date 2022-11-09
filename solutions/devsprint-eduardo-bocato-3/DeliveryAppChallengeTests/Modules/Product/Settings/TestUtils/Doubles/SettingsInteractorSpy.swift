//
//  SettingsInteractorSpy.swift
//  DeliveryAppChallengeTests
//
//  Created by Douglas Garcia on 09/11/22.
//

import Foundation
@testable import DeliveryAppChallenge

final class SettingsInteractorSpy: SettingsBusinessLogic {
    
    var presenter: SettingsPresentationLogic
    private(set) var loadDataCalled = false
    
    init(presenter: SettingsPresentationLogic) {
        self.presenter = presenter
    }
    
    func loadData(request: SettingsList.LoadSettings.Request) {
        loadDataCalled = true
    }
}
