//
//  RestaurantDetails.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 27/10/21.
//

import UIKit

class RestaurantDetailsViewController: UIViewController {
    
    let interactor: RestaurantDetailsInteractorProtocol
    
    lazy var content: RestaurantDetailsView = {
        return RestaurantDetailsView()
    }()
    
    init(interactor: RestaurantDetailsInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        nil
    }

    override func loadView() {
        self.view = content
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.fetchData()
    }
}

extension RestaurantDetailsViewController: RestaurantDetailsControllerOutput {
    func showData(_ data: RestaurantDetailViewModel) {
        DispatchQueue.main.async {
            self.content.fillRender(data: data)
        }
    }
    
    func showError() {
        print("show error")
    }
}
