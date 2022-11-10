//
//  RestaurantListAssembler.swift
//  DeliveryAppChallenge
//
//  Created by Matheus Lenke on 08/11/22.
//

import UIKit

protocol RestaurantListAssembling {
    func makeViewController() -> UIViewController
}

struct RestaurantListAssembler: RestaurantListAssembling {
    
    func makeViewController() -> UIViewController {
        
        let presenter: RestaurantListPresenter = .init()
        
        let getRestaurantsUseCase: GetRestaurantsUseCase = .init(
            service: RestaurantListService()
        )
        
        let interactor: RestaurantListInteractor = .init(
            presenter: presenter,
            getRestaurantsUseCase: getRestaurantsUseCase
        )
        
        let tableViewDataSource: RestaurantListTableViewDataSource = .init()
        let tableViewDelegate: RestaurantListTableViewDelegate = .init()
        let view = RestaurantListView(tableViewDataSource: tableViewDataSource,
                                      tableViewDelegate: tableViewDelegate)
        let viewController: RestaurantListViewController = .init(
            customView: view,
            interactor: interactor,
            tableViewDataSource: tableViewDataSource,
            tableViewDelegate: tableViewDelegate
        )
        
//        let router: ExampleRouter = .init(
//            viewController: viewController
//        )
        
//        router.dataStore = interactor
        presenter.viewController = viewController
//        viewController.router = router
        
        return viewController
    }
}
