import Foundation

@testable import DeliveryAppChallenge

final class RestaurantDetailsWorkingStub: RestaurantDetailsWorking {
    
    private(set) var fetchDataCalled = false
    var fetchDataCompletionToBeExecuted: Result<RestaurantDetailsResponse, APIError>?
    
    func fetchData(completion: @escaping (Result<RestaurantDetailsResponse, APIError>) -> Void) {
        fetchDataCalled = true
        
        if let fetchDataCompletionToBeExecuted = fetchDataCompletionToBeExecuted {
            completion(fetchDataCompletionToBeExecuted)
        }
    }
}
