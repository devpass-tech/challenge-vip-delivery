//
//  AddressSearchLoaderDecorator.swift
//  DeliveryApp
//
//  Created by Renato F. dos Santos Jr on 20/02/23.
//

import Foundation

final class AddressSearchLoaderDecorator {

    let decoratee: RemoteLoaderProtocol
    let local: LocalLoaderProtocol

    init(decoratee: RemoteAddressSearchLoader, local: LocalLoaderProtocol) {
        self.decoratee = decoratee
        self.local = local
    }
}

extension AddressSearchLoaderDecorator: RemoteLoaderProtocol {

    func doRequest<T: Decodable>(_ request: NetworkRequest, completion: @escaping LoaderResponse<T>) {
        decoratee.doRequest(request) { [weak self] (result: Result<[Address], Error>) in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                self.local.insert(items: response)
                guard let decorateeResponse = response as? T else { return }
                completion(.success(decorateeResponse))
            default:
                guard let decorateeResult = result as? Result<T, any Error> else { return }
                completion(decorateeResult)
            }
        }
    }

}
