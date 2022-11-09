//
//  SettingsModel.swift
//  DeliveryAppChallenge
//
//  Created by Douglas Garcia on 08/11/22.
//

import Foundation

enum SettingsList {
    enum LoadSettings {
        struct Request {}
        
        struct Response {
            var data: SettingsResponse
        }
        
        struct ViewModel {
            var item: Settings
        }
    }
}
