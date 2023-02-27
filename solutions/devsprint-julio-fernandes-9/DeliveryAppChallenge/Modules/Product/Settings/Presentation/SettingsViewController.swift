//
//  SettingsViewController.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Robaert on 12/02/23.
//  Copyright (c) 2023 Alexandre Robaert. All rights reserved.
//

import UIKit

protocol SettingsDisplayLogic where Self: UIViewController {
    func displayViewModel(_ viewModel: SettingsModel.ViewModel)
}

final class SettingsViewController: UIViewController {
    
    private let mainView: SettingsViewProtocol
    private let interactor: SettingsBusinessLogic
    private let router: SettingsRouting
    
    init(mainView: SettingsViewProtocol = SettingsView(), interactor: SettingsBusinessLogic, router: SettingsRouting) {
        self.mainView = mainView
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Configurações"
        navigationController?.navigationBar.prefersLargeTitles = false
        interactor.doRequest(.fetchDataView)
    }
    
    override func loadView() {
        view = mainView
        mainView.delegate = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("")
    }
}


// MARK: - SettingsDisplayLogic
extension SettingsViewController: SettingsDisplayLogic {
    
    func displayViewModel(_ viewModel: SettingsModel.ViewModel) {
        DispatchQueue.main.async {
            switch viewModel {
            case .dataView(let entity):
                self.mainView.model = entity
            case .dataViewWithError(let messageError):
                print(#function, messageError)
            }
        }
    }
}


// MARK: - SettingsViewDelegate
extension SettingsViewController: SettingsViewDelegate {
    
    func didTapAddress() {
        router.routeTo(.goToEditAddress)
    }
}
