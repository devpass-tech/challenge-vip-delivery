//
//  SettingsResponse.swift
//  DeliveryAppChallenge
//
//  Created by Douglas Garcia on 08/11/22.
//

import Foundation

struct SettingsResponse: Decodable {
    var name: String
    var email: String
    var address: String
    var paymentMethod: String
}

extension SettingsResponse {
    
    func convertSettingModel() -> Settings {
        return Settings(
            name: self.name,
            email: self.email,
            address: self.address,
            paymentMethod: self.paymentMethod
        )
    }
}
