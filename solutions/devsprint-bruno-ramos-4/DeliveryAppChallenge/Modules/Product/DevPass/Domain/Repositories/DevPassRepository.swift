protocol DevPassRepository {
    func getSprints(completion: @escaping (Result<[DevPassDomain], Error>) -> Void)
}
