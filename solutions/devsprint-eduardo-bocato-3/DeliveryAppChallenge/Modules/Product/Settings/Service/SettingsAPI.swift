
import Foundation

protocol SettingsServiceProtocol {
    func fetchSettings(completion: @escaping (SettingsServiceResult) -> Void)
}

enum SettingsServiceResult {
    case success(result: Settings)
    case failure(error: SettingsList.FetchData.Error)
}

final class SettingsAPI: SettingsServiceProtocol {
    func fetchSettings(completion: @escaping (SettingsServiceResult) -> Void) {
        let settings = Settings(name: "John Appleseed",
                                email: "john@apple.com",
                                address: "Rua Bela Cintra, 495 - Consolação",
                                paymentMethod: "Cartão de Crédito")
        
        completion(.success(result: settings))
    }
}
