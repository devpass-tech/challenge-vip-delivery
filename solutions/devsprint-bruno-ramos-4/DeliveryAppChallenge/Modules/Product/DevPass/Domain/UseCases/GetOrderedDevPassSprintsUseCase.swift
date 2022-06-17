import Foundation

protocol GetOrderedDevPassSprintsUseCase {
    func execute(completion: @escaping (Result<[DevPassDomain], Error>) -> Void)
}

final class GetOrderedDevPassSprints: GetDevPassSprintsUseCase {
    private let repository: DevPassRepository

    init(repository: DevPassRepository) {
        self.repository = repository
    }

    func execute(completion: @escaping (Result<[DevPassDomain], Error>) -> Void) {
        repository.getSprints { result in
            switch result {
            case .success(let devPassSprints):
                let reversedList = devPassSprints.reversed()
                completion(.success(Array(reversedList)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
