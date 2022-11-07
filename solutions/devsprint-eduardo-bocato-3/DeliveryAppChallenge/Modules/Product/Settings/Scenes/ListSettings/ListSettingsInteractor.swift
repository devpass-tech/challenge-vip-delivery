
import Foundation

protocol SettingsBussinesLogic {
    func fetchSettings(request: ListSettings.FetchData.Request)
}

protocol SettingsDataStore {
    
}

final class SettingsInteractor: SettingsBussinesLogic {
    
    private let presenter: SettingsPresentationLogic
    private let settingsWorker: SettingsWorkerProtocol
    
    init(presenter: SettingsPresentationLogic, settingsWorker: SettingsWorkerProtocol) {
        self.presenter = presenter
        self.settingsWorker = settingsWorker
    }
    
    func fetchSettings(request: ListSettings.FetchData.Request) {
        settingsWorker.fetchSettings { result in
            switch result {
            case .Success(let settings):
                let response = ListSettings.FetchData.Response(settings: settings)
                self.presenter.presentFetchSettings(response: response)
            case .Failure(let error):
                self.presenter.presentFetchFailureSettings(error: error)
            }
        }
    }
}
