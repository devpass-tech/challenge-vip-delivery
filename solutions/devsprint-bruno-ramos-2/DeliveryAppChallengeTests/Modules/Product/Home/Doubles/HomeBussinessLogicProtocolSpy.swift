//
//  HomeBussinessLogicProtocolSpy.swift
//  DeliveryAppChallengeTests
//
//  Created by Leonardo Mendes on 06/02/22.
//

import Foundation
@testable import DeliveryAppChallenge

final class HomeBussinessLogicProtocolSpy: HomeBusinessLogic {

    private(set) var fetchHomeCalled = false
    private(set) var requestPassed: HomeUseCase.FetchData.Request?
    func fetchHome(request: HomeUseCase.FetchData.Request) {
        fetchHomeCalled = true
        requestPassed = request
    }
}
