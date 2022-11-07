
import Foundation
@testable import DeliveryAppChallenge

final class SettingsPresenterSpy: SettingsPresentationLogic {
    
    private(set) var presentFetchSettings = false
    private(set) var presentFetchFailureSettings = false
    
    func presentSettingsList(response: SettingsList.FetchData.Response) {
        presentFetchSettings = true
    }
    
    func presentSettingsListFailure(error: SettingsList.FetchData.Error) {
        presentFetchFailureSettings = true
    }
}
