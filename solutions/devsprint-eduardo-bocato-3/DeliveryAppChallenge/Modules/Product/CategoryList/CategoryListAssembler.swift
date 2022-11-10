//
//  CategoryListAssembler.swift
//  DeliveryAppChallenge
//
//  Created by Matheus Lenke on 10/11/22.
//

import UIKit

protocol CategoryListAssembling {
    func makeViewController() -> UIViewController
}

struct CategoryListAssembler: CategoryListAssembling {
    
    func makeViewController() -> UIViewController {
        
        let presenter: CategoryListPresenter = .init()

        let interactor: CategoryListInteractor = .init(
            presenter: presenter
        )
        
        let view = CategoryListView()
        let viewController: CategoryListViewController = .init(
            customView: view,
            interactor: interactor
        )
        
        presenter.viewController = viewController
        
        return viewController
    }
}
