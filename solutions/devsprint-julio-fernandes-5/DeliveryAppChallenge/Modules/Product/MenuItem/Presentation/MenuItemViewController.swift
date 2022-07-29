//
//  MenuItemViewController.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 31/10/21.
//

import UIKit

class MenuItemViewController: UIViewController {
    
    let interactor: MenuItemInteractorProtocol
    
    init(interactor: MenuItemInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = MenuItemView()
    }
}

extension MenuItemViewController: MenuItemViewControllerOutput {
    func showData() {
        print("data")
    }
    
    func showError() {
        print("error")
    }
}
