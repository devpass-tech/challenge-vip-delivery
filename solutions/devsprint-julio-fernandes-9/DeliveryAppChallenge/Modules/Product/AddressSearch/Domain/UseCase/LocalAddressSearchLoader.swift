//
//  LocalAddressSearchLoader.swift
//  DeliveryApp
//
//  Created by Renato F. dos Santos Jr on 20/02/23.
//

import Foundation
import UIKit

// TODO: To be implemented
protocol LocalLoaderProtocol: AnyObject {
    typealias LocalLoaderResponse<T: Codable> = ((T) -> Void)
    func insert<T: Codable>(items: [T])
    func filter<T: Codable>(by value: String,
                            completion: @escaping LocalLoaderResponse<T>)
}

protocol LocalAddressSearchLoaderProtocol: AnyObject {
    typealias LocalResponse = (([Address]) -> Void)
    func insert(items: [Address])
    func filter(by value: String, completion: @escaping LocalResponse)
}

final class LocalAddressSearchLoader: LocalAddressSearchLoaderProtocol {

    private var localItems: [Address] = []

    func insert(items: [Address]) {
        // Is there repeated elements?
        /// NO
        ///     Get non-repeated items
        // Append it do self.items
        guard !items.isEmpty else { return }
        self.localItems = items
    }

    func filter(by value: String, completion: @escaping LocalResponse) {
        let items: [Address] = localItems.filter { $0.contain(value: value) }
        completion(items)
    }

}
