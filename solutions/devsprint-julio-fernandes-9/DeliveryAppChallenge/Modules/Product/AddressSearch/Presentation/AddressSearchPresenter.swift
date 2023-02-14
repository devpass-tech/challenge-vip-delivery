//
//  AddressSearchPresenter.swift
//  DeliveryAppChallenge
//
//  Created by Renato F. dos Santos Jr on 10/02/23.
//

import Foundation

protocol AddressSearchPresenterProtocol: AnyObject {
    var controller: AddressSearchViewControllerProtocol? { get set } 
}

final class AddressSearchPresenter: AddressSearchPresenterProtocol {

    weak var controller: AddressSearchViewControllerProtocol?

}
