//
//  CategoryListUseCases.swift
//  DeliveryAppChallenge
//
//  Created by Matheus Lenke on 10/11/22.
//

import Foundation

enum CategoryList {
    enum FetchRestaurants {
        struct Request {
            
        }

        struct Response {
            let data: [Restaurant]
        }

        struct ViewModel {
            let items: [Restaurant]
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
