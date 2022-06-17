protocol DevPassDataSource {
    func fetchDevPassSprints(completion: @escaping (Result<[DevPassDomain], Error>) -> Void)
}
