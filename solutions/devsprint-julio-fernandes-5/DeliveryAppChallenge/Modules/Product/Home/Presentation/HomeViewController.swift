//
//  ViewController.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 25/10/21.
//

import UIKit

final class HomeViewController: UIViewController {
    
    let interactor: HomeViewInteractorProtocol
    
    init(interactor: HomeViewInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        nil
    }

    override func viewDidLoad() {
        navigationItem.title = "Delivery App"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        interactor.fetchData()
    }
    
    override func loadView() {
        self.view = HomeView()
    }
}

extension HomeViewController: HomeViewControllerOutput {
    func showData() {
        print(">>>> Dados exibidos com sucesso")
    }
    
    func showError() {
        print(">>>> Erro ao baixar os dados")
    }
    
}
