//
//  SettingsViewEndpoint.swift
//  DeliveryApp
//
//  Created by Guilherme Prata Costa on 02/08/22.
//

import Foundation

struct SettingsViewEndpoint: NetworkRequest {
    var pathURL: String = "user_settings.json"
    var method: HTTPMethod = .get
}
