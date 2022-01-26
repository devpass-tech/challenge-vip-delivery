import Foundation

@testable import DeliveryAppChallenge

final class RestaurantDetailsWorkingStub: RestaurantDetailsWorking {

    private(set) var fetchDataCalled = false
    var fetchDataCompletionToBeExecuted: Result<String, Error>?

    func fetchData(completion: @escaping (Result<String, Error>) -> Void) {
        fetchDataCalled = true

        if let fetchDataCompletionToBeExecuted = fetchDataCompletionToBeExecuted {
            completion(fetchDataCompletionToBeExecuted)
        }
    }
}
