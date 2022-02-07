//
//  HomePresentationLogicSpy.swift
//  DeliveryAppChallengeTests
//
//  Created by Leonardo Mendes on 06/02/22.
//

import Foundation
@testable import DeliveryAppChallenge

final class HomePresentationLogicSpy: HomePresentationLogic {

    private(set) var presentHomeDataCalled = false
    private(set) var responsePassed: HomeUseCase.FetchData.Response?
    func presentHomeData(response: HomeUseCase.FetchData.Response) {
        self.presentHomeDataCalled = true
        self.responsePassed = response
    }
}
