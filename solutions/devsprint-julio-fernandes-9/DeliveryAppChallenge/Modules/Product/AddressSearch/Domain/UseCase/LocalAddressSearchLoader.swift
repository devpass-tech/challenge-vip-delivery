//
//  LocalAddressSearchLoader.swift
//  DeliveryApp
//
//  Created by Renato F. dos Santos Jr on 20/02/23.
//

import Foundation
import UIKit

final class LocalAddressSearchLoader: LocalLoaderProtocol {

    private var items: [Address] = []

    func insert<T: Codable>(items: [T]) {
        // TODO: Is there repeated elements?
        /// if Yes, then:
        ///     Get non-repeated items
        /// else
        /// Append it do self.items
        guard let addressList = items as? [Address],
              !addressList.isEmpty else { return }
        self.items = addressList
    }

    func filter<T: Codable>(by value: String, completion: @escaping LocalLoaderResponse<T>) {
        let items: [Address] = items.filter { $0.contain(value: value) }
        guard let result = items as? T else { return }
        completion(result)
    }

}
