protocol CoreDataManagerProtocol {
    func request<T: Decodable>(completion: @escaping (Result<T, Error>) -> Void)
}

final class CoreDataManager: CoreDataManagerProtocol {
    func request<T: Decodable>(completion: @escaping (Result<T, Error>) -> Void) {}
}
