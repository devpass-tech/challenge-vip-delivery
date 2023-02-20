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
    private let remoteLoader: RemoteLoaderProtocol
    private let localLoader: LocalAddressSearchLoaderprotocol = LocalAddressSearchLoader()

    private var items: [Address] = []

    init(presenter: AddressSearchPresentationLogicProtocol,
         remoteLoader: RemoteLoaderProtocol) {
        self.presenter = presenter
        self.remoteLoader = remoteLoader
    }

    func doRequest(_ request: AddressSearchModel.Request) {
        switch request {
        case .fetchDataView:
            self.fetchDataView()
        case let .filterBy(value):
            self.fetchData(by: value)
        }
    }

}

private extension AddressSearchInteractor {

    private func fetchDataView() {
        remoteLoader.doRequest(AddressSearchRequest.fetchAllAdresses) { [weak self] (result: Result<[Address], Error>) in
            guard let self = self else { return }
            guard Thread.isMainThread else {
                DispatchQueue.main.async {
                    self.handleAndPresentResult(result)
                }
                return
            }
            self.handleAndPresentResult(result)
        }
    }
}

private extension AddressSearchInteractor {

    private func fetchData(by value: String) {
        localLoader.filter(by: value) { [weak self] (result: [Address]) in
            guard let self = self else { return }
            self.handleAndPresentResult(.success(result))
        }

    }
}

private extension AddressSearchInteractor {

    private func handleAndPresentResult(_ result: Result<[Address], Error>) {
        switch result {
        case let .success(response):
            localLoader.insert(items: response)
            presenter.presentResponde(.hasDataView(response))
        case let .failure(error):
            print(error.localizedDescription)
        }
    }

}
