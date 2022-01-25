//
//  RestaurantDetails.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 27/10/21.
//

import UIKit

protocol RestaurantDetailsDisplayLogic: AnyObject {}

final class RestaurantDetailsViewController: UIViewController {

    override func loadView() {
        self.view = RestaurantDetailsView()
    }
}

//MARK: - RestaurantDetailsDisplayLogic Extension

extension RestaurantDetailsViewController: RestaurantDetailsDisplayLogic {}
