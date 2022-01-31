//
//  HomeRouter.swift
//  DeliveryAppChallenge
//
//  Created by Leonardo Mendes on 30/01/22.
//

import Foundation

/// Protocol used to intermediate scene routes to another scene
protocol HomeRoutingLogic {
    func routeToNextModule()
}

/// Protocol used to pass data to another Scene
protocol HomeDataPassing {
    var dataStore: HomeDataStore? { get }
}

typealias HomeRouterType = (HomeRoutingLogic & HomeDataPassing)

/// Class used to navigate between scenes, ViewController calls Router (using RoutingLogic protocol) when need navigate to another scene
/// Router keep a data store to allow pass data needed on next scene
final class HomeRouter: HomeRouterType {
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?

    init() {}

    func routeToNextModule() {
        print("Should display next scene")
    }
}
