@testable import DeliveryAppChallenge

final class DevPassBusinessLogicSpy: DevPassBusinessLogic {

    private(set) var fetchDataCalledCount: Int = 0
    private(set) var fetchDataRequestPassed: DevPass.FetchData.Request?

    func fetchData(request: DevPass.FetchData.Request) {
        fetchDataCalledCount += 1
        fetchDataRequestPassed = request
    }
}
