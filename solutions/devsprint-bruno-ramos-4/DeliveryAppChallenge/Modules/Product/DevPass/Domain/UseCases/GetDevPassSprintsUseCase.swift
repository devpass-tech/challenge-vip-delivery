import Foundation

protocol GetDevPassSprintsUseCase {
    func execute(completion: @escaping (Result<[DevPassDomain], Error>) -> Void)
}

final class GetDevPassSprints: GetDevPassSprintsUseCase {
    private let repository: DevPassRepository

    init(repository: DevPassRepository) {
        self.repository = repository
    }

    func execute(completion: @escaping (Result<[DevPassDomain], Error>) -> Void) {
        repository.getSprints(completion: completion)
    }
}
