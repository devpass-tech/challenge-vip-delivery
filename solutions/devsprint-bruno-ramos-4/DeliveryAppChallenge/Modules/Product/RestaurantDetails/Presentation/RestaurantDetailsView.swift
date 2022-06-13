//
//  RestaurantDetailsView.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 03/11/21.
//

import UIKit

protocol RestaurantDetailsViewProtocol: UIView {
    func show(viewModel: RestaurantDetails.ViewModel)
}

final class RestaurantDetailsView: UIView {

    init() {
        super.init(frame: .zero)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RestaurantDetailsView: ViewCode {
    
    func setupExtraConfiguration() {
        backgroundColor = .white
    }
    
    func setupComponents() { }
    
    func setupConstraints() { }
    
}

extension RestaurantDetailsView: RestaurantDetailsViewProtocol {
    func show(viewModel: RestaurantDetails.ViewModel) { }
}
