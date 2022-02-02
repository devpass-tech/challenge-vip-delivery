//
//  RestaurantDetails.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 27/10/21.
//

import UIKit

protocol RestaurantDetailsDisplayLogic: AnyObject {
    func displayRestaurantMenu(viewModel: RestaurantDetailsUseCases.FetchMenu.ViewModel)
}

final class RestaurantDetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    private let interactor: RestaurantDetailsBusinessLogic
    private let router: RestaurantDetailsRoutingLogic
    private let customView: RestaurantDetailsViewProtocol
    
    //MARK: - Inits
    
    init(customView: RestaurantDetailsViewProtocol, interactor: RestaurantDetailsBusinessLogic, router: RestaurantDetailsRoutingLogic) {
        self.customView = customView
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Object LifeCycle
    
    override func loadView() {
        self.view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.requestFetchRestaurantMenu(request: .init())
    }
}

//MARK: - RestaurantDetailsDisplayLogic Extension

extension RestaurantDetailsViewController: RestaurantDetailsDisplayLogic {
    func displayRestaurantMenu(viewModel: RestaurantDetailsUseCases.FetchMenu.ViewModel) {
        customView.display(.init(name: viewModel.name))
    }
}

//MARK: - RestaurantDetailsViewDelegate Extension

extension RestaurantDetailsViewController: RestaurantDetailsViewDelegate {
    
}
