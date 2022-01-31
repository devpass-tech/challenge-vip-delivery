//
//  HomePresenter.swift
//  DeliveryAppChallenge
//
//  Created by Leonardo Mendes on 30/01/22.
//

import Foundation

/// Protocol used to intermediate communication from Interactor to Presenter ( Interactor ----`response` ----> Presenter )
protocol HomePresentationLogic {
    func responseData(response: HomeUseCase.FetchData.Response)
    func responseError(response: HomeUseCase.Error.Response)
}

/// Class used to handle data from Interactor, preparing (and deciding how) data to be displated by ViewController
/// Interactor passes a request response to Presenter
/// Presenter hadle this response separating and formating data to be displayed
/// Presenter pass a viewModel with data that User need see to ViewController
final class HomePresenter: HomePresentationLogic {
    weak var viewController: HomeDisplayLogic?

    func responseData(response: HomeUseCase.FetchData.Response) {
        viewController?.displayViewModel(viewModel: HomeUseCase.FetchData.ViewModel())
    }

    func responseError(response: HomeUseCase.Error.Response) {
        viewController?.displayError(error: HomeUseCase.Error.ViewModel(message: "Ops, desculpe não conseguimos as informações"))
    }
}
