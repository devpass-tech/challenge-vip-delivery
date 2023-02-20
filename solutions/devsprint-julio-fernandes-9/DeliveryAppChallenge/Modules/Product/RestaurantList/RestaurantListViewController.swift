//
//  RestaurantListViewController.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Robaert on 19/02/23.
//  Copyright (c) 2023 Alexandre Robaert. All rights reserved.
//

import UIKit

protocol RestaurantListDisplayLogic where Self: UIViewController {
    func displayViewModel(_ viewModel: RestaurantListModel.ViewModel)
}

final class RestaurantListViewController: UIViewController {
    
    private let mainView: RestaurantListViewProtocol
    private let interactor: RestaurantListBusinessLogic
    private let router: RestaurantListRouting
    private let categoryFilter: String
    
    init(mainView: RestaurantListViewProtocol = RestaurantListView(),
         interactor: RestaurantListBusinessLogic,
         router: RestaurantListRouting, categoryFilter: String) {
        
        self.mainView = mainView
        self.interactor = interactor
        self.router = router
        self.categoryFilter = categoryFilter
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        mainView.delegate = self
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.doRequest(.fetchRestaurantList(category: categoryFilter))
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented, You should't initialize the ViewController through Storyboards")
    }
}

// MARK: - RestaurantListDisplayLogic
extension RestaurantListViewController: RestaurantListDisplayLogic {
    
    func displayViewModel(_ viewModel: RestaurantListModel.ViewModel) {
        DispatchQueue.main.async {
            switch viewModel {
            case .restaurantList(let restaurants):
                self.mainView.dataSource = restaurants
            case .fetchError(let message):
                print(message)
            }
        }
    }
}

// MARK: - RestaurantListViewDelegate
extension RestaurantListViewController: RestaurantListViewDelegate {
    func restaurantList(_ restaurantListView: RestaurantListView, didTap restaurant: RestaurantItemProtocol) {
        router.routeTo(.goToRestaurantDetail(restaurantName: restaurant.name))
    }
}
