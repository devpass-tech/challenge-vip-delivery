//
//  SceneDelegate.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 25/10/21.
//

import UIKit

//import Domain
//import UI
//import Data

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        let viewController = DevPassConfigurator.make()

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = UINavigationController(rootViewController: viewController)
        self.window?.windowScene = windowScene
        self.window?.makeKeyAndVisible()
    }
}

enum DevPassConfigurator {
    static func make() -> UIViewController {
        let presenter = DevPassPresenter()
        let network = NetworkManager()
        let cacheDataSource = DevPassCacheDataSource(coreData: CoreDataManager())
        let apiDataSource = DevPassApiDataSource(network: network)
        let repository = DevPassRepositoryImplementation(
            primaryDataSource: cacheDataSource,
            secondDataSource: apiDataSource
        )
        let getDevPassSprintsUseCase = GetDevPassSprints(repository: repository)
        let interactor = DevPassInteractor(presenter: presenter, getDevPassSprintsUseCase: getDevPassSprintsUseCase)
        let router = DevPassRouter()
        let view = DevPassView()
        let viewController = DevPassViewController(
            contentView: view,
            interactor: interactor,
            router: router
        )
        view.delegate = viewController
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }
}

