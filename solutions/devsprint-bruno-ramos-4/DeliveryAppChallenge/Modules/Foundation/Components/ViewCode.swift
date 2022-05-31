//
//  ViewCode.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 18/04/22.
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
