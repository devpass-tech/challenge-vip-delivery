//
//  LoaderProtocol.swift
//  DeliveryApp
//
//  Created by Renato F. dos Santos Jr on 20/02/23.
//

import Foundation

protocol LocalLoaderProtocol: AnyObject {
    typealias LocalLoaderResponse<T: Codable> = ((T) -> Void)
    func insert<T: Codable>(items: [T])
    func filter<T: Codable>(by value: String,
                            completion: @escaping LocalLoaderResponse<T>)
}

protocol RemoteLoaderProtocol: AnyObject {
    // TODO: How to inject/set NetworkManagerProtocol dependency properly?
    typealias LoaderResponse<T: Codable> = ((Result<T, Error>) -> Void)
    func doRequest<T: Codable>(_ request: NetworkRequest,
                                 completion: @escaping LoaderResponse<T>)
}
