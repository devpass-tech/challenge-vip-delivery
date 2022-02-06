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

        enum Response {
            case success(Home)
            case failure(Error)
        }

        struct ViewModel {
        }
    }
}
