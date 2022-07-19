//
//  SamplePresenter.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 21/01/22.
//

import Foundation

protocol SamplePresentationLogic {
    func presentData(response: Sample.FetchData.Response)
    func presentError(response: Sample.Error.Response)
}

final class SamplePresenter {
    weak var viewController: SampleDisplayLogic?
}

extension SamplePresenter: SamplePresentationLogic {

    func presentData(response: Sample.FetchData.Response) {

        let viewModel = response.data

        viewController?.displayData(viewModel: .filled(data: viewModel))
    }

    func presentError(response: Sample.Error.Response) {

    }
}
