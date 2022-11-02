//
//  Settings.swift
//  DeliveryAppChallenge
//
//  Created by Douglas Garcia on 02/11/22.
//

import Foundation

enum Settings {
    enum LoadData {
        struct Request {}
        struct Response {}
        struct ViewModel {}
        
        enum Error: Swift.Error {
            case decodeFail
        }
    }
}
