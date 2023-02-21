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
    private let localLoader: LocalAddressSearchLoaderProtocol

    private var items: [Address] = []

    init(presenter: AddressSearchPresentationLogicProtocol,
         remoteLoader: RemoteLoaderProtocol,
         localLoader: LocalAddressSearchLoaderProtocol) {
        self.presenter = presenter
        self.remoteLoader = remoteLoader
        self.localLoader = localLoader
    }

    func doRequest(_ request: AddressSearchModel.Request) {
        switch request {
        case .fetchDataView:
            self.fetchDataViewFromRemoteLoader()
        case let .filterBy(value):
            self.fetchDataViewFromLocalLoader(by: value)
        }
    }

}

private extension AddressSearchInteractor {

    private func fetchDataViewFromRemoteLoader() {
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

    private func fetchDataViewFromLocalLoader(by value: String) {
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
            presenter.presentResponse(.hasDataView(response))
        case let .failure(error):
            presenter.presentResponse(.errorOnFetchDataView(error.localizedDescription))
        }
    }

}
