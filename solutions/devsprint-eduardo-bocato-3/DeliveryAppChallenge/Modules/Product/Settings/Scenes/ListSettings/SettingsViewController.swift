//
//  SettingsViewController.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 31/10/21.
//

import UIKit

protocol SettingsDisplayLogic: AnyObject {
    func displaySettings(viewModel: ListSettings.FetchData.ViewModel)
}

final class SettingsViewController: UIViewController {
    
    var interactor: SettingsBussinesLogic
    var customView: SettingsViewInterface

    init(customView: SettingsView, interactor: SettingsBussinesLogic) {
        self.interactor = interactor
        self.customView = customView
        
        super.init(nibName: nil, bundle: nil)

        navigationItem.title = "Settings"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    private func fetchData() {
        let request = ListSettings.FetchData.Request()
        interactor.fetchSettings(request: request)
    }
    
    override func loadView() {
        self.view = customView
    }
}

extension SettingsViewController: SettingsDisplayLogic {
    func displaySettings(viewModel: ListSettings.FetchData.ViewModel) {}
}
