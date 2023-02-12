//
//  SettingsNetworkRequest.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Robaert on 12/02/23.
//  Copyright © 2023 Alexandre Robaert. All rights reserved.
//

import Foundation

enum SettingsNetworkRequest: NetworkRequest {
    
    case fetchData
    
    var pathURL: String {
        return "user_settings.json"
    }
    
    var method: HTTPMethod {
        return .get
    }
}
