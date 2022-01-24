//
//  ViewCode.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 21/01/22.
//

protocol ViewCode {
    func setup()
    func setupComponents()
    func setupConstraints()
    func setupExtraConfiguration()
}

extension ViewCode {
    func setup() {
        setupComponents()
        setupConstraints()
        setupExtraConfiguration()
    }

    func setupExtraConfiguration() {}
}
