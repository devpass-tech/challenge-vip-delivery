//
//  GetHomeUseCaseSpy.swift
//  DeliveryAppChallengeTests
//
//  Created by Leonardo Mendes on 06/02/22.
//

import Foundation
@testable import DeliveryAppChallenge

final class GetHomeUseCaseSpy: GetHomeUseCase {

    var executeCompletionToBeReturned: Result<Home, Error>?
    private(set) var executeCalled = false
    func execute(completion: @escaping GetHomeCompletion) {
        executeCalled = true

        if let executeCompletionData = executeCompletionToBeReturned {
            completion(executeCompletionData)
        }
    }
}
