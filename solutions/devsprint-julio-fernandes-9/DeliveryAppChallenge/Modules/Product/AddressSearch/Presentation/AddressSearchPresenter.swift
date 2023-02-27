//
//  AddressSearchPresenter.swift
//  DeliveryAppChallenge
//
//  Created by Renato F. dos Santos Jr on 10/02/23.
//

import Foundation

protocol AddressSearchPresentationLogicProtocol: AnyObject {
    var controller: AddressSearchDisplayLogicProtocol? { get set }
    func presentResponse(_ response: AddressSearchModel.Response)
}

final class AddressSearchPresenter: AddressSearchPresentationLogicProtocol {

    weak var controller: AddressSearchDisplayLogicProtocol?

    func presentResponse(_ response: AddressSearchModel.Response) {
        switch response {
        case let .hasDataView(response):
            let response = response.map( { $0.getFullAddress() })
            let items: [AddressListViewModel] = response.map({
                .init(title: $0.streetWithNumber, subtitle: $0.neighborhood)
            })
            controller?.display(.success(items))
        case let .errorOnFetchDataView(message):
            controller?.display(.error(message))
        }
    }
}
