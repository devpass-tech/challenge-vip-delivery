//
//  RestaurantListFactory.swift
//  DeliveryAppChallenge
//
//  Created by Cora on 07/02/23.
//

import UIKit

enum RestaurantListFactory {
    func build() -> UIViewController {
        let presenter = RestaurantListPresenter()
        let interactor = RestaurantListInteractor(presenter: presenter)
        let controller = RestaurantListViewController(interactor: interactor)
        presenter.controller = controller
        return controller
    }
}
