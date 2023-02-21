//
//  RemoteAddressSearchLoader.swift
//  DeliveryApp
//
//  Created by Renato F. dos Santos Jr on 20/02/23.
//

import Foundation

final class RemoteAddressSearchLoader: RemoteLoaderProtocol {

    private let networking: NetworkManagerProtocol

    init(networking: NetworkManagerProtocol) {
        self.networking = networking
    }

    func doRequest<T>(_ request: NetworkRequest,
                      completion: @escaping LoaderResponse<T>) where T : Codable {
        networking.request(request, completion: completion)
    }

}
