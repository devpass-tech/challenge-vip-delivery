//
//  HomeViewConfigurator.swift
//  DeliveryApp
//
//  Created by Julio Fernandes on 26/07/22.
//

import UIKit

enum HomeViewConfigurator: FeatureFactory {
    
    struct Dependencies {}
    
    static func make(with dependencies: Dependencies) -> UIViewController {
        let presenter = HomeViewPresenter()
        let interactor = HomeViewInteractor(presenter: presenter)
        let controller = HomeViewController(interactor: interactor)
        presenter.controller = controller
        return controller
    }
}
