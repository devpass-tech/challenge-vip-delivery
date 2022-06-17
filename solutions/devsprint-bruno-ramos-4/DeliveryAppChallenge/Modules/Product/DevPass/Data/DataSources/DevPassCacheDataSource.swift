import Foundation

final class DevPassCacheDataSource: DevPassDataSource {
    private let coreData: CoreDataManagerProtocol

    init(coreData: CoreDataManagerProtocol) {
        self.coreData = coreData
    }

    func fetchDevPassSprints(completion: @escaping (Result<[DevPassDomain], Error>) -> Void) {
        coreData.request { (result: Result<DevPassResponse, Error>) in
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
