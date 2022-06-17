import Foundation

final class DevPassApiDataSource: DevPassDataSource {
    private let network: NetworkManagerProtocol

    init(network: NetworkManagerProtocol) {
        self.network = network
    }

    func fetchDevPassSprints(completion: @escaping (Result<[DevPassDomain], Error>) -> Void) {
        network.request(DevPassRequest()) { (result: Result<DevPassResponse, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let devPassResponse):
                    let devPass = [DevPassDomain(from: devPassResponse)]
                    completion(.success(devPass))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
