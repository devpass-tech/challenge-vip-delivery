//
//  RemoteLoaderProtocol.swift
//  DeliveryApp
//
//  Created by Renato F. dos Santos Jr on 20/02/23.
//

import Foundation

protocol RemoteLoaderProtocol: AnyObject {
    // TODO: How to inject/set NetworkManagerProtocol dependency properly?
    typealias RemoteLoaderResponse<T: Decodable> = ((Result<T, Error>) -> Void)
    func doRequest<T: Decodable>(_ request: NetworkRequest,
                                 completion: @escaping RemoteLoaderResponse<T>)
}
