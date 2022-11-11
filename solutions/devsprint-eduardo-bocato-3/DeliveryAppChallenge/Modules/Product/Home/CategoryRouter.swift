//
//  CategoryRouter.swift
//  DeliveryAppChallenge
//
//  Created by Aby Mathew on 11/11/22.
//

import Foundation
import UIKit


protocol CategoryRoutingLogic: AnyObject {
    func routeToSelectedCategoryItemm()
}

protocol CategoryDataPassing: AnyObject {
    var dataStore: CategoryDataStore? { get set }
}

final class CategoryRouter: CategoryRoutingLogic, CategoryDataPassing {


    //MARK: Dependencies
    typealias ViewController = UIViewController
    private weak var viewController: ViewController!

    //MARK: Properties
    var dataStore: CategoryDataStore?

    //MARK: Initialization
    init(viewController: ViewController){
        self.viewController = viewController
    }

    //MARK: CategoryRoutingLogic
    func routeToSelectedCategoryItemm() {
        guard let categoryItem = dataStore?.selectedCategory else { return }
        debugPrint("Route to selected Item, CategoryRoutingLogic method Implemention")

    }
}
