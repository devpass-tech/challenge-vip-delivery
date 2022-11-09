//
//  SettingsViewSpy.swift
//  DeliveryAppChallengeTests
//
//  Created by Douglas Garcia on 09/11/22.
//

import Foundation
@testable import DeliveryAppChallenge

final class SettingsViewSpy: SettingsViewInterface {
    
    private(set) var displayItemCalled = true
    
    func displayItem(item: Settings) {
        displayItemCalled = true
    }
}
