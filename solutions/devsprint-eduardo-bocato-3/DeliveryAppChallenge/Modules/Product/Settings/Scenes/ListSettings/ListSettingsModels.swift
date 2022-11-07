//
//  Settings.swift
//  DeliveryAppChallenge
//
//  Created by Douglas Garcia on 02/11/22.
//

import Foundation

enum ListSettings {
    enum FetchData {
        struct Request {}
        
        struct Response {
            var settings: Settings
        }
        
        struct ViewModel {
            
        }
        
        enum Error: Swift.Error {
            case decodeFail
        }
    }
}
