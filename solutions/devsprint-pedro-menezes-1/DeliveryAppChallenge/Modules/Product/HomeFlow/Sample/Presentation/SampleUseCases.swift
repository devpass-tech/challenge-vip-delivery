//
//  SampleUseCase.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 21/01/22.
//

import Foundation

enum Sample {
    enum FetchData {
        struct Request {
            
        }

        struct Response {
            let data: String
        }

        enum ViewModel {
            case filled(data: String)
            case retry
            case error
        }
    }

    enum Error {
        struct Response {
            let error: Swift.Error
        }

        struct ViewModel {
            let message: String
        }
    }
}
