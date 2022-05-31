//
//  SampleInteractor.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 21/01/22.
//

import Foundation

protocol SampleBusinessLogic {
    func fetchData(request: Sample.FetchData.Request)
}

protocol SampleDataStore {

}

final class SampleInteractor:  SampleDataStore {
    private let presenter:  SamplePresentationLogic
    private let getData: GetSampleUseCase


    init(
        presenter:  SamplePresentationLogic,
        getData: GetSampleUseCase
    ) {
        self.presenter = presenter
        self.getData = getData
    }
}

extension SampleInteractor: SampleBusinessLogic {
    func fetchData(request: Sample.FetchData.Request) {
        getData.execute() { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let data):
                self.presenter.presentData(response: .init(data: data.data))
            case .failure(let error):
                self.presenter.presentError(response: .init(error: error))
            }

        }
    }
}
