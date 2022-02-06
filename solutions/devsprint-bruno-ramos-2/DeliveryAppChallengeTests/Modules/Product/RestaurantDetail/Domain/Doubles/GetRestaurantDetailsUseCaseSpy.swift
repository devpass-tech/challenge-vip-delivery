import Foundation

@testable import DeliveryAppChallenge

final class GetRestaurantDetailsUseCaseSpy: GetRestaurantDetailsUseCase {
    private(set) var executeCalled = false
    var executeCompletionToBeExecuted: Result<RestaurantDetails, Error>?

    func execute(request: GetRestaurantDetailsUseCaseRequest, completion: @escaping (Result<RestaurantDetails, Error>) -> Void) {
        executeCalled = true
        if let executeCompletionToBeExecuted = executeCompletionToBeExecuted {
            completion(executeCompletionToBeExecuted)
        }
    }
}
