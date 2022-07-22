//
//  SampleViewController.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 21/01/22.
//

import UIKit

protocol SampleDisplayLogic: AnyObject {
    func displayData(viewModel: Sample.FetchData.ViewModel)
}

final class SampleViewController: UIViewController {
    private let interactor: SampleBusinessLogic
    private let router: SampleRoutingLogic
    private let customView: SampleViewProtocol

    // MARK: - Object lifecycle

    init(customView: SampleViewProtocol, interactor: SampleBusinessLogic, router: SampleRouterType) {
        self.customView = customView
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        nil
    }

    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }

    // MARK: - Do something

    private func fetchData() {
        let request = Sample.FetchData.Request()
        interactor.fetchData(request: request)
    }
}

extension SampleViewController: SampleDisplayLogic {

    func displayData(viewModel: Sample.FetchData.ViewModel) {

    }
}

extension SampleViewController: SampleViewDelegate {

    
}
