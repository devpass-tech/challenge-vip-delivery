//
//  HomeUseCases.swift
//  DeliveryAppChallenge
//
//  Created by Leonardo Mendes on 30/01/22.
//

import Foundation

enum HomeUseCase {
    enum FetchData {
        struct Request {
        }

        struct Response {
        }

        struct ViewModel {
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
