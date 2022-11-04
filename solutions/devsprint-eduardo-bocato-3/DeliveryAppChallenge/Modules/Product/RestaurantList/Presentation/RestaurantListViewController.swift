//
//  RestaurantListViewController.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 27/10/21.
//

import UIKit

protocol RestaurantListDisplayLogic: AnyObject {
    func displayData(viewModel: RestaurantList.FetchRestaurants.ViewModel)
}

class RestaurantListViewController: UIViewController {
    private let interactor: RestaurantListBusinessLogic
    private let customView: RestaurantListView
    
    private let tableViewDataSource: RestaurantListTableViewDataSource
    private let tableViewDelegate: RestaurantListTableViewDelegate
    
    var items: [Restaurant] = []

    init(customView: RestaurantListView,
         interactor: RestaurantListBusinessLogic,
         tableViewDataSource: RestaurantListTableViewDataSource,
         tableViewDelegate: RestaurantListTableViewDelegate
    ) {
        self.customView = customView
        self.interactor = interactor
        self.tableViewDelegate = tableViewDelegate
        self.tableViewDataSource = tableViewDataSource
        super.init(nibName: nil, bundle: nil)

        navigationItem.title = "Restaurant List"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    private func fetchData() {
        let request = RestaurantList.FetchRestaurants.Request()
        interactor.fetchData(request: request)
    }
}

extension RestaurantListViewController: RestaurantListDisplayLogic {
    func displayData(viewModel: RestaurantList.FetchRestaurants.ViewModel) {
        tableViewDataSource.items = viewModel.items
        DispatchQueue.main.async {
//            self.customView?.reloadTableView()
        }
    }
}
