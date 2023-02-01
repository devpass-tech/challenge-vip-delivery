//
//  SampleRouter.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 21/01/22.
//

import Foundation
import UIKit

protocol SampleRoutingLogic {
    func routeToNextModule()
}

protocol SampleDataPassing {
    var dataStore: SampleDataStore? { get }
}

typealias SampleRouterType = (SampleRoutingLogic & SampleDataPassing)

final class SampleRouter: SampleRoutingLogic, SampleDataPassing {
    weak var viewController: SampleViewController?
    var dataStore: SampleDataStore?

    init() {
    }

    func routeToNextModule() {
        let newViewController = UIViewController()

        viewController?.navigationController?.pushViewController(newViewController, animated: true)
    }
}
