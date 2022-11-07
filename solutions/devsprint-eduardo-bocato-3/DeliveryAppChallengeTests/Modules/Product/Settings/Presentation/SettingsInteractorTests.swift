
import XCTest
@testable import DeliveryAppChallenge

final class SettingsInteractorTests: XCTestCase {

    private let presenterSpy = SettingsPresenterSpy()
    private let workerMock = SettingsWorkerMock()
    
    private var sut: SettingsInteractor {
        let interactor = SettingsInteractor(presenter: presenterSpy,
                                            settingsWorker: workerMock)
        return interactor
    }
    
    func testFetchSettings_ShouldAskWorkerSettingsToPresenterSuccessfuly() {
        
        // Given
        let request = SettingsList.FetchData.Request()
        workerMock.resultServiceReturned = .success(result: .fixture())
        
        // When
        sut.loadSettings(request: request)
        
        // Then
        XCTAssertTrue(presenterSpy.presentFetchSettings)
    }
    
    func testFetchSettings_ShouldAskWorkerSettingsToPresenterFailure() {
        
        // Given
        let request = SettingsList.FetchData.Request()
        workerMock.resultServiceReturned = .failure(error: .decodeFail)
        
        // When
        sut.loadSettings(request: request)
        
        // Then
        XCTAssertTrue(presenterSpy.presentFetchFailureSettings)
    }
}
