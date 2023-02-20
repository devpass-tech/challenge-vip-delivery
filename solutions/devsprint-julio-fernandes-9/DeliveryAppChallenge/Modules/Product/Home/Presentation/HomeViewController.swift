//
//  HomeViewController.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Robaert on 06/02/23.
//  Copyright (c) 2023 Alexandre Robaert. All rights reserved.
//

import UIKit

protocol HomeDisplayLogic where Self: UIViewController {
    func displayViewModel(_ viewModel: HomeModel.ViewModel)
}

final class HomeViewController: UIViewController {
    
    private let mainView: HomeViewProtocol
    private let interactor: HomeBusinessLogic
    private let router: HomeRouting
    
    init(mainView: HomeViewProtocol = HomeView(), interactor: HomeBusinessLogic, router: HomeRouting) {
        self.mainView = mainView
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        interactor.doRequest(.fetchDataView)
    }
    
    override func loadView() {
        view = mainView
        mainView.delegate = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented, You should't initialize the ViewController through Storyboards")
    }
    
    private func setup() {
        navigationItem.title = "Delivery App"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(goToSettings))
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc
    private func goToSettings() {
        router.routeTo(.goToSettings)
    }
}

// MARK: - HomeDisplayLogic
extension HomeViewController: HomeDisplayLogic {
    
    func displayViewModel(_ viewModel: HomeModel.ViewModel) {
        DispatchQueue.main.async {
            switch viewModel {
            case .dataView(let viewEntity):
                self.mainView.updateView(viewEntity: viewEntity)
            case .dataViewWithError(let messageError):
                self.router.routeTo(.showMessageError(message: messageError))
            }
        }
    }
}

// MARK: - HomeViewDelegate
extension HomeViewController: HomeViewDelegate {
    func didTapCategory(category: String) {
        router.routeTo(.goToRestaurantList(category: category))
    }
    
    func homeView(_ homeView: HomeView, didTap restaurant: RestaurantItemProtocol) {
        router.routeTo(.goToRestaurantDetail)
    }
        
    func didTapEditAddress() {
        router.routeTo(.goToEditAddress)
    }
}
