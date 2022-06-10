//
//  RestaurantListViewController.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 27/10/21.
//

import UIKit

protocol RestaurantListDisplayLogic: AnyObject {
    func displayData(viewModel: RestaurantList.ViewModel)
}

class RestaurantListViewController: UIViewController {
    
    private let interactor: RestaurantListInteractor
    private let router: RestaurantListRoutingLogic
    private let customView: RestaurantListViewProtocol
    
    init(
        customView: RestaurantListViewProtocol,
        interactor: RestaurantListInteractor,
        router: RestaurantListRouterType
        
    ) {
        self.customView = customView
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
        
        navigationItem.title = "Restaurant List"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = customView
    }
}

extension RestaurantListViewController: RestaurantListDisplayLogic {
    func displayData(viewModel: RestaurantList.ViewModel) {
        customView.show(viewModel: viewModel)
    }
}
