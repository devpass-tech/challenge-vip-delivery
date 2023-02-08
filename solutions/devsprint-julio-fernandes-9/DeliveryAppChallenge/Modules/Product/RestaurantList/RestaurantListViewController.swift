//
//  RestaurantListViewController.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 27/10/21.
//

import UIKit

protocol RestaurantListViewControllerProtocol: AnyObject {
    
}

class RestaurantListViewController: UIViewController, RestaurantListViewControllerProtocol {
    
    private let interactor: RestaurantListInteractorProtocol

    init(interactor: RestaurantListInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = "Restaurant List"
    }

    required init?(coder: NSCoder) { nil }

    override func loadView() {
        self.view = RestaurantListView()
    }
}
