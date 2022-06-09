@testable import DeliveryAppChallenge

final class DevPassRoutingLogicSpy: DevPassRoutingLogic {

    private(set) var routeToNextModuleCalledCount: Int = 0

    func routeToNextModule() {
        routeToNextModuleCalledCount += 1
    }
}
