//
//  SettingsViewController.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 31/10/21.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    var interactor: SettingsBusinessLogic
    private var customView: SettingsCustomViewInterface

    init(customView: SettingsCustomViewInterface, interactor: SettingsBusinessLogic) {
        self.interactor = interactor
        self.customView = customView
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = "Settings"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor.loadData(request: .init())
    }
}

extension SettingsViewController: SettingsViewControllerDisplayLogic {
    
    func displayData(viewModel: SettingsList.LoadSettings.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.customView.displayItem(item: viewModel.item)
        }
    }
    
    func displayError(error: SettingsList.LoadSettings.Error) {
        let controller = UIAlertController(
            title: "Ops!",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        
        controller.addAction(.init(title: "Ok", style: .default))
        present(controller, animated: true)
    }
}
