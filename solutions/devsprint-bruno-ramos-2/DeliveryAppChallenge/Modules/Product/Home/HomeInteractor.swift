//
//  HomeInteractor.swift
//  DeliveryAppChallenge
//
//  Created by Leonardo Mendes on 30/01/22.
//

import Foundation

/// Protocol used to intermediate communication from ViewController to Interactor ( ViewController ----`request` ----> Interactor )
protocol HomeBusinessLogic {
    func requestData(request: HomeUseCase.FetchData.Request)
}

/// Protocol used to intermediate communication from Interactor to Presenter ( Interactor ----`response` ----> Presenter )
protocol HomePresentationLogic {
    func responseData(response: HomeUseCase.FetchData.Response)
    func responseError(response: HomeUseCase.Error.Response)
}

/// Protocol used allow Router pass data thuru scenes
protocol HomeDataStore {}

/// Class used to mediate communication between worker and presenter,
/// ViewController start and passes the request parameter
/// Interactor validate reqeust params before pass it to Worker
/// Interactor passes the response from Worker to Presenter
final class HomeInteractor: HomeDataStore {
    private let presenter: HomePresentationLogic
    private let worker: HomeWorking

    init(presenter: HomePresentationLogic, worker: HomeWorking) {
        self.presenter = presenter
        self.worker = worker
    }
}

extension HomeInteractor: HomeBusinessLogic {
    func requestData(request: HomeUseCase.FetchData.Request) {
        worker.fetchData(completion: { [weak self]  result in
            guard let self = self else {
                return
            }

            switch result {
            case .success(let data):
                self.presenter.responseData(response: .init())
            case .failure(let error):
                self.presenter.responseError(response: .init(error: "Error" as! Error))
            }
        })
    }
}
