//
//  HomePresenter.swift
//  DeliveryAppChallenge
//
//  Created by Leonardo Mendes on 30/01/22.
//

import Foundation

/// Protocol used to intermediate communication from Interactor to Presenter ( Interactor ----`response` ----> Presenter )
protocol HomePresentationLogic {
    func presentHomeData(response: HomeUseCase.FetchData.Response)
}

/// Class used to handle data from Interactor, preparing (and deciding how) data to be displated by ViewController
/// Interactor passes a request response to Presenter
/// Presenter hadle this response separating and formating data to be displayed
/// Presenter pass a viewModel with data that User need see to ViewController
final class HomePresenter: HomePresentationLogic {
    weak var viewController: HomeDisplayLogic?

    func presentHomeData(response: HomeUseCase.FetchData.Response) {
        viewController?.displayHome(viewModel: HomeUseCase.FetchData.ViewModel())
    }
}
