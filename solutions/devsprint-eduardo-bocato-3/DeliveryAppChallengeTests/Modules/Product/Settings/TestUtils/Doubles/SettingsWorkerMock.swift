
import Foundation
@testable import DeliveryAppChallenge

final class SettingsWorkerMock: SettingsWorkerProtocol {
    
    private(set) var fetchSettingsCalled = false
    private(set) var completionHandlerPassed: ((SettingsServiceResult) -> Void)?
    var resultServiceReturned: SettingsServiceResult = .failure(error: .decodeFail)
    
    func fetchSettings(completionHandler: @escaping (SettingsServiceResult) -> Void) {
        fetchSettingsCalled = true
        completionHandlerPassed = completionHandler
        completionHandler(resultServiceReturned)
    }
}
