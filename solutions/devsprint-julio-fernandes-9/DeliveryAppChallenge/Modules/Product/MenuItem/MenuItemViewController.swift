//
//  MenuItemViewController.swift
//  DeliveryAppChallenge
//
//  Created by Alexandre Robaert on 21/02/23.
//  Copyright (c) 2023 Alexandre Robaert. All rights reserved.
//

import UIKit

protocol MenuItemDisplayLogic where Self: UIViewController {
    
    func displayViewModel(_ viewModel: MenuItemModel.ViewModel)
}

final class MenuItemViewController: UIViewController {
    
    private let mainView: MenuItemViewProtocol
    private let interactor: MenuItemBusinessLogic
    private let router: MenuItemRouting
    
    init(mainView: MenuItemViewProtocol = MenuItemView(),
         interactor: MenuItemBusinessLogic, router: MenuItemRouting) {
        
        self.mainView = mainView
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Menu"
        navigationController?.navigationBar.prefersLargeTitles = false
        interactor.doRequest(.fetchMenuItem)
    }
    
    override func loadView() {
        mainView.delegate = self
        view = mainView
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented, You should't initialize the ViewController through Storyboards")
    }
}

// MARK: - MenuItemDisplayLogic
extension MenuItemViewController: MenuItemDisplayLogic {
    
    func displayViewModel(_ viewModel: MenuItemModel.ViewModel) {
        DispatchQueue.main.async {
            switch viewModel {
            case .dataMenuItem(let item):
                self.mainView.item = item
            case .presentAlertMessage(let message):
                self.router.routeTo(.goToMessageError(message: message))
            }
        }
    }
}

// MARK: - MenuItemViewDelegate
extension MenuItemViewController: MenuItemViewDelegate {
    func didTapAddCart() {
        router.routeTo(.goToAddCartMessage)
    }
}
