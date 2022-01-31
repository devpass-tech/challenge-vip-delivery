//
//  HomeViewController.swift
//  DeliveryAppChallenge
//
//  Created by Leonardo Mendes on 30/01/22.
//

import Foundation
import UIKit

/// Protocol used to intermediates communication from Presenter to ViewController ( Presenter ----`viewModel` ----> ViewController )
protocol HomeDisplayLogic: AnyObject {
    func displayViewModel(viewModel: HomeUseCase.FetchData.ViewModel)
    func displayError(error: HomeUseCase.Error.ViewModel)
}

/// Class use to handle user's intections with view, call requests to Interactor and send data (ViewModel) from Presenter to View display it
/// ViewController call Router when need to transit to another Scene
final class HomeViewController: UIViewController {
    private let interactor: HomeBusinessLogic
    private let router: HomeRoutingLogic
    private let customView: HomeViewProtocol

    init(customView: HomeViewProtocol, interactor: HomeBusinessLogic, router: HomeRoutingLogic) {
        self.interactor = interactor
        self.router = router
        self.customView = customView

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) hast not been implemented")
    }

    override func loadView() {
        self.view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.requestData(request: HomeUseCase.FetchData.Request())
    }
}

extension HomeViewController: HomeViewDelegate {

}

extension HomeViewController: HomeDisplayLogic {
    func displayViewModel(viewModel: HomeUseCase.FetchData.ViewModel) {
        customView.display(viewModel: HomeView.ViewModel())
    }

    func displayError(error: HomeUseCase.Error.ViewModel) {
        customView.display(viewModel: HomeView.ViewModel())
    }
}
