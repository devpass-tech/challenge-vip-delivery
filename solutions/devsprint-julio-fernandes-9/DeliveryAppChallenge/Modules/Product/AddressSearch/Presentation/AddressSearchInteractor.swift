//
//  AddressSearchInteractor.swift
//  DeliveryAppChallenge
//
//  Created by Renato F. dos Santos Jr on 10/02/23.
//

import Foundation

protocol AddressSearchInteractorProtocol: AnyObject {
    var presenter: AddressSearchPresenterProtocol? { get set }
}

final class AddressSearchInteractor: AddressSearchInteractorProtocol {

    var presenter: AddressSearchPresenterProtocol?

}
