//
//  RestaurantDetails.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 27/10/21.
//

import UIKit

protocol RestaurantDetailsDisplayLogic: AnyObject {
    func displayData(viewModel: RestaurantDetails.ViewModel)
}

final class RestaurantDetailsViewController: UIViewController {
    private let interactor: RestaurantDetailsBusinessLogic
    private let router: RestaurantDetailsRoutingLogic
    private let customView: RestaurantDetailsViewProtocol

    // MARK: - Object lifecycle

    init(
        customView: RestaurantDetailsViewProtocol,
        interactor: RestaurantDetailsBusinessLogic,
        router: RestaurantDetailsRoutingLogic
    ) {
        self.customView = customView
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = customView
    }
}

extension RestaurantDetailsViewController: RestaurantDetailsDisplayLogic {
    func displayData(viewModel: RestaurantDetails.ViewModel) {
        customView.show(viewModel: viewModel)
    }
}
