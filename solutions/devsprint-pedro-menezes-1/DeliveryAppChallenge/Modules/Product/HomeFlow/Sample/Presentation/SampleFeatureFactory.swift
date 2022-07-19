//
//  SampleFeatureFactory.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 21/01/22.
//

import UIKit

enum SampleFeature: FeatureFactory {
    struct Dependencies {}

    static func make(with dependencies: Dependencies) -> UIViewController {

        let network = NetworkManager()
        let apiDataSource = SampleApiDataSource(network: network)
        let repository = SampleRepositoryImpl(dataSource: apiDataSource)
        let getData = GetData(repository: repository)
        let presenter = SamplePresenter()
        let router = SampleRouter()
        let interactor = SampleInteractor(presenter: presenter, getData: getData)
        let view = SampleView()
        let viewController = SampleViewController(customView: view, interactor: interactor, router: router)

        view.delegate = viewController
        router.dataStore = interactor
        presenter.viewController = viewController

        return viewController
    }
}
