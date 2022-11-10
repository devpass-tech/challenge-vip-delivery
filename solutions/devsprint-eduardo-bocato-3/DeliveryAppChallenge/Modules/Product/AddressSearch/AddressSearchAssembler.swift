//
//  AddressSearchAssembler.swift
//  DeliveryAppChallenge
//
//  Created by Matheus Lenke on 10/11/22.
//

import UIKit

protocol AddressSearchAssembling {
    func makeViewController() -> UIViewController
}

struct AddressSearchAssembler: AddressSearchAssembling {
    
    func makeViewController() -> UIViewController {
        let viewController: AddressSearchViewController = .init()
        
        return viewController
    }
}
