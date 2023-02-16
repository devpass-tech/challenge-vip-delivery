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
        switch request {
        case .fetchDataView:
            self.fetchDataView()
        case let .filterBy(partialMatching):
            print("filter: \(partialMatching)")
        }
    }

}

private extension AddressSearchInteractor {

    private func fetchDataView() {
        network.request(AddressSearchRequest.fetchAllAdresses) { [weak self] (result: Result<[Address], Error>) in
            guard let self = self else { return }
            guard Thread.isMainThread else {
                DispatchQueue.main.async {
                    self.handleResult(result)
                }
                return
            }
            self.handleResult(result)
        }
    }

    private func handleResult(_ result: Result<[Address], Error>) {
        switch result {
        case let .success(response):
            presenter.presentResponde(.hasDataView(response))
        case let .failure(error):
            print(error.localizedDescription)
        }
    }

}
