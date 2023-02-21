//
//  AddressSearchLoaderDecorator.swift
//  DeliveryApp
//
//  Created by Renato F. dos Santos Jr on 20/02/23.
//

import Foundation

final class AddressSearchLoaderDecorator {

    let decoratee: RemoteLoaderProtocol
    let local: LocalAddressSearchLoaderProtocol

    init(decoratee: RemoteAddressSearchLoader, local: LocalAddressSearchLoaderProtocol) {
        self.decoratee = decoratee
        self.local = local
    }
}

extension AddressSearchLoaderDecorator: RemoteLoaderProtocol {

    func doRequest<T>(_ request: NetworkRequest, completion: @escaping LoaderResponse<T>) where T : Decodable {
        decoratee.doRequest(request) { [weak self] (result: Result<[Address], Error>) in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                self.local.insert(items: response)
                guard let decorateeResponse = response as? T else { return }
                completion(.success(decorateeResponse))
            default:
                // TODO: To be implemented
                break
            }
        }
    }

}
