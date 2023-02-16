//
//  AddressSearchInteractor.swift
//  DeliveryAppChallenge
//
//  Created by Renato F. dos Santos Jr on 10/02/23.
//

import Foundation

protocol AddressSearchBusinessLogicProtocol: AnyObject {
    func doRequest(_ request: AddressSearchModel.Request)
}

final class AddressSearchInteractor: AddressSearchBusinessLogicProtocol {

    private let presenter: AddressSearchPresentationLogicProtocol
    private let network: NetworkManagerProtocol

    init(with presenter: AddressSearchPresentationLogicProtocol, and network: NetworkManagerProtocol) {
        self.presenter = presenter
        self.network = network
    }

    func doRequest(_ request: AddressSearchModel.Request) {
        DispatchQueue.main.async {
            switch request {
            case .fetchDataView:
                self.fetchDataView()
            case let .filterBy(filter: filter):
                print("filter: \(filter)")
            }
        }
    }

}

private extension AddressSearchInteractor {
    private func fetchDataView() {
        network.request(AddressSearchRequest.fetchAllAdresses) { [weak self] (result: Result<[Address], Error>) in
            guard self != nil else { return }
            switch result {
            case let .success(response):
                self?.presenter.presentResponde(.hasDataView(response))
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
