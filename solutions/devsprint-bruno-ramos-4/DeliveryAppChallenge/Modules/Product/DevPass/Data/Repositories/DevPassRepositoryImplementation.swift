import Foundation

final class DevPassRepositoryImplementation: DevPassRepository {
    private let primaryDataSource: DevPassDataSource
    private let secondDataSource: DevPassDataSource

    init(
        primaryDataSource: DevPassDataSource,
        secondDataSource: DevPassDataSource
    ) {
        self.primaryDataSource = primaryDataSource
        self.secondDataSource = secondDataSource
    }

    func getSprints(completion: @escaping (Result<[DevPassDomain], Error>) -> Void) {
        primaryDataSource.fetchDevPassSprints { [weak self] result in
            guard let self = self else { return }

            if case .success(let devPassSprints) = result, devPassSprints.isEmpty == false {
                completion(.success(devPassSprints))
            }

            self.secondDataSource.fetchDevPassSprints(completion: completion)
        }
    }
}
