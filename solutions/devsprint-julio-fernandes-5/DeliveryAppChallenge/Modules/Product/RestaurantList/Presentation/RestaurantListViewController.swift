//
//  RestaurantListViewController.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 27/10/21.
//

import UIKit

final class RestaurantListViewController: UIViewController {
    
    let interactor: RestaurantListInteractorProtocol

    init(interactor: RestaurantListInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        navigationItem.title = "Restaurant List"
    }

    override func loadView() {
        self.view = RestaurantListView(delegate: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            interactor.fetchData()
        }
}

extension RestaurantListViewController: RestaurantListViewControllerOutput {
    func showData() {}
    
    func showError() {}
}

extension RestaurantListViewController: RestaurantListViewdelegate {
    func didSelectRestaurant(_ data: RestaurantDetailResponse) {
        let controller = RestaurantDetailsViewController()
        show(controller, sender: self)
    }
}
