//
//  AddressSearchUseCases.swift
//  DeliveryAppChallenge
//
//  Created by Renato F. dos Santos Jr on 12/02/23.
//

import Foundation

enum AddressSearchModel {
    enum Request {
        case fetchDataView
        case filterBy(_ value: String)
    }

    enum Response {
        case hasDataView(_ response: [Address])
        case errorOnFetchDataView(_ message: String)
    }

    enum ViewModel {
        case success(_ viewModel: [AddressListViewModel])
        case error(_ viewModel: AddressListViewModel)
    }

    enum Route {
        case goToHome
        case showAllertError(_ message: String)
    }
}
