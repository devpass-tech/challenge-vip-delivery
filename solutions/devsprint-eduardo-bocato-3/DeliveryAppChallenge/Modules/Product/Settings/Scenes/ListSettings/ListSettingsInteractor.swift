
import Foundation

protocol SettingsBussinesLogic {
    func loadSettings(request: SettingsList.FetchData.Request)
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
    
    func loadSettings(request: SettingsList.FetchData.Request) {
        settingsWorker.fetchSettings { result in
            switch result {
            case .success(let settings):
                let response = SettingsList.FetchData.Response(settings: settings)
                self.presenter.presentSettingsList(response: response)
            case .failure(let error):
                self.presenter.presentSettingsListFailure(error: error)
            }
        }
    }
}
