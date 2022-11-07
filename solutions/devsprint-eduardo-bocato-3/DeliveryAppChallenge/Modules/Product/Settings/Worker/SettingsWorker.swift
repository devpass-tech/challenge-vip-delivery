
import Foundation

protocol SettingsWorkerProtocol {
    func fetchSettings(completionHandler: @escaping (SettingsServiceResult) -> Void)
}

final class SettingsWorker: SettingsWorkerProtocol {
    
    private let settingsService: SettingsServiceProtocol
    
    init(settingsService: SettingsServiceProtocol) {
        self.settingsService = settingsService
    }
    
    func fetchSettings(completionHandler: @escaping (SettingsServiceResult) -> Void) {
        settingsService.fetchSettings { result in
            DispatchQueue.main.async {
                completionHandler(result)
            }
        }
    }
}
