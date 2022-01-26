//
//  RestaurantListViewController.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 27/10/21.
//

import UIKit

protocol RestaurantListDisplayLogic: AnyObject {}

final class RestaurantListViewController: UIViewController {
    
    // MARK: - Properties
    private let interactor: RestaurantListBusinessLogic
    private let router: RestaurantListRoutingLogic
    private let customView: RestaurantListViewProtocol

    init(customView: RestaurantListViewProtocol, interactor: RestaurantListBusinessLogic, router: RestaurantListRoutingLogic) {
        self.customView = customView
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)

        navigationItem.title = "Restaurant List"
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = customView
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - DisplayLogic
extension RestaurantListViewController: RestaurantListDisplayLogic {}

// MARK: - ViewDelegate
extension RestaurantListViewController: RestaurantListViewDelegate {}
