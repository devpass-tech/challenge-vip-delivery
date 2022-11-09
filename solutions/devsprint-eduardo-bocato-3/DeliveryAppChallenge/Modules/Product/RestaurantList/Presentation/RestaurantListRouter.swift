////
////  RestaurantListRouter.swift
////  DeliveryAppChallenge
////
////  Created by Matheus Lenke on 08/11/22.
////
//
//import Foundation
//import UIKit
//
//protocol RestaurantListRoutingLogic: AnyObject {
//    func routeToErrorAlert(_ data: ExampleScene.AlertData)
//    func routeToSelectedRestaurant()
//}
//
//protocol ExampleDataPassing: AnyObject {
//    var dataStore: ExampleDataStore? { get set }
//}
//
//final class ExampleRouter: ExampleRoutingLogic, ExampleDataPassing {
//    // MARK: - Dependencies
//
//    typealias ViewController = UIViewController
//    private weak var viewController: ViewController!
//    private let makeAlertBuilder: () -> AlertBuilding
//
//    // MARK: - Properties
//
//    var dataStore: ExampleDataStore?
//
//    // MARK: - Initialization
//
//    init(
//        viewController: ViewController,
//        makeAlertBuilder: @escaping () -> AlertBuilding = AlertBuilder.init
//    ) {
//        self.viewController = viewController
//        self.makeAlertBuilder = makeAlertBuilder
//    }
//
//    // MARK: - ExampleRoutingLogic
//
//    func routeToErrorAlert(_ data: ExampleScene.AlertData) {
//        let alertController = makeOKAlert(with: data)
//        viewController.present(alertController, animated: true)
//    }
//
//    func routeToSelectedItem() {
//        guard let selectedItem = dataStore?.selectedItem else { return }
//        let data: ExampleScene.AlertData = .init(
//            title: selectedItem.name,
//            message: selectedItem.fullDescription
//        )
//        let alertController = makeOKAlert(
//            with: data,
//            okActionHandler: { [weak self] in
//                self?.dataStore?.selectedItem = nil
//            }
//        )
//        viewController.present(alertController, animated: true)
//    }
//
//    // MARK: - Helpers
//
//    private func makeOKAlert(
//        with data: ExampleScene.AlertData,
//        okActionHandler: (() -> Void)? = nil
//    ) -> UIAlertController {
//        let okAction: AlertAction = .init(
//            title: "OK",
//            style: .default,
//            handler: okActionHandler
//        )
//        let builder = makeAlertBuilder()
//        return builder
//            .setTitle(data.title)
//            .setMessage(data.message)
//            .setStyle(.alert)
//            .addAction(okAction)
//            .build()
//    }
//}
//
